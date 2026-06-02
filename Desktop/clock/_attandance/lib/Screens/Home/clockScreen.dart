import 'package:_attandance/AttandanceService/attandanceService.dart';
import 'package:_attandance/SesssionManager/sessionManager.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen>
    with SingleTickerProviderStateMixin {
  final AttendanceService service = AttendanceService();
String userName = "";
  List projects = [];
  bool isLoading = true;
  bool isActionLoading = false;
  String? status;
  int? projectId;

  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  late Timer timer;
  DateTime now = DateTime.now();
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    fetchInitialData();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        now = DateTime.now().toLocal();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  /// FETCH PROJECTS
  Future<void> fetchInitialData() async {
    setState(() => isLoading = true);

    final data = await service.getProjects();

    projects = data;

    if (projects.isNotEmpty) {
      projectId = projects[0]['id'];
      status = await SessionManager.getStatus();
    } else {
      projectId = null;
      status = null;
    }
      // ✅ LOAD USER NAME
  final name = await SessionManager.getName();
  userName = name ?? "User";

  if (projects.isNotEmpty) {
    projectId = projects[0]['id'];
    status = await SessionManager.getStatus();
  } else {
    projectId = null;
    status = null;
  }

    setState(() => isLoading = false);
  }

  /// CLOCK IN
  Future<void> handleClockIn() async {
    if (projectId == null) return;

    setState(() => isActionLoading = true);

    final result = await service.clockIn(projectId!);

    setState(() => isActionLoading = false);

    if (result != null) {
      await fetchInitialData();
    } else {
      showError("Clock In failed. Please try again.");
    }
  }

  /// CLOCK OUT
  Future<void> handleClockOut() async {
    setState(() => isActionLoading = true);

    final result = await service.clockOut();

    setState(() => isActionLoading = false);

    if (result != null) {
      await fetchInitialData();
    } else {
      showError("Clock Out failed. Please try again.");
    }
  }

  String formatTime() {
    final localNow = DateTime.now().toLocal();

    return "${localNow.hour.toString().padLeft(2, '0')}:"
        "${localNow.minute.toString().padLeft(2, '0')}:"
        "${localNow.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xff1877F2)),
        ),
      );
    }

    if (projects.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text("No Project Assigned", style: TextStyle(fontSize: 18)),
        ),
      );
    }

    final project = projects[0];

   return Scaffold(
  body: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff0A4DA2), Color(0xff1EA5FC), Color(0xffEAF5FF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            /// 🔷 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Good Day 👋",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                /// Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  child: Text(
                    userName.isNotEmpty
                        ? userName[0].toUpperCase()
                        : "U",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0A4DA2),
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            /// 🕒 CLOCK CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.15),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(.25)),
              ),
              child: Column(
                children: [
                  const Text(
                    "LOCAL TIME",
                    style: TextStyle(
                      color: Colors.white70,
                      letterSpacing: 2,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    formatTime(),
                    style: const TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// 📁 PROJECT CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PROJECT",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    project['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// STATUS CHIP
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: status == "OPEN"
                          ? Colors.green.withOpacity(.15)
                          : Colors.orange.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status == "OPEN"
                          ? "CLOCKED IN"
                          : "READY TO CLOCK IN",
                      style: TextStyle(
                        color: status == "OPEN"
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// 🔘 ACTION BUTTON
            ScaleTransition(
              scale: _pulseAnimation,
              child: SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: status == "OPEN"
                        ? Colors.redAccent
                        : Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 10,
                  ),
                  onPressed: isActionLoading
                      ? null
                      : (status == "OPEN"
                          ? handleClockOut
                          : handleClockIn),
                  child: isActionLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
                          status == "OPEN"
                              ? "CLOCK OUT"
                              : "CLOCK IN",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    ),
  ),
);
  }
}
