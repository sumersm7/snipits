
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: _error
                ? splashScreen()
                : !_initialized
                    ? splashScreen()
                    : SplashScreen()));
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser;
  bool isAuthinticated = false;

  _isUserSignedin() async {
    currentUser = _auth.currentUser;
    setState(() {
      currentUser != null ? isAuthinticated = true : isAuthinticated = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _isUserSignedin();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 0);
    return new Timer(_duration, navigationPage);
  }

  Widget userAuthStae() {
    if (!isAuthinticated)
      return LoginPage();
    else
      return HomeScreen();
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => userAuthStae()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: splashScreen());
  }
}

Widget splashScreen() {
  return Container(
    height: double.maxFinite,
    width: double.maxFinite,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
              radius: 80.0, child: Image.asset('assets/images/newimg.png')),
          Text("APP NAME",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          CircularProgressIndicator()
        ]),
  );
}
