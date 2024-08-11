// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sticker _$StickerFromJson(Map<String, dynamic> json) => Sticker(
      (json['number'] as num).toInt(),
      json['imageURL'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$StickerToJson(Sticker instance) => <String, dynamic>{
      'number': instance.number,
      'imageURL': instance.imageURL,
      'type': instance.type,
    };
