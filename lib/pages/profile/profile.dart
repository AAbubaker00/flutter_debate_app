import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

  final FirebaseAuth _auth = FirebaseAuth.instance;

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_auth.currentUser!.displayName.toString()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
            child: Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Column(
                        children: const [Text('1'), Text('Debates')],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: const [Text('1'), Text('followers')],
                        ),
                      ),
                      Column(
                        children: const [Text('1'), Text('Following')],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
