import 'package:final_project_3/services/album_service.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sticker.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  static final AlbumService _albumService = AlbumService();
  final int numOfAlbum;
  final String name;
  int numOfSilverStickers;
  int numOfGoldStickers;
  final String date;
  final Status status;
  List<Sticker> stickers;

  Album({
    required this.name,
    required this.numOfSilverStickers,
    required this.numOfGoldStickers,
    required this.date,
    required this.status,
    required this.stickers,
    required this.numOfAlbum,
  });

  static Future<Album> create({
    required String name,
    required Status status,
  }) async {
    int numOfAlbum = await _initializeAlbumNum();
    Album album = Album(
      name: name,
      numOfSilverStickers: 0,
      numOfGoldStickers: 0,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      status: status,
      stickers: [],
      numOfAlbum: numOfAlbum,
    );

    await _albumService.addAlbum(album);
    return album;
  }

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  void addSticker(Sticker newSticker) {
    stickers.add(newSticker);
    if (newSticker.type == "silver") {
      numOfSilverStickers++;
    } else {
      numOfGoldStickers++;
    }
    _albumService.addSticker(
        numOfAlbum as String, newSticker, numOfSilverStickers, numOfGoldStickers);
  }

  void removeSticker(int index) {
    if (stickers[index].type == "silver") {
      numOfSilverStickers--;
    } else {
      numOfGoldStickers--;
    }
    _albumService.removeSticker(
        numOfAlbum as String, stickers[index].number as String, numOfSilverStickers, numOfGoldStickers);
    stickers.removeAt(index);
  }

  static Future<int> _initializeAlbumNum() async {
    int highestId = await _albumService.getHighestId();
    return highestId + 1;
  }
}

enum Status { dispalyedAvailible, displyedLocked, hidden }
