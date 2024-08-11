// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
  name: json['name'] as String? ?? '',
  numOfSilverStickers: (json['numOfSilverStickers'] as num?)?.toInt() ?? 0,
  numOfGoldStickers: (json['numOfGoldStickers'] as num?)?.toInt() ?? 0,
  date: json['date'] as String? ?? '',
  status: $enumDecode(_$StatusEnumMap, json['status'] ?? 'hidden'),
  stickers: (json['stickers'] as List<dynamic>?)
      ?.map((e) => Sticker.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  numOfAlbum: (json['numOfAlbum'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
  'numOfAlbum': instance.numOfAlbum,
  'name': instance.name,
  'numOfSilverStickers': instance.numOfSilverStickers,
  'numOfGoldStickers': instance.numOfGoldStickers,
  'date': instance.date,
  'status': _$StatusEnumMap[instance.status]!,
  'stickers': instance.stickers.map((sticker) => sticker.toJson()).toList(),
};


const _$StatusEnumMap = {
  Status.dispalyedAvailible: 'dispalyedAvailible',
  Status.displyedLocked: 'displyedLocked',
  Status.hidden: 'hidden',
};
