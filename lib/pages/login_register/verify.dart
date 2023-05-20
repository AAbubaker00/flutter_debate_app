import 'dart:async';
import 'package:debate/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _auth = FirebaseAuth.instance;
  late User? user;
  late Timer timer;

  @override
  void initState() {
    user = _auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVertified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email,
                  size: 100,
                  color: user!.emailVerified
                      ? greenVarient
                      : redVarient,
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Verify your email address',
                  ),
                SizedBox(
                  height: 5,
                ),
                Text('Please verify your email address,',
                  ),
                Text(user!.email.toString(),
                  ),
                
              ],
            ),
          ),
        ),
    );
  }

  Future checkEmailVertified() async {
    try {
      User? user = _auth.currentUser;
      await user!.reload();

      if (user.emailVerified) {
        timer.cancel();
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
