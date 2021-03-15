import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/screens/farmer_screen.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/login_page.dart';
import 'package:ecommerce/tabs/home_tab.dart';
import 'package:ecommerce/widgets/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool getValue;
  Future<void> getVal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getValue = prefs.getBool("isFarmerBool");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          //StreamBuilder Checks for the login
          // ignore: missing_required_param
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshott) {
                if (streamSnapshott.hasError) {
                  return MaterialApp(
                    home: Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    ),
                  );
                }
                //connection state active
                if (streamSnapshott.connectionState == ConnectionState.active) {
                  //Get the User
                  User _user = streamSnapshott.data;
                  //if users is null we havent logged in
                  if (_user == null) {
                    return Scaffold(
                      body: SignUp(),
                    );
                  } else {
                    if (getValue == true)
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage())
                      );
                    else
                      return HomePage();
                  }
                }
                //Checking the Auth State
                return Scaffold(
                  body: Center(
                    child: Text("Checking Authentication",
                        style: constants.regularHeading),
                  ),
                );
              });
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: Text("Loading", style: constants.regularHeading),
          ),
        );
      },
    );
  }
}
