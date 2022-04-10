import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_wireless/models/myuser.dart';
import 'package:project_wireless/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Myuser? _userfromFirebase(User? user) {
    return user !=null? Myuser(uid: user.uid) : null;
  }
  Stream<Myuser?> get user {
    return _auth.authStateChanges().map((User? user) => _userfromFirebase(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromFirebase(user);
    } catch(e){
      print(e.toString());
      return null ;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData('0', 'new recipe', 100);

      return _userfromFirebase(user);
    } catch(e){
      print(e.toString());
      return null ;
    }
}
// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}