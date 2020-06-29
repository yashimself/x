import 'package:firebase_auth/firebase_auth.dart';
import 'package:x/models/user.dart';
import 'package:x/services/sp.dart';

bool isemailverified = false;

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  //create user obj based on Firebase user

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

//register with email and password
  Future RegisterwithEmailandPass(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await user.sendEmailVerification();
      await checkverification(user);
      //create a new document for the user with uid
      //await DatabaseService(uid: user.uid).updateUserData('0', 'new crew', 100);
       return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //Sign in with email and password

  Future SigninwithEmailandPass(String email, String password) async {
    try {

      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      FirebaseUser user = result.user;
      await checkverification(user);
      if(isemailverified)
        return _userFromFirebaseUser(user);
      else{
        await user.sendEmailVerification();
        return null;
      }

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out

  Future signOut() async {
    try {
      Sp.saveUserLoggedinpreference(false);
      Sp.saveuseremailverificationpreference(false);
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //password reset

  Future forgotpass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    }catch (e) {
      print(e.toString());
      return null;
    }
  }

  //check verification

   Future checkverification(FirebaseUser user)async{
    if (user.isEmailVerified == true)
    {
        isemailverified = true;
        print(isemailverified);
        await Sp.saveuseremailverificationpreference(true);
    }
    else{
       await Sp.saveuseremailverificationpreference(false);
    }
  }
}


