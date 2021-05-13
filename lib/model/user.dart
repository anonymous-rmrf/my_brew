class CustomerUser {
  final String uid; //final bcz as the user moves across the uid doesnot chng an maintains intigrity
  CustomerUser({this.uid});
}
class UserData{

  final String uid;
  final String name;
  final String sugars;
  final int strong;

  UserData({this.uid, this.sugars, this.strong, this.name});

}