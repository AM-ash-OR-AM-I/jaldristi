import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jal_dristi_app/common/colors.dart';
import 'package:jal_dristi_app/components/button.dart';
import 'package:jal_dristi_app/components/textfield.dart';
import 'package:provider/provider.dart';

import '../provider/report_provider.dart';

class ReportingScreen extends StatefulWidget {
  const ReportingScreen({super.key});

  @override
  State<ReportingScreen> createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  String dropdownValue = 'Flood';
  final TextEditingController _issueController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _validateForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  final issues = [
    'Flood',
    'Water-Leakage',
    'Pipe-Rupture',
    'Water-Logging',
    'Drainage Issue',
    'Sewer Overflow',
    'Sewer Blockage',
  ];

  void _handleButtonPress() {
    if (_validateForm()) {
      // Do something with the valid data
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
      body: Padding(
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
              const Text(
                'Select an issue:',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                borderRadius: BorderRadius.circular(16),
                dropdownColor: kBaseColor,
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: issues.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 50.0,
              ),

              MyNeumorphicButton(
                onPressed: _handleButtonPress,
                text: 'Report',
              )
            ],
          ),
        ),
      ),
    );
  }
}
