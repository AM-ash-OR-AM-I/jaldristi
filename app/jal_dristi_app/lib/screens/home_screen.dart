import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../common/image_picker.dart';
import '../components/menu_item.dart';
import 'camera_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildLogo(),
                buildHeading(),
                buildMenu1(context),
                buildMenu2(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 20),
      child: Center(
        child: Icon(
          Icons.water_drop_rounded,
          size: 100,
          color: Colors.blue.shade900,
        ),
      ),
    );
  }

  Padding buildHeading() {
    return const Padding(
      padding: EdgeInsets.only(top: 60, bottom: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Jal Drishti",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xff112a42),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildMenu1(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MenuItem(
            text: "Upload Image",
            icon: Icons.upload_rounded,
            onPressed: () => chooseImageFromGallery(),
          ),
          const SizedBox(width: 25),
          MenuItem(
            text: "Live reporting",
            icon: Icons.camera,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CameraScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  SizedBox buildMenu2(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MenuItem(
            text: "View Analysis",
            icon: Icons.analytics_rounded,
            onPressed: () {},
          ),
          const SizedBox(width: 20),
          MenuItem(
            text: "Feedback",
            icon: Icons.question_answer_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
