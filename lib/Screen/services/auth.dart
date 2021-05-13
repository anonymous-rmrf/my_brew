import 'package:brew_manager/Screen/services/database.dart';
import 'package:brew_manager/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;       //_ means private anmd final means no further cahnges can be made
  //signin anonymous ly


  // create a user object based on firebase user id jo humlog user.dat mein store kara rahe
  //firebase automatically assigns unique uid for each uinque login and we fetch it from api

  CustomerUser _userFromUser(User user){
    return user != null? CustomerUser(uid: user.uid) : null;
  }
 //auth changes and user stream , stram provide karega continous data which will update myapp(root) so that pata chalega ki
  //auth page show karna hai ya home page
  Stream<CustomerUser> get user{
    return _auth.authStateChanges().map((User user) => _userFromUser(user));
  }




//signin anonymously
Future signInAnon() async{
  try{
   UserCredential result = await _auth.signInAnonymously();
   User user = result.user;
   return _userFromUser(user);
  } catch(e){
    print(e.toString());
    return null;

  }
}

  //sigin email pass
  Future signinemail(String email, String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //register emailpass
  Future registeremail(String email, String password) async{
    try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User user = result.user;
        //linking or createe an new db for the new user
        await DbService(uid: user.uid).updatedata('0', 'enter name', 100);

        return _userFromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}