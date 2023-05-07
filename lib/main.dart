import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/auth_screen/login_screen.dart';
import 'package:abdar_seller/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isLoggedIn = false;

  checkUser()async{
    auth.authStateChanges().listen((User? user) {
      if(user ==null && mounted){
        isLoggedIn = false;
      }else{
        isLoggedIn = true;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.transparent
        )
      ),
      home: isLoggedIn? const Home() : const LoginScreen(),
    );
  }
}
