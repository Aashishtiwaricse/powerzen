import 'package:flutter/material.dart';
import 'package:_attandance/AttandanceService/attandanceService.dart';
import 'package:file_picker/file_picker.dart';
class LeavesScreen extends StatefulWidget {
  const LeavesScreen({super.key});

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  final AttendanceService service = AttendanceService();

  List leaves = [];
  List leaveTypes = [];

  bool isLoading = true;

  String? selectedLeaveType;
  final reasonController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    loadData();
  }
  PlatformFile? selectedFile;
int? uploadedDocumentId;
Future<void> pickAndUploadFile() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles();

  if (result != null) {
    selectedFile = result.files.first;

    uploadedDocumentId =
        await service.uploadDocument(selectedFile!);
  }
}
  Future<void> loadData() async {
    final fetchedLeaves = await service.getLeaves();
    final fetchedTypes = await service.getLeaveTypes();

    setState(() {
      leaves = fetchedLeaves;
      leaveTypes = fetchedTypes;

      if (leaveTypes.isNotEmpty) {
        selectedLeaveType = leaveTypes.first['id'];
      }

      isLoading = false;
    });
  }

  Future<void> createLeave() async {
    if (startDate == null || endDate == null) return;

    final success = await service.createLeave(
      leaveTypeId: selectedLeaveType!,
      startDate: startDate.toString().split(' ')[0],
      endDate: endDate.toString().split(' ')[0],
      reason: reasonController.text,
    );

    if (success) {
      Navigator.pop(context);
      loadData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Leave Applied"),
        ),
      );
    }
  }

  Future<void> pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  void showApplyDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Apply Leave"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField(
                value: selectedLeaveType,
                items: leaveTypes.map((type) {
                  return DropdownMenuItem(
                    value: type['id'],
                    child: Text(type['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedLeaveType = value.toString();
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                decoration:
                    const InputDecoration(labelText: "Reason"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => pickDate(true),
                child: Text(
                  startDate == null
                      ? "Select Start Date"
                      : startDate.toString().split(' ')[0],
                ),
              ),
              ElevatedButton(
                onPressed: () => pickDate(false),
                child: Text(
                  endDate == null
                      ? "Select End Date"
                      : endDate.toString().split(' ')[0],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: createLeave,
            child: const Text("Apply"),
          ),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "APPROVED":
        return Colors.green;
      case "REJECTED":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff1877F2),
        onPressed: showApplyDialog,
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0A4DA2),
              Color(0xff1EA5FC),
              Color(0xffEAF5FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      "Leaves",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(""),
          ElevatedButton.icon(
                          onPressed: pickAndUploadFile,
                          icon: const Icon(Icons.upload_file),
                          label: Text(
                            selectedFile == null
                                ? "Upload Document"
                                : selectedFile!.name,
                          ),
                        ),
    ],
  ),
),
                    const SizedBox(height: 20),

                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: leaves.length,
                        itemBuilder: (context, index) {
                          final leave = leaves[index];

                          return Container(
                            margin:
                                const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color:
                                  Colors.white.withOpacity(.18),
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  leave['leaveType']['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${leave['startDate']} → ${leave['endDate']}",
                                  style: const TextStyle(
                                      color:
                                          Colors.white70),
                                ),
                                Text(
                                  "Days: ${leave['daysCount']}",
                                  style: const TextStyle(
                                      color:
                                          Colors.white70),
                                ),
                                Text(
                                  leave['reason'],
                                  style: const TextStyle(
                                      color:
                                          Colors.white),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(
                                        leave['status']),
                                    borderRadius:
                                        BorderRadius
                                            .circular(20),
                                  ),
                                  child: Text(
                                    leave['status'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}