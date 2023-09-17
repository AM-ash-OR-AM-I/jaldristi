import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MyNeumorphicButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const MyNeumorphicButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.all(
          Radius.circular(35),
        )),
        depth: 5,
        lightSource: LightSource.top,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
