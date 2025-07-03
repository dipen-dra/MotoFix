import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';



part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  // FIX #2: This is the most important fix.
  // It stops the `_id` field from being sent in the JSON when it's null.
  @JsonKey(name: '_id', includeIfNull: false)
  final String? id;

  @JsonKey(name: 'fullName')
  final String fullName;

  final String email;
  final String? password;

  const UserApiModel({
    this.id,
    required this.fullName,
    required this.email,
    // FIX #3: The password field is nullable (String?), so it shouldn't be 'required'.
    this.password,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  //to entity
  UserEntity toEntity() {
    return UserEntity(
      userId: id,
      fullName: fullName,
      email: email,
      password: password ?? '',
    );
  }

  // from Entity
  // This factory is used to create an API model from our app's entity,
  // typically right before sending data to the server.
  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      // The 'id' is intentionally left out here, because when we create a user,
      // the id is null. Our fix #2 above will prevent it from being serialized.
      id: entity.userId,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
    );
  }

  @override
  // Cleaned up the props getter
  List<Object?> get props => [id, fullName, password, email];
}