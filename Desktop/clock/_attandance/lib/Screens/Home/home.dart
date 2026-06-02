import 'package:_attandance/Screens/Claims/claims.dart';
import 'package:_attandance/Screens/Home/clockScreen.dart';
import 'package:_attandance/Screens/Home/projectScreen.dart';
import 'package:_attandance/Screens/Leaves/leaves.dart';
import 'package:flutter/material.dart';


import 'package:_attandance/Screens/Claims/claims.dart';
import 'package:_attandance/Screens/Home/clockScreen.dart';
import 'package:_attandance/Screens/Home/projectScreen.dart';
import 'package:_attandance/Screens/Leaves/leaves.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final screens = [
    const ClockScreen(),
    const ProjectsScreen(),
    const ClaimsScreen(),
    const LeavesScreen(),
  ];

  final icons = [
    Icons.access_time_filled,
    Icons.work_outline,
    Icons.receipt_long,
    Icons.event_available,
  ];

  final labels = [
    "Attendance",
    "Projects",
    "Claims",
    "Leaves",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      /// 🔥 PROFESSIONAL NAV BAR
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.9),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final isActive = currentIndex == index;

              return GestureDetector(
                onTap: () => setState(() => currentIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xff1877F2).withOpacity(.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icons[index],
                        color: isActive
                            ? const Color(0xff1877F2)
                            : Colors.black54,
                        size: isActive ? 26 : 22,
                      ),
                      if (isActive) ...[
                        const SizedBox(width: 6),
                        Text(
                          labels[index],
                          style: const TextStyle(
                            color: Color(0xff1877F2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}