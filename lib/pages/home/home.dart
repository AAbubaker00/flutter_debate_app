import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debate/models/conversation/conversation.dart';
import 'package:debate/pages/home/conversationPage/conversation_page.dart';
import 'package:debate/services/database/database.dart';
import 'package:debate/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final List<ConversationObject> conversations;

  const Home({super.key, required this.conversations});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: summaryColour,
        title: Text(
          'Feed',
          style: TextStyle(color: textColor),
        ),
      ),
      body: ListView(
        children: widget.conversations
            .map<Widget>((conversation) => InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StreamProvider<QuerySnapshot?>.value(
                            initialData: null,
                            value: DatabaseService(
                                    feedId: conversation.parentId, conversationId: conversation.id)
                                .messages,
                            builder: (context, snapshots) {
                              return ConversationPage(
                                question: conversation.question,
                              );
                            }),
                      )),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(conversation.userFor),
                      ),
                      Column(
                        children: [
                          const Text('Abortion rights and reproductive health'),
                          Text(conversation.question),
                          Text(conversation.dataCreated),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(conversation.userAgainst),
                      )
                    ]),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
