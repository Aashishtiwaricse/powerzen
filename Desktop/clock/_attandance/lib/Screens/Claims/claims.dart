import 'package:flutter/material.dart';
import 'package:_attandance/AttandanceService/attandanceService.dart';
import 'package:file_picker/file_picker.dart';

class ClaimsScreen extends StatefulWidget {
  const ClaimsScreen({super.key});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  final AttendanceService service = AttendanceService();
  //int? uploadedDocumentId;
  List claims = [];
  bool isLoading = true;
  PlatformFile? selectedFile;
  int? uploadedDocumentId;
  final amountController = TextEditingController();
  final descController = TextEditingController();
  final projectIdController = TextEditingController();

Future<void> pickAndUploadFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: [
      'pdf',
      'doc',
      'docx',
      'xls',
      'xlsx',
      'png',
      'jpg',
      'jpeg',
    ],
  );

  if (result != null) {
    final file = result.files.first;

    print("FILE NAME: ${file.name}");
    print("FILE PATH: ${file.path}");

    final id = await service.uploadDocument(file);

    print("UPLOAD ID: $id");

    if (id != null) {
      setState(() {
        selectedFile = file;
        uploadedDocumentId = id;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${file.name} uploaded")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload failed")),
      );
    }
  }
}

  String selectedCategory = "MATERIAL";

  final categories = ["MATERIAL", "TRAVEL", "FOOD", "OTHER"];

  @override
  void initState() {
    super.initState();
    fetchClaims();
  }

  Future<void> fetchClaims() async {
    setState(() => isLoading = true);

    final data = await service.getClaims();

    setState(() {
      claims = data;
      isLoading = false;
    });
  }

  Future<void> createClaim() async {
    if (uploadedDocumentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload document first")),
      );
      return;
    }

    final success = await service.createClaim(
      amount: double.parse(amountController.text),
      description: descController.text,
      projectId: int.parse(projectIdController.text),
      category: selectedCategory,
      documentId: uploadedDocumentId.toString(), // ✅ FIX
    );

    if (success) {
      Navigator.pop(context);
      clearFields();
      fetchClaims();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Claim Created Successfully")),
      );
    }
  }

  void clearFields() {
    amountController.clear();
    descController.clear();
    projectIdController.clear();
  }

  void showCreateDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Create Claim"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Amount"),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: projectIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Project ID"),
              ),
                            const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: pickAndUploadFile,
                icon: const Icon(Icons.upload_file),
                label: Text(
                  selectedFile == null ? "Upload Document" : selectedFile!.name,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField(
                value: selectedCategory,
                items: categories
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  selectedCategory = value!;
                },
                decoration: const InputDecoration(labelText: "Category"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(onPressed: createClaim, child: const Text("Submit")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff1877F2),
        onPressed: showCreateDialog,
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0A4DA2), Color(0xff1EA5FC), Color(0xffEAF5FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Column(
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      "Claims",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${claims.length} Claims",
                            style: const TextStyle(color: Colors.white70),
                          ),

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
                      child: claims.isEmpty
                          ? const Center(
                              child: Text(
                                "No Claims Found",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: claims.length,
                              itemBuilder: (context, index) {
                                final claim = claims[index];

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.18),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₹ ${claim['amount']}",
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        claim['description'].toString(),
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Category: ${claim['category']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
