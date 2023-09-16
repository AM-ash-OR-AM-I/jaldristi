import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../components/menu_item.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildHeading(),
                buildMenu1(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildHeading() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Jal Dristi",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xff112a42),
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            Icons.water_drop_rounded,
            size: 30,
            color: Colors.blue.shade800,
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
          const SizedBox(width: 20),
          MenuItem(
              text: "Report an issue",
              icon: Icons.report_problem_rounded,
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const CameraScreen(),
                //   ),
                // );
              }),
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
          MenuItem(text: "", icon: Icons.newspaper, onPressed: () {}),
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
