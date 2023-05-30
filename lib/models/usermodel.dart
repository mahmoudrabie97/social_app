class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? cover;
  String? bio;
  bool? isemaiverifie;
  UserModel({
    required this.name,
    this.email,
    required this.phone,
    this.uid,
    this.isemaiverifie,
    this.image,
    this.bio,
    this.cover,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'isemaiverifie': isemaiverifie,
      'image': image,
      'bio': bio,
      'cover': cover,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      uid: json['uid'] ?? '',
      isemaiverifie: json['isemaiverifie'],
      image: json['image'] ?? '',
      bio: json['bio'] ?? '',
      cover: json['cover'] ?? '',
    );
  }
}
