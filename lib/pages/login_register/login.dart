import 'package:debate/pages/login_register/signup.dart';
import 'package:debate/shared/customPageRoute/customePageRoute.dart';
import 'package:debate/shared/inputDecoration/inputDecoration.dart';
import 'package:debate/shared/printFunctions/custom_Print_Functions.dart';
import 'package:debate/shared/themes/themes.dart';
import 'package:debate/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:debate/services/Login/authentication.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //! Email and Password data
  String _email = '';
  String _password = '';

  bool isWrongCred = false;
  bool isActive = false;
  bool isActive2 = false;
  bool isPrivate = true;
  bool isAccountExist = true;

  FocusNode focusNode_1 = FocusNode();
  FocusNode focusNode_2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => setState(() {
          focusNode_1.unfocus();
          focusNode_2.unfocus();

          isActive = false;
          isActive2 = false;
        }),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Column(
                      children: [
                        TextFormField(
                          focusNode: focusNode_1,
                          onTap: () => setState(() => isActive = true),
                          validator: (txt) => txt!.isEmpty ? emptyEmail : null,
                          inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                          decoration: CustomInputDecoration('Email', context),
                          onChanged: (txt) {
                            setState(() => _email = txt);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          focusNode: focusNode_2,
                          onTap: () => setState(() => isActive2 = true),
                          validator: (txt) => txt!.length < 8 ? shortPassword : null,
                          inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                          obscureText: isPrivate,
                          decoration: CustomInputDecoration('Password', context),
                          onChanged: (txt) {
                            setState(() => _password = txt);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //     context, MaterialPageRoute(builder: (context) => PasswordReset()));
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Forgot Password?",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: isWrongCred
                          ? Text(
                              wrongCred,
                              textAlign: TextAlign.center,
                            )
                          : isAccountExist
                              ? Container()
                              : Text(
                                  noAccount,
                                  textAlign: TextAlign.center,
                                ),
                    ),
                    Column(
                      children: [],
                    ),
                  ],
                ),
                TextButton(
                    // : blueVarient,
                    onPressed: () => PrintFunctions().printError('e'),
                    child: const FaIcon(FontAwesomeIcons.solidEnvelope)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Need an account?",
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        borderRadius: BorderRadius.circular(circularRadius),
                        onTap: () => Navigator.pushReplacement(
                            context,
                            CustomPageRouteSlideTransition(
                                direction: AxisDirection.left,
                                child: SignUp(),
                                settings: const RouteSettings(arguments: []))),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "SIGN UP",
                          ),
                        ),
                      )
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
