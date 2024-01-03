// ignore_for_file: hash_and_equals

import 'package:json_annotation/json_annotation.dart';

part 'jap_entry.g.dart';

@JsonSerializable(explicitToJson: true)
class JapEntry {
  final DateTime timestamp;
  final int count;

  JapEntry({
    required this.timestamp,
    required this.count,
  });

  factory JapEntry.fromJson(Map<String, dynamic> json) =>
      _$JapEntryFromJson(json);

  Map<String, dynamic> toJson() => _$JapEntryToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    other = other as JapEntry;
    return timestamp == other.timestamp && count == other.count;
  }
}
