import 'package:brew_manager/model/brew.dart';
import 'package:brew_manager/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {

  final String uid;

  DbService({this.uid});

  // reference collection
  final CollectionReference brewCollec = FirebaseFirestore.instance.collection(
      'brew');

  Future updatedata(String sugar, String name, int strong) async {
    return await brewCollec.doc(uid).set({
      'sugar': sugar,
      'name': name,
      'strong': strong,
    });
  }
//brew list from snapshot
  List<Brew> _brewlistfromsnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.data()['name']??'',
        strong: doc.data()['strong']?? 0,
        sugar: doc.data()['sugar']??'0'
      );
    }).toList();
  }
// user data from snapshot
  UserData _userdatafromsnapshot(DocumentSnapshot snapshot)
  {
    return UserData(
      uid: uid,
        name: snapshot.data()['name'],
        strong: snapshot.data()['strong'],
        sugars: snapshot.data()['sugars'],
    );
  }



//Stream
  Stream<List<Brew>> get brewdata {
    return brewCollec.snapshots()
      .map(_brewlistfromsnapshot);

  }

  //user doc stream
Stream<UserData> get userData {
    return brewCollec.doc(uid).snapshots().map(_userdatafromsnapshot);
}

}