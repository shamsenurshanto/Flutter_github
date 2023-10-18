import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_app/user/user_view.dart';

Future<void> main() async {
  runApp(
    Builder(builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // initialize();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Github_issuses Filter!!',
      // translations: Languages(),

      locale: Locale('bn', 'BD'), // ur PK  en US  bn BD
      fallbackLocale: Locale('bn', 'BD'),
      theme: ThemeData(
          // primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              // primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            // fillColor: kPrimaryLightColor,
            // iconColor: kPrimaryColor,
            // prefixIconColor: kPrimaryColor,
            // contentPadding: EdgeInsets.symmetric(
            // horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: user_model(),
      // home : dash_newMyBottomNavigationBar_new(),
      // home: const homeGrid(),
      // home: const transactionWithPending(),
      // home: userdetails_new_with_sidebar(),
      // home: Dashboard()
      // home: CupertinoNavigationDemo(),
      //  home: otpPhone("01886144124"),
      // home:  otpPhone_2("0190929290"),
      // home: dio_cached_manager(),
      // home: FlutterContactsExample()
      // home: HomePage_local();
    );
  }
}
