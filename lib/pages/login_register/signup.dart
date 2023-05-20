import 'package:debate/pages/wrapper.dart';
import 'package:debate/services/Login/authentication.dart';
import 'package:debate/shared/inputDecoration/inputDecoration.dart';
import 'package:debate/shared/units/units.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  //! Email and Password data
  String _email = '';
  String _password = '';
  String _passwordConfirm = '';

  FocusNode focusNode_1 = FocusNode();
  FocusNode focusNode_2 = FocusNode();
  FocusNode focusNode_3 = FocusNode();
  FocusNode focusNode_4 = FocusNode();

  bool isError = false;

  bool isActive = false;
  bool isActive1 = false;
  bool isActive2 = false;
  bool isActive3 = false;

  bool isEqual = false, isLong = false;

  checkPassword() {
    setState(() {
      if (_password == _passwordConfirm) {
        isEqual = true;
      } else {
        isEqual = false;
      }

      isLong = _password.length >= 8 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _emailValidate() {
      // showModalBottomSheet(
      //     context: context,
      //     // builder: (ctxt) => CWConfirmBottomSheetButton(
      //     //       context: ctxt,
      //     //       btnText: 'A validation code will be sent to the entered email, $_email, is this correct?',
      //     //       isRed: false,
      //     //       function: () async {
      //     //         dynamic result =
      //     //             await _auth.registerWithEmailAndPassword(email: _email, password: _password);

      //     //         print(result);

      //     //         if (result == null) {
      //     //           setState(() {
      //     //             isError = true;
      //     //           });
      //     //         } else {
      //     //           Navigator.pushAndRemoveUntil(
      //     //               context,
      //     //               MaterialPageRoute(builder: (context) => VerifyScreen()),
      //     //               (Route<dynamic> route) => false);
      //     //         }
      //     //       },
      //     //     )
      //         );
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () => setState(() {
          focusNode_1.unfocus();
          focusNode_2.unfocus();
          focusNode_3.unfocus();
          focusNode_4.unfocus();

          isActive = false;
          isActive1 = false;
          isActive2 = false;
          isActive3 = false;
        }),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 30, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Create Account",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Sign up to get started!",
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Column(
                            children: [
                              TextFormField(
                                validator: (txt) => txt!.isEmpty ? emptyEmail : null,
                                onTap: () => setState(() => isActive1 = true),
                                focusNode: focusNode_2,
                                inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                                onChanged: (txt) {
                                  setState(() => _email = txt);
                                },
                                decoration: CustomInputDecoration('Email', context),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                obscureText: true,
                                focusNode: focusNode_3,
                                onTap: () => setState(() => isActive2 = true),
                                validator: (txt) => txt!.length < 8 ? shortPassword : null,
                                inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                                onChanged: (txt) {
                                  _password = txt;
                                  checkPassword();
                                },
                                decoration: CustomInputDecoration('Password', context),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                obscureText: true,
                                focusNode: focusNode_4,
                                validator: (txt) => txt != _password ? 'Passwords Do not match' : null,
                                onTap: () => setState(() => isActive3 = true),
                                inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                                onChanged: (txt) {
                                  _passwordConfirm = txt;
                                  checkPassword();
                                },
                                decoration: CustomInputDecoration('Confirm Password', context),
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () async {
                                dynamic result = await _auth.googleSignUp();

                                if (result == null) {
                                  setState(() {
                                    isError = true;
                                  });
                                  
                                  print('error');
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Wrapper()),
                                      (Route<dynamic> route) => false);
                                }
                              },
                              child: FaIcon(
                                FontAwesomeIcons.google,
                                color: Colors.red,
                                size: iconSize - 5,
                              )),
                          isError
                              ? const Padding(
                                  padding:  EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'An error has occured. Make sure your email is in the correct format.',
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
