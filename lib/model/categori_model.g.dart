// GENERATED CODE - DO NOT MODIFY BY HAND

part of'categori_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Categori _$CategoriFromJson(Map<String, dynamic> json) {
  return Categori(json['name'] as String,
      codePoint: json['code_point'] as int,
      id: json['id'] as String);
}

Map<String, dynamic> _$CategoriToJson(Categori instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code_point': instance.codePoint
    };
