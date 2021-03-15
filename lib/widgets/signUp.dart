import 'package:ecommerce/screens/login_page.dart';
import 'package:ecommerce/screens/register_page.dart';
import 'package:ecommerce/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/widgets/background_painter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// class SignUp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Stack(
//         fit: StackFit.expand,
//         children: [
//           CustomPaint(painter: BackgroundPainter()),
//           buildSignUp(),
//         ],
//       );

//   Widget buildSignUp() => Column(
//         children: [
//           Spacer(),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               width: 175,
//               child: Text(
//                 '\nWelcome to OneCart',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Spacer(),
//           GoogleSignupButtonWidget(hintText: "Farmer Login"),
//           SizedBox(height: 12),
//           GoogleSignupButtonWidget(hintText: "Customer Login"),
//           SizedBox(height: 12),
//           Text(
//             'Login to continue',
//             style: TextStyle(fontSize: 16),
//           ),
//           Spacer(),
//         ],
//       );
// }
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SpeedDial(
          curve: Curves.easeOutExpo,
          icon: Icons.language,
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white70,
          animatedIconTheme: IconThemeData.fallback(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.language), label: "English",backgroundColor: Colors.lightBlue,onTap: (){
                  EasyLocalization.of(context).locale = Locale('en', 'US');
                }),
            SpeedDialChild(
                child: Icon(Icons.language), label: "Hindi",backgroundColor: Colors.redAccent,onTap: (){
                  EasyLocalization.of(context).locale = Locale('hi', 'IN');
                }),
            SpeedDialChild(
                child: Icon(Icons.language), label: "Tamil",backgroundColor: Colors.green,onTap: (){
                  EasyLocalization.of(context).locale = Locale('ta', 'IN');
                }),
          ],
        ),
        //FloatingActionButton(
        //   onPressed: () {
        //     EasyLocalization.of(context).locale = Locale('en', 'US');
        //   },
        //   child: Icon(Icons.language),
        //   backgroundColor: Colors.green,
        // ),
        body: 
          Container(
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(painter: BackgroundPainter()),
                Column(
                  children: [            
                    Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: 175,
                        child: Text(
                          "title".tr().toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    GoogleSignupButtonWidget(
                      hintText: "farmerLogin".tr().toString(),
                      bgColor: Colors.green[100],
                      fixedWidth: 300,
                      iconn: Icons.login,
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage(
                                      isFarmer3: true,
                                    )));
                      },
                    ),
                    SizedBox(height: 12),
                    GoogleSignupButtonWidget(
                      hintText: "customerLogin".tr().toString(),
                      bgColor: Colors.cyan[100],
                      fixedWidth: 300,
                      iconn: Icons.login,
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage(
                                      isFarmer3: false,
                                    )));
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      'login'.tr().toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        );
  }

  void choiceAction(String choice) {
    if (choice == "English") {
      print('English');
    } else if (choice == "Hindi") {
      print('Hindi');
    } else if (choice == "Tamil") {
      print('Tamil');
    }
  }
}
