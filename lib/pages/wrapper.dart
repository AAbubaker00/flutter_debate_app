import 'dart:async';
import 'dart:core';

import 'package:debate/models/conversation/conversation.dart';
import 'package:debate/pages/discover/select_topics_page.dart';
import 'package:debate/models/user/user.dart';
import 'package:debate/pages/discover/discover.dart';
import 'package:debate/pages/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debate/pages/login_register/login.dart';
import 'package:debate/pages/profile/profile.dart';
import 'package:debate/services/database/database.dart';
import 'package:debate/shared/Custome_Widgets/loading/loading.dart';
import 'package:debate/shared/multi_stream_builder/multi_stream_builder.dart';
import 'package:debate/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:multi_stream_builder/multi_stream_builder.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  //why would i 

  @override
  void initState() {
    super.initState();
    startTimer();

    _pages = [
      StreamProvider<QuerySnapshot?>.value(
        
          initialData: null,
          value: DatabaseService(uid: _auth.currentUser!.uid).topicFollowing,
          builder: (context, snapshot) {
            QuerySnapshot? feed = Provider.of<QuerySnapshot?>(context);

            if (feed != null) {
              return MultiStreamBuilder(
                  streams: List.generate(
                      feed.docs.length,
                      (index) => DatabaseService()
                          .feedCollection
                          .doc(feed.docs[index].id)
                          .collection('conversations')
                          .snapshots()),
                  builder: (context, dataList) {
                    if (!dataList.contains(null)) {
                      // print(dataList.length);
                      List<ConversationObject> conversations = [];

                      for (var convo in dataList) {
                        conversations.addAll(ConversationObject().listMapToConversationObjectList(
                            convo!.docs, feed.docs[dataList.indexOf(convo)].id));
                      }

                      return Home(conversations: conversations);
                    } else {
                      return Loading();
                    }
                  });
            } else {
              return Loading();
            }
          }),
      MultiStreamBuilder(
          streams: [DatabaseService().feed, DatabaseService(uid: _auth.currentUser!.uid).topicFollowing],
          builder: (context, dataList) {
            if (dataList[0] != null && dataList[1] != null) {
              return SelectTopicsPage(
                feedResult: dataList[0]!,
                topicsFollowingResult: dataList[1]!,
              );
            } else {
              return Loading();
            }
          }),
      const Profile()
    ];
  }

  int _selectedIndex = 2;
  late List<Widget> _pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late DocumentSnapshot doc;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Timer timer;

  startTimer() {
    timer = Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctxt) {
        return Login();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic user = (Provider.of<UserObject?>(context));

    // ignore: unnecessary_null_comparison
    if (user == null) {
      if (!timer.isActive) {
        startTimer();
      }

      return Loading();
    } else {
      timer.cancel();

      return Container(
        color: summaryColour,
        child: SafeArea(
          child: Scaffold(
            body: _pages[_selectedIndex],
            bottomNavigationBar: Theme(
              data: ThemeData(canvasColor: summaryColour),
              child: BottomNavigationBar(
                elevation: 0,
                fixedColor: Colors.black,
                unselectedItemColor: Colors.grey,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Discover',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Messages',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'Notifications',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      );
    }
  }
}
