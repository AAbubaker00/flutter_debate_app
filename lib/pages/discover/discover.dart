import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debate/models/topic/topics.dart';
import 'package:debate/services/database/database.dart';
import 'package:debate/shared/Custome_Widgets/loading/loading.dart';
import 'package:debate/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  late QuerySnapshot feed;
  late List<TopicObject> topics;

  bool isLoaded = false;

  void _modalBottomSheetMenu({required TopicObject topic}) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 350.0,
            color: Colors.transparent,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0), topRight: const Radius.circular(10.0))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                            .updateUserSide(topic: topic, side: SIDES.userAgainst),
                        child: Container(
                          padding: EdgeInsets.all(50),
                          color: Colors.red.withOpacity(.7),
                          child: Text('agaisnt'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),          
                      InkWell(
                        onTap: () => DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                            .updateUserSide(topic: topic, side: SIDES.userFor),
                        child: Container(
                          padding: EdgeInsets.all(50),
                          color: Colors.green,
                          child: Text('For'),
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }

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
                onTap: () => _modalBottomSheetMenu(topic: topics[index]),
                child: Container(padding: EdgeInsets.all(10), child: Text(topics[index].topic)),
              ),
            );
          },
        ),
      );
    } else {
      return Loading();
    }
  }
}
