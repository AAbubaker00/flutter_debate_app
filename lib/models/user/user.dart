import 'package:firebase_auth/firebase_auth.dart';

class UserObject {
  late String uid;
  late String? email;

  UserObject();

  UserObject.fromUser(User user)
      : uid = user.uid,
        email = user.email;
}
