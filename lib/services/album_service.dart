import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_3/models/album.dart';
import 'package:final_project_3/models/sticker.dart';

class AlbumService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addAlbum(Album album) async {
    await _db.collection('albums').doc(album.numOfAlbum.toString()).set(album.toJson());
  }

  Future<Album?> getAlbum(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> doc;
    try {
      doc = await _db.collection('albums').doc(id).get();
    } catch (e) {
      print("Error getting album: $e");
      return null;
    }
    if (!doc.exists) {
      return null;
    }
    final data = doc.data();
    if (data == null) {
      return null;
    }
    return Album.fromJson(data);
  }

  Future<List<Album>> getAlbums() async {
    try {
      QuerySnapshot snapshot = await _db.collection('albums').get();
      return snapshot.docs.map((doc) {
        return Album.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error getting albums: $e");
      return [];
    }
  }

  Future<Album> getRandomAlbum() async {
    try {
      QuerySnapshot snapshot = await _db.collection('albums').get();
      return Album.fromJson(snapshot.docs.elementAt(Random().nextInt(snapshot.docs.length)).data() as Map<String, dynamic>);
    } catch (e) {
      print("Error getting random album: $e");
      rethrow;
    }
  }

  Future<void> deleteAlbum(String id) async {
    try {
      await _db.collection('albums').doc(id).delete();
      print("Album with ID $id deleted successfully.");
    } catch (e) {
      print("Error deleting album: $e");
    }
  }

  Future<void> addSticker(String id, Sticker sticker,
      int newNumOfSilverStickers, int newNumOfGoldStickers) async {
    await _db.collection('albums').doc(id).collection('stickers').add(sticker.toJson());
    await _db.collection('albums').doc(id).update({
      "numOfSilverStickers": newNumOfSilverStickers,
      "numOfGoldStickers": newNumOfGoldStickers
    });
  }

  Future<void> removeSticker(String id, String stickerId,
      int newNumOfSilverStickers, int newNumOfGoldStickers) async {
    try {
      await _db.collection('albums').doc(id).collection('stickers').doc(stickerId).delete();
      await _db.collection('albums').doc(id).update({
        "numOfSilverStickers": newNumOfSilverStickers,
        "numOfGoldStickers": newNumOfGoldStickers
      });
      print("Sticker with ID $stickerId deleted successfully.");
    } catch (e) {
      print("Error deleting sticker: $e");
    }
  }

  Future<void> updateAlbum(String id, Album updates) async {
    try {
      await _db.collection('albums').doc(id).update(updates.toJson());
      print("Album with ID $id updated successfully.");
    } catch (e) {
      print("Error updating album: $e");
    }
  }

  Future<int> getHighestId() async {
    final querySnapshot = await _db
        .collection('albums')
        .orderBy(FieldPath.documentId, descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return int.parse(querySnapshot.docs.first.id);
    } else {
      return 0;
    }
  }
}
