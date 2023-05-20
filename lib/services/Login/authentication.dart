import 'package:debate/services/database/database.dart';
import 'package:debate/shared/printFunctions/custom_Print_Functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:debate/models/user/user.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserObject? _userFromFirebaseUser(User? user) {
    try {
      return user != null ? UserObject.fromUser(user) : null;
    } catch (e) {
      PrintFunctions().printError('_userFromFirebaseUser: $e');

      return null;
    }
  }

  //! auth chnage user stream
  Stream<UserObject?>? get user {
    try {
      return _auth.userChanges().map(_userFromFirebaseUser);
    } catch (e) {
      debugPrint('error in database');
      return null;
    }
  }

  //! Sing in with Email & Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      User? user = result.user;

      return _userFromFirebaseUser(user!);
    } catch (e) {
      PrintFunctions().printError('signInWithEmailAndPassword: $e');

      return null;
    }
  }

  //! register with email &Password
  Future registerWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User? user = result.user;

      // await DatabaseService(uid: user!.uid).updateUserData(data: {
      //   'portfolios': SampleData().getSamplePortfolio(),
      //   'account': {
      //     'accountType': 'free',
      //     'email': email,
      //     'currency': 'USD',
      //     'isVertified': user.emailVerified
      //   }
      // });

      return _userFromFirebaseUser(user!);
    } catch (e) {
      PrintFunctions().printError('registerWithEmailAndPassword: e');

      return null;
    }
  }

  //! Sign out BNHBV B76YTGFVC
  Future signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      PrintFunctions().printError('registerWithEmailAndPassword: $e');

      return null;
    }
  }

  //! Reset Password
  Future passwordReset({String? email}) async {
    await _auth.sendPasswordResetEmail(email: email.toString());
  }

  //! Delete User
  Future deleteUser(String email, String password) async {
    try {
      User? user = _auth.currentUser;

      AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);
      UserCredential result = await user!.reauthenticateWithCredential(credentials);

      await DatabaseService(uid: result.user!.uid).deleteuser();
      await result.user!.delete();

      return true;
    } catch (e) {
      PrintFunctions().printError('deltUser: $e');

      return null;
    }
  }

  //!Google SignIn
  Future googleSinIn() async {
    try {
      final user = await _googleSignIn.signIn();

      if (user == null) {
        return null;
      } else {
        final googleAuth = await user.authentication;
        final credential =
            GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        var result = await FirebaseAuth.instance.signInWithCredential(credential);

        // if (result.additionalUserInfo.isNewUser) {
        //   await result.user.delete();
        //   _googleSignIn.disconnect();

        //   return null;
        // } else {
        //   return _userFromFirebaseUser(result.user);
        // }
      }
    } catch (e) {
      PrintFunctions().printError('google sign up: $e');

      return null;
    }
  }

  //!Google SignUp
  Future googleSignUp() async {
    try {
      final user = await _googleSignIn.signIn();

      if (user == null) {
        print('error');

        return null;
      } else {
        final googleAuth = await user.authentication;
        final credential =
            GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        var result = await FirebaseAuth.instance.signInWithCredential(credential);

        debugPrint(result.user!.uid);

        User? curretUser = result.user;

        if (result.user != null) {
          await DatabaseService(uid: result.user!.uid).updateUserData(data: {
            'profile': {
              'name': 'User',
              'email': result.user!.email,
              'profileImage': '',
              'age': 0,
              'location': '',
              'number': 0,
            },
          });
        }

        await DatabaseService().userCollection.doc(result.user!.uid).collection('followers').add({});
        await DatabaseService().userCollection.doc(result.user!.uid).collection('following').add({});
        await DatabaseService().userCollection.doc(result.user!.uid).collection('topicsFollowing').add({});
        await DatabaseService().userCollection.doc(result.user!.uid).collection('conversationsFollwoing').add({});

        return _userFromFirebaseUser(curretUser);
      }
    } catch (e) {
      PrintFunctions().printError('googleSignup: $e');

      return null;
    }
  }

  //! Google Sign Out
  Future googleLogout() async {
    try {
      await _googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (e) {
      PrintFunctions().printError('googleLogout: $e');

      return null;
    }
  }

  Future deleteGoogleAccount() async {
    try {
      final user = await _googleSignIn.signIn();
      final googleAuth = await user!.authentication;
      final credential =
          GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      var result = await FirebaseAuth.instance.signInWithCredential(credential);

      User? u = FirebaseAuth.instance.currentUser;
      await DatabaseService(uid: u!.uid).deleteuser();
      await result.user!.delete();
      await _googleSignIn.disconnect();

      return true;
    } catch (e) {
      PrintFunctions().printError('deleteGoogleAccount: $e');

      return null;
    }
  }
}
