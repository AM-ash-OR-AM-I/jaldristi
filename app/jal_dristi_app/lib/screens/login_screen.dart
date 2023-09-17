import 'dart:developer';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jal_dristi_app/provider/api.dart';

import '../common/screen_names.dart';
import '../components/button.dart';
import '../components/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(100.0),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            ...[
              NeumorphicTextField(
                hintText: "Username",
                controller: _loginController,
              ),
              NeumorphicTextField(
                hintText: "Password",
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              MyNeumorphicButton(
                text: "Login",
                onPressed: () => login(),
              )
            ]
          ],
        ),
      ),
    );
  }

  void login() async {
    final navigator = Navigator.of(context);
    final scaffold = ScaffoldMessenger.of(context);
    String response = await Api.login(
      username: _loginController.text,
      password: _passwordController.text,
    );
    log(response);
    // loader.hide();

    if (response == "Success") {
      navigator.pushNamed(
        Screens.homeScreen.route,
        arguments: response,
      );
    } else {
      scaffold.clearSnackBars();
      scaffold.showSnackBar(
        SnackBar(
          content: Text(
            response,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    // final sessions = await Api.getSessions();
    // log(sessions.toString());
  }
}
