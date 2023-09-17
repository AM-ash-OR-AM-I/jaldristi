import 'dart:developer';
import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jal_dristi_app/common/colors.dart';
import 'package:jal_dristi_app/components/button.dart';
import 'package:jal_dristi_app/components/textfield.dart';
import 'package:jal_dristi_app/provider/api.dart';
import 'package:provider/provider.dart';

import '../provider/report_provider.dart';

class ReportingScreen extends StatefulWidget {
  const ReportingScreen({super.key});

  @override
  State<ReportingScreen> createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  final TextEditingController _issueController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _validateForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  void reportIssue() async {
    if (_validateForm()) {
      final response = await Api.createIncident(
        imagePath: context.read<ReportProvider>().path,
        description: _issueController.text,
        category: context.read<ReportProvider>().category,
        departmentId:
            (context.read<ReportProvider>().selectedDepartment!.id).toString(),
      );
      log(response);
      if (response == "Success") {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: kBaseColor,
            title: const Text('Success'),
            content: const Text('Your issue has been reported successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text(
          "Report an issue",
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.file(
                        File(context.read<ReportProvider>().path),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                NeumorphicTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description must not be empty.';
                    }
                    return null; // Return null if the input is valid
                  },
                  controller: _issueController,
                  maxLines: 4,
                  labelText: 'Describe the issue', // Allow multiple lines
                ),
                const SizedBox(height: 20), // Add some spacing
                buildDropdown(
                  context,
                  heading: 'Department',
                  selectedValue:
                      context.watch<ReportProvider>().selectedDepartment?.name,
                  listItems: context
                      .watch<ReportProvider>()
                      .departments
                      .map((e) => e.name)
                      .toList(),
                  onChanged: (String? newValue) {
                    context.read<ReportProvider>().selectedDepartment =
                        context.read<ReportProvider>().departments.firstWhere(
                              (element) => element.name == newValue,
                            );
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                buildDropdown(
                  context,
                  heading: 'Category',
                  listItems: context.watch<ReportProvider>().categories,
                  selectedValue: context.watch<ReportProvider>().category,
                  onChanged: (String? newValue) {
                    context.read<ReportProvider>().category = (newValue!);
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),

                MyNeumorphicButton(
                  onPressed: reportIssue,
                  text: 'Report',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildDropdown(
    BuildContext context, {
    required String heading,
    required List<String> listItems,
    void Function(String?)? onChanged,
    String? selectedValue,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(fontSize: 12.0),
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            borderRadius: BorderRadius.circular(16),
            dropdownColor: kBaseColor,
            value: selectedValue,
            onChanged: onChanged,
            items: listItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: const TextStyle(color: kTextColor, fontSize: 12)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
