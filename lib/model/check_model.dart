import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wedding_planner/utils/uuid.dart';

part 'check_model.g.dart';

@JsonSerializable()
class Check {
  final String id, parent;
  final String name;
  @JsonKey(name: 'completed')
  final int isCompleted;

  Check(this.name, {
    @required this.parent,
    this.isCompleted = 0,
    String id
  }): this.id = id ?? Uuid().generateV4();

  Check copy({String name, int isCompleted, int id, int parent}) {
    return Check(
      name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
      parent: parent ?? this.parent,
    );
  }

    /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$CheckFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory Check.fromJson(Map<String, dynamic> json) => _$CheckFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CheckFromJson`.
  Map<String, dynamic> toJson() => _$CheckToJson(this);
}
