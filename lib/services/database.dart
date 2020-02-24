import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;

  DatabaseService({this.uid});
  
  // get the collection reference
  final CollectionReference coffeeCollection = Firestore.instance.collection('coffee');

  Future updateUserData(String sugar, String name, int strength) async{
    return await coffeeCollection.document(uid).setData(
      {
        'sugar':sugar,
        'name':name, 
        'strength':strength,
      }
    );
  }

}