import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../components/textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("Login Screen"),
          ),
          ...[
            NeumorphicTextField(hintText: "Username"),
            SizedBox(height: 20),
            NeumorphicTextField(hintText: "Password"),
          ]
        ],
      ),
    );
  }
}
