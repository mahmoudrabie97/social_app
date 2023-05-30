class CommentModel {
  String? name;
  String? uid;
  String? image;
  String? datetime;
  String? text;
  //String? commentimage;
  CommentModel({
    required this.name,
    this.uid,
    this.image,
    this.datetime,
    this.text,
    //  this.commentimage
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'datetime': datetime,
      'text': text,
      //'commentimage': commentimage,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      name: json['name'] ?? '',
      uid: json['uid'] ?? '',
      image: json['image'] ?? '',
      datetime: json['datetime'] ?? '',
      text: json['text'] ?? '',
      //commentimage: json['commentimage'] ?? ''
    );
  }
}
