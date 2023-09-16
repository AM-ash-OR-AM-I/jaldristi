import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  const NeumorphicTextField(
      {super.key, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      style: NeumorphicStyle(
        depth: -5,
        shadowDarkColorEmboss: Colors.grey.withOpacity(.6),
        shadowLightColorEmboss: Colors.white,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(35)),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
        controller: controller,
      ),
    );
  }
}
