// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Randomoptions _$RandomoptionsFromJson(Map<String, dynamic> json) =>
    Randomoptions(
      noWrongAns: StratEnd.fromJson(json['noWrongAns'] as Map<String, dynamic>),
      oneTwoWrongAns:
          StratEnd.fromJson(json['oneTwoWrongAns'] as Map<String, dynamic>),
      threePlusTwoWrongAns: StratEnd.fromJson(
          json['threePlusTwoWrongAns'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RandomoptionsToJson(Randomoptions instance) =>
    <String, dynamic>{
      'noWrongAns': instance.noWrongAns.toJson(),
      'oneTwoWrongAns': instance.oneTwoWrongAns.toJson(),
      'threePlusTwoWrongAns': instance.threePlusTwoWrongAns.toJson(),
    };

StratEnd _$StratEndFromJson(Map<String, dynamic> json) => StratEnd(
      start: (json['start'] as num).toInt(),
      end: (json['end'] as num).toInt(),
    );

Map<String, dynamic> _$StratEndToJson(StratEnd instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };
