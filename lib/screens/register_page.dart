import 'package:ecommerce/screens/farmer_screen.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/login_page.dart';
import 'package:ecommerce/tabs/home_tab.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  final bool isFarmer3;
  const RegisterPage({this.isFarmer3});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String get error => null;

  Future<String> _createAccount() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _registerEmail, password: _registerPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              )
            ],
          );
        });
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });
    String _createAccountFeedBack = await _createAccount();
    if (_createAccountFeedBack != null) {
      _alertDialogBuilder(_createAccountFeedBack);

      setState(() {
        _registerFormLoading = false;
      });
    } else {
      setState(() {
        Navigator.pop(context);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (widget.isFarmer3 == true) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FarmerScreen()));
      }
      else{
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FarmerScreen())
        );
      }
    }
  }

  bool _registerFormLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";

  FocusNode _passwordFocusNode, _farmerIdFocusNode, _phoneFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isFarmer = widget.isFarmer3;
    return _isFarmer
        ? Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Text(
                        "Create New Account",
                        textAlign: TextAlign.center,
                        style: constants.boldHeading,
                      ),
                    ),
                    Column(
                      children: [
                        customInput(
                            HintText: 'Email',
                            onChanged: (value) {
                              _registerEmail = value;
                            },
                            onSubmitted: (value) {
                              _passwordFocusNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next),
                        customInput(
                          HintText: 'Password',
                          onChanged: (value) {
                            _registerPassword = value;
                          },
                          focusNode: _passwordFocusNode,
                          isPassword: true,
                          onSubmitted: (value) {
                            _farmerIdFocusNode.requestFocus();
                          },
                        ),
                        customInput(
                          HintText: 'Farmer Id',
                          onChanged: (value) {},
                          focusNode: _farmerIdFocusNode,
                          onSubmitted: (value) {
                            _phoneFocusNode.requestFocus();
                          },
                        ),
                        customInput(
                          HintText: 'PhoneNo',
                          onChanged: (value) {},
                          focusNode: _phoneFocusNode,
                          onSubmitted: (value) {
                            _submitForm();
                          },
                        ),
                        CustomButton(
                          text: "Create Account",
                          onPressed: () {
                            _submitForm();
                          },
                          isLoading: _registerFormLoading,
                          outlineBtn: false,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          // bottom: 16.0
                          ),
                      child: CustomButton(
                        text: "Back To Login",
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage(isFarmer2: _isFarmer,))
                          );
                        },
                        outlineBtn: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Text(
                        "Create New Account",
                        textAlign: TextAlign.center,
                        style: constants.boldHeading,
                      ),
                    ),
                    Column(
                      children: [
                        customInput(
                            HintText: 'Email',
                            onChanged: (value) {
                              _registerEmail = value;
                            },
                            onSubmitted: (value) {
                              _passwordFocusNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next),
                        customInput(
                          HintText: 'Password',
                          onChanged: (value) {
                            _registerPassword = value;
                          },
                          focusNode: _passwordFocusNode,
                          isPassword: true,
                          onSubmitted: (value) {
                            _phoneFocusNode.requestFocus();
                          },
                        ),
                        customInput(
                          HintText: 'Phone No',
                          onChanged: (value) {},
                          focusNode: _phoneFocusNode,
                          onSubmitted: (value) {
                            _submitForm();
                          },
                        ),
                        CustomButton(
                          text: "Create Account",
                          onPressed: () {
                            _submitForm();
                          },
                          isLoading: _registerFormLoading,
                          outlineBtn: false,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          // bottom: 16.0
                          ),
                      child: CustomButton(
                        text: "Back To Login",
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage(isFarmer2: _isFarmer,))
                          );
                        },
                        outlineBtn: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
