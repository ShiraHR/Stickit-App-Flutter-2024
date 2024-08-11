import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_3/models/user.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    print("add user      nm,,,nbvcxxzxcvbnmnbvcxcvbnbvcxcvbnbvcxc");
    await _db.collection('users').doc(user.email.toString()).set(user.toJson());
  }


   Future<User> update(String email, Map<String, dynamic> data) async {
  final docRef = _db.collection('users').doc(email);
  
  // Debugging output
  print('Updating document with data: $data');
  
  await docRef.update(data);
  
  // Debugging output
  print('Document updated successfully');
  
  return User.fromJson((await docRef.get()).data() as Map<String, dynamic>);
}

  // Future<User> update(String email, Map<String, dynamic> data) async {
  //   final docRef = _db.collection('users').doc(email);
  //   await docRef.update(data);
  //   return User.fromJson((await docRef.get()).data() as Map<String, dynamic>);
  // }

  Future<User> getUser(String email) async {
    final docRef = _db.collection('users').doc(email);
    return User.fromJson((await docRef.get()).data() as Map<String, dynamic>);
  }

  Future<List<User>> getAllUsers() async {
    final querySnapshot = await _db.collection('users').get();
    return querySnapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
  }
}