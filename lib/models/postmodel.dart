class PostModel {
  String? name;
  String? uid;
  String? image;
  String? datetime;
  String? text;
  String? postimage;
  PostModel(
      {required this.name,
      this.uid,
      this.image,
      this.datetime,
      this.text,
      this.postimage});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'datetime': datetime,
      'text': text,
      'postimage': postimage,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        name: json['name'] ?? '',
        uid: json['uid'] ?? '',
        image: json['image'] ?? '',
        datetime: json['datetime'] ?? '',
        text: json['text'] ?? '',
        postimage: json['postimage'] ?? '');
  }
}
