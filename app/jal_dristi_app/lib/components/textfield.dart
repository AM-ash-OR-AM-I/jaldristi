import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextEditingController? controller;
  const NeumorphicTextField({
    super.key,
    this.hintText,
    this.controller,
    this.labelText,
    this.validator,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      style: NeumorphicStyle(
        depth: -5,
        shadowDarkColorEmboss: Colors.grey.withOpacity(.6),
        shadowLightColorEmboss: Colors.white,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
      ),
      child: TextFormField(
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          labelText: labelText,
        ),
        controller: controller,
        maxLines: maxLines,
      ),
    );
  }
}
