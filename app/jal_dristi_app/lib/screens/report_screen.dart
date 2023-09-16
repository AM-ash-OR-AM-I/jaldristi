import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jal_dristi_app/common/colors.dart';

class ReportingScreen extends StatefulWidget {
  const ReportingScreen({super.key});

  @override
  State<ReportingScreen> createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  String dropdownValue = 'Flood';
  final TextEditingController _issueController =TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _validationMessage = '';
   bool _validateForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

   void _handleButtonPress() {
    if (_validateForm()) {
      // Do something with the valid data
      setState(() {
        _validationMessage = 'Form is valid!';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBaseColor,
      appBar: NeumorphicAppBar(
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       //Go Back
          //     },
          //     icon: const Icon(Icons.logout),
          //   ),
          // ],
       // centerTitle: true,
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        title: Text("Report an issue",style: TextStyle(fontSize: 20.0,color: kTextColor,fontWeight: FontWeight.w600,letterSpacing: 1.0),),
      ),
        body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description must not be empty.';
                  }
                  return null; // Return null if the input is valid
                },
            
              controller: _issueController,
              decoration:const InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                labelText: 'Describe the issue',
              ),
              maxLength: 800, // Set the maximum character limit
              maxLines: 4, // Allow multiple lines
            ), 
            const SizedBox(height: 20), // Add some spacing
           const  Row(
              children: [
               Text('Select an issue:',style: TextStyle(fontSize: 18.0),),
              ],
            ),
             const SizedBox(height: 10), 
            Row(
              children: [
                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(16),
                  dropdownColor: kBaseColor,
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>[
                    'Flood',
                    'Tide',
                    'Avalanche',
                    'Water-Logging',
                    'Tsunami',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
           const SizedBox(height: 20.0,),
      
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              height: 40,
              child: NeumorphicButton(onPressed: (){
                _handleButtonPress();
              },
              style: const NeumorphicStyle(color: kShadowDarkColor,shape: NeumorphicShape.concave),
               child: const Center(child: Text("REPORT",style: TextStyle(color: kTextColor,fontWeight: FontWeight.w600),))),
            )
          ],
        ),
      ),
    ));
  }
}
