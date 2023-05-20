import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debate/models/conversation/conversation.dart';
import 'package:debate/models/topic/topics.dart';
import 'package:debate/shared/Custome_Widgets/loading/loading.dart';
import 'package:debate/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
 
  late QuerySnapshot feed;
  late List<TopicObject> topics;

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    dynamic result = Provider.of<QuerySnapshot?>(context);
    if (result != null) {
      feed = result;

      topics = TopicObject().listMapToTopicList(feed.docs);

      isLoaded = true;
    }

    if (isLoaded) {
      return Scaffold(
        backgroundColor: backgroundColour,
        appBar: AppBar(
          backgroundColor: summaryColour,
          elevation: 0,
          title: Text('Choose a Topic', style: TextStyle(color: textColor),),
        ),
        body: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(topics[index].topic),
            );
          },
        ),
      );
    } else {
      return Loading();
    }
  }
}
