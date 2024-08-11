import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phms_fyp/Screens/main_screens/Drawer/drawer.dart';
import 'package:phms_fyp/colors/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart' as path;

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<String> _pdfPaths = [];

  @override
  void initState() {
    super.initState();
    _loadPdfPaths();
  }

  Future<void> _loadPdfPaths() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pdfPaths = prefs.getStringList('pdfPaths') ?? [];
    });
  }

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      List<String> paths = result.paths.whereType<String>().toList();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _pdfPaths.addAll(paths);
      await prefs.setStringList('pdfPaths', _pdfPaths);
      setState(() {});
    }
  }

  Future<void> _deletePdf(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pdfPaths.removeAt(index);
    });
    await prefs.setStringList('pdfPaths', _pdfPaths);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const CustomDrawer(currentPage: 'reports'),
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text("Reports"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _pdfPaths.length + 1, // Adjust item count to include padding
                    itemBuilder: (context, index) {
                      if (index == _pdfPaths.length) {
                        return SizedBox(height: height * 0.12); // Padding at the bottom
                      }
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0), // Add padding to show shadow
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: height * 0.6, // Adjust the height as needed
                                child: SfPdfViewer.file(
                                  File(_pdfPaths[index]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  path.basename(_pdfPaths[index]),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.white),
                                    onPressed: () => _deletePdf(index),
                                  ),
                                ],
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: _pickPdf,
                child: Container(
                  width: width * 0.6,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(-4, 2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Upload PDF",
                      style: TextStyle(fontSize: 18, color: AppColor.textWhiteColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
