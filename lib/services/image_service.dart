// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';

// class ImageService {
//   Future<String> uploadImage(File image) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     print("Uploading image");
//     final imagesRef =
//         storageRef.child('images/${DateTime.now().toIso8601String()}');
//     final uploadTask = imagesRef.putFile(image);

//     final snapshot = await uploadTask.whenComplete(() => null);
//     final downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
// }
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    String fileName = 'profile_pictures/${DateTime.now().millisecondsSinceEpoch.toString()}';
    Reference storageRef = _storage.ref().child(fileName);
    UploadTask uploadTask = storageRef.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
