import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jal_dristi_app/common/colors.dart';
import 'package:jal_dristi_app/common/screen_names.dart';
import 'package:provider/provider.dart';

import 'common/global_navigator.dart';
import 'common/routes.dart';
import 'provider/api.dart';
import 'provider/report_provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kBaseColor),
  );
  runApp(const MyApp());
}

Future<bool> checkJWToken() async {
  final token = await Api.getAuthToken();
  return token != null ? true : false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReportProvider()),
      ],
      child: FutureBuilder<bool>(
        future: checkJWToken(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking the token
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Show an error message if there was an error checking the token
            return const Text('Error checking token');
          } else {
            final initialRoute = (snapshot.data == true)
                ? Screens.homeScreen.route
                : Screens.loginScreen.route;
            log(initialRoute);
            return NeumorphicApp(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              navigatorKey: navigatorKey,
              theme: NeumorphicThemeData(
                textTheme: GoogleFonts.josefinSansTextTheme(),
                lightSource: LightSource.bottomRight,
                baseColor: kBaseColor,
                shadowLightColor: kShadowLightColor,
                shadowDarkColor: kShadowDarkColor,
                defaultTextColor: kTextColor,
                iconTheme: const IconThemeData(color: kIconColor),
                appBarTheme: const NeumorphicAppBarThemeData(
                  centerTitle: true,
                  buttonStyle: NeumorphicStyle(depth: 10),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: kTextColor,
                  ),
                ),
                buttonStyle: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(15),
                  ),
                ),
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                intensity: .8,
                depth: 4,
              ),
              initialRoute: initialRoute,
              routes: routes,
            );
          }
        },
      ),
    );
  }
}
