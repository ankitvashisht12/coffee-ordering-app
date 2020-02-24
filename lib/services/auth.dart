import 'package:coffee_ordering_app/models/user.dart';
import 'package:coffee_ordering_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance; 

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // stream for listening user
  Stream<User> get userStream{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anon

  Future SignInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password


  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password ( sign up )4

  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password); 
      FirebaseUser user = result.user;

      // create database for new user
      await DatabaseService(uid: user.uid).updateUserData('0', 'New member', 0);
      
      return _userFromFirebaseUser(user); 

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}