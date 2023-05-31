import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final QuerySnapshot debates, followers, following;

  const Profile({super.key, required this.debates, required this.followers, required this.following});

  @override
  State<Profile> createState() => _ProfileState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    print(widget.debates.docs.length.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(_auth.currentUser!.displayName.toString()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 30, right: 20),
            child: Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Column(
                        children: [Text(widget.debates.docs.length.toString()), Text('Debates')],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [Text(widget.followers.docs.length.toString()), Text('followers')],
                        ),
                      ),
                      Column(
                        children: [Text(widget.following.docs.length.toString()), Text('Following')],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ), 

          Column(
            children: [],
          )

        ],
      ),
    );
  }
}
