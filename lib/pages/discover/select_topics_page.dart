import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debate/models/topic/topics.dart';
import 'package:debate/services/database/database.dart';
import 'package:debate/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectTopicsPage extends StatefulWidget {
  final QuerySnapshot feedResult, topicsFollowingResult;

  const SelectTopicsPage({super.key, required this.feedResult, required this.topicsFollowingResult});

  @override
  // ignore: library_private_types_in_public_api
  _SelectTopicsPageState createState() => _SelectTopicsPageState();
}

class _SelectTopicsPageState extends State<SelectTopicsPage> {
  late QuerySnapshot feed;
  late List<TopicObject> topics;
  late List<TopicFollowingObject> topicsFollowing;

  bool isLoaded = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    topics = TopicObject().listMapToTopicList(widget.feedResult.docs);
    topicsFollowing = TopicFollowingObject().listMapToTopicFollowingList(widget.topicsFollowingResult.docs);

    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: AppBar(
        backgroundColor: summaryColour,
        elevation: 0,
        title: Text(
          'Choose a Topic',
          style: TextStyle(color: textColor),
        ),
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: InkWell(
                onTap: () async {
                  if (topicsFollowing.indexWhere((tfollowing) => tfollowing.id == topics[index].id) == -1) {
                    DatabaseService()
                        .userCollection
                        .doc(_auth.currentUser!.uid)
                        .collection('topicsFollowing')
                        .doc(topics[index].id)
                        .set({});
                  } else {
                    DatabaseService()
                        .userCollection
                        .doc(_auth.currentUser!.uid)
                        .collection('topicsFollowing')
                        .doc(topics[index].id)
                        .delete();
                  }
                },
                child: Container(
                  color: topicsFollowing.indexWhere((tfollowing) => tfollowing.id == topics[index].id) == -1
                      ? summaryColour
                      : blueVarient,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(topics[index].topic),
                )),
          );
        },
      ),
    );
  }
}
