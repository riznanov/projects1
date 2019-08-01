// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Check _$CheckFromJson(Map<String, dynamic> json) {
  return Check(json['name'] as String,
      parent: json['parent'] as String,
      isCompleted: json['completed'] as int,
      id: json['id'] as String);
}

Map<String, dynamic> _$CheckToJson(Check instance) => <String, dynamic>{
      'id': instance.id,
      'parent': instance.parent,
      'name': instance.name,
      'completed': instance.isCompleted
    };
