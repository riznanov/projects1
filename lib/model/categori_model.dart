import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wedding_planner/utils/uuid.dart';
part 'categori_model.g.dart';

@JsonSerializable()
class Categori {
  String id;
  String name;
  @JsonKey(name: 'code_point')
  int codePoint;

  Categori(
    this.name, {
    @required this.codePoint,
    String id,
  }) : this.id = id ?? Uuid().generateV4();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$CategoriFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory Categori.fromJson(Map<String, dynamic> json) => _$CategoriFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoriFromJson`.
  Map<String, dynamic> toJson() => _$CategoriToJson(this);
}
