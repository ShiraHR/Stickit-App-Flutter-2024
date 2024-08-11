import 'dart:io';

import 'package:final_project_3/services/image_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sticker.g.dart';

@JsonSerializable()
class Sticker {
  static final ImageService _imageService = ImageService();
  final int number;
  final String imageURL;
  final String type;

  Sticker(this.number, this.imageURL, this.type);

  static Future<Sticker> createInstace(
    int number,
    File image,
    String type,
  ) async {
    String imageURL = await _imageService.uploadImage(image);
    return Sticker(
      number,
      imageURL,
      type,
    );
  }

  factory Sticker.fromJson(Map<String, dynamic> json) =>
      _$StickerFromJson(json);

  Map<String, dynamic> toJson() => _$StickerToJson(this);
}
