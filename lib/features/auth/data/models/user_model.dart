import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
    };
  }
}

/// Design Pattern: Builder Pattern
/// Why applied:
/// Allows step-by-step construction of the [UserModel]. During sign-up,
/// only basic credentials (id, name, email) are supplied, while device
/// details and profile images can be attached later without polluting the constructor.
class UserBuilder {
  String? _id;
  String? _name;
  String? _email;
  String? _profileImage;

  UserBuilder setId(String id) {
    _id = id;
    return this;
  }

  UserBuilder setName(String name) {
    _name = name;
    return this;
  }

  UserBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  UserBuilder setProfileImage(String? profileImageUrl) {
    _profileImage = profileImageUrl;
    return this;
  }

  UserModel build() {
    assert(_id != null, 'User ID is required to build a UserModel');
    assert(_name != null, 'User Name is required to build a UserModel');
    assert(_email != null, 'User Email is required to build a UserModel');

    return UserModel(
      id: _id!,
      name: _name!,
      email: _email!,
      profileImage: _profileImage,
    );
  }
}
