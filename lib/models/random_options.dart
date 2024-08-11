import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'random_options.g.dart';

@JsonSerializable()
class Randomoptions {
  final StratEnd noWrongAns;
  final StratEnd oneTwoWrongAns;
  final StratEnd threePlusTwoWrongAns;

  Randomoptions({
    required this.noWrongAns,
    required this.oneTwoWrongAns,
    required this.threePlusTwoWrongAns,
  });

  factory Randomoptions.fromJson(Map<String, dynamic> json) =>
      _$RandomoptionsFromJson(json);

  Map<String, dynamic> toJson() => _$RandomoptionsToJson(this);
}

@JsonSerializable()
class StratEnd {
  final int start;
  final int end;
  final int step;

  StratEnd({required this.start, required this.end})
      : step = _calculateStep(start, end);

  static int _calculateStep(int start, int end) {
    final random = Random();
    return start + random.nextInt((end - start).abs() + 1);
  }

  factory StratEnd.fromJson(Map<String, dynamic> json) =>
      _$StratEndFromJson(json);

  Map<String, dynamic> toJson() => _$StratEndToJson(this);

  // Convert StratEnd object to a Map
  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
      'step': step,
    };
  }

  // Create StratEnd object from a Map
  static StratEnd fromMap(Map<String, dynamic> map) {
    return StratEnd(
      start: map['start'],
      end: map['end'],
    );
  }
}