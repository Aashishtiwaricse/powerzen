import 'package:_attandance/AttandanceService/attandanceService.dart';
import 'package:flutter/material.dart';
import 'package:_attandance/AttandanceService/attandanceService.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final AttendanceService service = AttendanceService();

  List projects = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    final data = await service.getProjects();

    setState(() {
      projects = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
              : projects.isEmpty
                  ? const Center(
                      child: Text(
                        "No Projects Assigned",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : Column(
                      children: [

                        /// HEADER
                        const SizedBox(height: 20),

                        // Image.asset(
                        //   "assets/powerzen.png",
                        //  height: 120,
                        // ),

                        // const SizedBox(height: 20),

                        const Text(
                          "Assigned Projects",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "${projects.length} Active Projects",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 25),

                        /// PROJECT LIST
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            itemCount: projects.length,
                            itemBuilder: (context, index) {
                              final project = projects[index];

                              return GestureDetector(
                                  onTap: () => showProjectDetails(project),


                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 18,
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.18),
                                    borderRadius:
                                        BorderRadius.circular(22),
                                    border: Border.all(
                                      color: Colors.white
                                          .withOpacity(.25),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue
                                            .withOpacity(.20),
                                        blurRadius: 18,
                                        offset:
                                            const Offset(0, 8),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                
                                      /// ICON
                                      Container(
                                        padding:
                                            const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withOpacity(.25),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.work_outline,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                
                                      const SizedBox(width: 18),
                                
                                      /// PROJECT INFO
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          children: [
                                            Text(
                                              project['name'],
                                              style:
                                                  const TextStyle(
                                                fontSize: 18,
                                                color:
                                                    Colors.white,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                              ),
                                            ),
                                            const SizedBox(
                                                height: 6),
                                            Text(
                                              "Project ID: ${project['id']}",
                                              style:
                                                  const TextStyle(
                                                color: Colors
                                                    .white70,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white70,
                                        size: 18,
                                      ),
                                    ],
                                  ),
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
  void showProjectDetails(Map project) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xff0A4DA2),
                Color(0xff1EA5FC),
                Color(0xffEAF5FF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TITLE
              Text(
                project['name'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// DETAILS BOX
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    buildRow("Project ID", project['id'].toString()),
                    buildRow("Name", project['name']),
                    
                    /// You can add more fields if API has them
                    if (project['description'] != null)
                      buildRow("Description", project['description']),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// CLOSE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      color: Color(0xff0A4DA2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
Widget buildRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Text(
          "$title: ",
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
}