import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerRegisterPage extends StatefulWidget {
  final bool isFarmer3;
  const FarmerRegisterPage({this.isFarmer3});
  @override
  _FarmerRegisterPageState createState() => _FarmerRegisterPageState();
}

class _FarmerRegisterPageState extends State<FarmerRegisterPage> {
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
      if (widget.isFarmer3 == true)
        prefs.setBool("isFarmerbool", true);
      else
        prefs.setBool("isFarmerbool", false);
    
    }
  }

  bool _registerFormLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";

  FocusNode _passwordFocusNode;

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
    return Scaffold(
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
                      _submitForm();
                    },
                  ),
                  customInput(
                    HintText: 'Farmer ID',
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPassword: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  customInput(
                    HintText: 'Phone No.',
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPassword: true,
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
                    Navigator.pop(context);
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
