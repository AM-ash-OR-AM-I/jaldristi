enum Screens {
  loginScreen("/login", "Login Screen"),
  homeScreen("/home", "Home Screen"),
  cameraScreen("/camera", "Camera Screen"),
  reportScreen("/report", "Report Screen");

  const Screens(this.route, this.name);
  final String route;
  final String name;
}
