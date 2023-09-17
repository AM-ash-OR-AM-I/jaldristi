import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jal_dristi_app/common/screen_names.dart';
import 'package:jal_dristi_app/provider/api.dart';

import '../common/image_picker.dart';
import '../components/menu_item.dart';
import 'camera_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: const Text("Jal Drishti"),
          actions: [
            IconButton(
              onPressed: () {
                Api.removeAuthToken();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Screens.loginScreen.route,
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildLogo(),
                // buildHeading(),
                const SizedBox(height: 50),
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
            text: "Live Reporting",
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
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const AnalysisScreen()),
              // );
            },
          ),
          const SizedBox(width: 20),
          MenuItem(
            text: "Review",
            icon: Icons.reviews_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
