// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jap_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JapEntry _$JapEntryFromJson(Map<String, dynamic> json) => JapEntry(
      timestamp: DateTime.parse(json['timestamp'] as String),
      count: json['count'] as int,
    );

Map<String, dynamic> _$JapEntryToJson(JapEntry instance) => <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'count': instance.count,
    };
