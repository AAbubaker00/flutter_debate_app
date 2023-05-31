import 'package:debate/models/topic/topics.dart';
import 'package:debate/shared/printFunctions/custom_Print_Functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debate/services/Network/network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

enum SIDES { userFor, userAgainst }

class DatabaseService {
  final _auth = FirebaseAuth.instance;
  late User user;
  late String uid;
  late String conversationId;
  late String feedId;

  DatabaseService({this.uid = '', this.conversationId = '', this.feedId = ''});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference feedCollection = FirebaseFirestore.instance.collection('feed');

  //                                                                        //

  //! Updating User data to cloud
  Future updateUserData({@required dynamic data}) async {
    try {
      return await userCollection.doc(uid).set(data);
    } catch (e) {
      PrintFunctions().printError('updateUserData: $e');
    }
  }

  Future updateUserSide({required TopicObject topic, required SIDES side}) async {
    try {
      QuerySnapshot querySnapshot = await feedCollection.doc(topic.id).collection(side.name.toString()).get();

      if (querySnapshot.docs.isEmpty) {
        feedCollection.doc(topic.id).collection(side.name.toString()).doc(uid).set({});
        return userCollection
            .doc(uid)
            .collection('sides')
            .doc(topic.id)
            .set(TopicObject().topicObjectToMapSide(topic: topic, side: side));
      } else {
        if (querySnapshot.docs.indexWhere((doc) => doc.id == uid) == -1) {
          feedCollection.doc(topic.id).collection(side.name.toString()).doc(uid).set({});
          return userCollection
              .doc(uid)
              .collection('sides')
              .doc(topic.id)
              .set(TopicObject().topicObjectToMapSide(topic: topic, side: side));
        } else {
          return 'Already Exist';
        }
      }
    } catch (e) {
      PrintFunctions().printError('updateUserSide: $e');
      return null;
    }
  }

  //                                                                        //

  getConnection() async {
    return await Network().getConnectionStatus();
  }

  //                                                                        //

  //! get data
  Stream<DocumentSnapshot<Object?>>? get userPortfolioData {
    try {
      return userCollection.doc(uid).snapshots();
    } catch (e) {
      PrintFunctions().printError('userProfileData: $e');
      return null;
    }
  }

  //                                                                        //
  Future<void>? deleteuser() {
    try {
      return userCollection.doc(uid).delete();
    } catch (e) {
      PrintFunctions().printError('delete user: $e');

      return null;
    }
  }

  //                                                                        //

  Stream<QuerySnapshot>? get userFollowings {
    try {
      return userCollection.doc(uid).collection('following').snapshots();
    } catch (e) {
      PrintFunctions().printError('userFollowings: $e');
      return null;
    }
  }

  Stream<QuerySnapshot>? get userFollowers {
    try {
      return userCollection.doc(uid).collection('followers').snapshots();
    } catch (e) {
      PrintFunctions().printError('userFollowers: $e');
      return null;
    }
  }

  Stream<QuerySnapshot>? get userDebates {
    try {
      return userCollection.doc(uid).collection('conversations').snapshots();
    } catch (e) {
      PrintFunctions().printError('userDebates: $e');
      return null;
    }
  }

  //                                                                        //

  //                                                                        //

  Stream<QuerySnapshot>? get feed {
    try {
      // feedCollection.where((DocumentSnapshot snapshot) => snapshot.id)

      // feedCollection.add({'topic': 'Abortion rights and reproductive health'});
      // feedCollection.doc('Us5PSo6F6boRzgTCA6W3').collection('conversations').add({
      //   'userFor': 'Jame',
      //   'userAgainst': 'Bob',
      //   'dateCreated': '08/05/2023',
      // 'messages': [
      // {'user': 'bob', 'date': '01/05/2023', 'msg': 'hi', 'likes': 1},
      // {'user': 'Jma', 'date': '02/05/2023', 'msg': 'yo', 'likes': 1},
      // {
      // 'user': 'bob',
      // 'date': '03/05/2023',
      // 'msg':
      //     'Database-specific considerations: Different databases have their own naming conventions and restrictions. For example, MySQL is case-insensitive by default on Windows but case-sensitive on Unix-like systems. PostgreSQL is case-sensitive by default. Using lowercase or lowercase with underscores helps ensure better cross-platform compatibility and reduces the likelihood of naming conflicts.',
      // 'likes': 1
      // },
      // {
      //   'user': 'Jma',
      //   'date': '04/05/2023',
      //   'msg':
      //       'Compatibility: Some database systems, particularly those based on Unix-like systems, treat uppercase and lowercase letters as distinct. This means that using uppercase names may introduce case-sensitivity issues when working with your database on different platforms.',
      //   'likes': 1
      // },
      // {
      // 'user': 'bob',
      // 'date': '05/05/2023',
      // 'msg':
      //     'Readability: Lowercase or lowercase with underscores tend to be easier to read and distinguish between words in a collection name. Uppercase names can be harder to read, especially if the collection name consists of multiple words or acronyms.',
      // 'likes': 1
      // },
      // ]
      // });

      // feedCollection
      //     .doc('Us5PSo6F6boRzgTCA6W3')
      //     .collection('conversations')
      //     .doc('EhBuY98IEqisX00ZiY96')
      //     .collection('messages')
      //     .add({
      //   'user': 'bob',
      //   'date': '05/05/2023',
      //   'msg':
      //       'Readability: Lowercase or lowercase with underscores tend to be easier to read and distinguish between words in a collection name. Uppercase names can be harder to read, especially if the collection name consists of multiple words or acronyms.',
      //   'likes': 1
      // });

      // PrintFunctions()
      //     .printStartEndLine(feedCollection.doc('yC0TTTl0pEKHa7ZJMNKw').collection('conversation').snapshots().first.then((value) => PrintFunctions().printStartEndLine(value.docs.first.data())));

      // print(feedCollection.snapshots().first.then((value) => value));

      return feedCollection.snapshots();
    } catch (e) {
      PrintFunctions().printError('feed: error: $e');

      return null;
    }
  }

  Stream<QuerySnapshot>? get conversation {
    try {
      return feedCollection.doc('Us5PSo6F6boRzgTCA6W3').collection('conversations').snapshots();
    } catch (e) {
      PrintFunctions().printError('feed: error: $e');

      return null;
    }
  }

  Stream<QuerySnapshot>? get messages {
    try {
      // feedCollection.where((DocumentSnapshot snapshot) => snapshot.id)

      // PrintFunctions().printStartEndLine((feedCollection.snapshots().first as QuerySnapshot<Map<String, dynamic>>).docs);

      return feedCollection
          .doc(feedId)
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .snapshots();
    } catch (e) {
      PrintFunctions().printError('feed: error: $e');

      return null;
    }
  }

  Stream<QuerySnapshot>? get topicFollowing {
    try {
      // feedCollection.where((DocumentSnapshot snapshot) => snapshot.id)

      // PrintFunctions().printStartEndLine((feedCollection.snapshots().first as QuerySnapshot<Map<String, dynamic>>).docs);

      return userCollection.doc(uid).collection('topicsFollowing').snapshots();
    } catch (e) {
      PrintFunctions().printError('topicFollowing: $e');

      return null;
    }
  }

  sendMessage() {
    feedCollection
        .doc('Us5PSo6F6boRzgTCA6W3')
        .collection('conversations')
        .doc('EhBuY98IEqisX00ZiY96')
        .collection('messages')
        .add({'msg': 'testing', 'likes': 2, 'date': '08/05/2023', 'user': 'Jma'});
  }

  // updateFeed({PostObject post, String feedUid, bool isCommentUpdate = false, Map originalComment}) {
  //   try {
  //     if (isCommentUpdate) {
  //       if (originalComment['reports'].length >= 20) {
  //         post.comments.remove(originalComment);
  //       }
  //     } else {
  //       if (post.reports.length >= 20) {
  //         feedCollection.doc(feedUid).delete();

  //         feedUid = '';
  //       }
  //     }

  //     if (feedUid != '') {
  //       feedCollection.doc(feedUid).set(PostObject().postObjectToMap(post));
  //     }
  //   } catch (e) {
  //     PrintFunctions().printError(e);
  //   }
  // }
}
