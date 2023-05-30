class MessageModel {
  String? senderId;
  String? reciverId;
  String? datetime;
  String? text;

  MessageModel({
    this.senderId,
    this.reciverId,
    this.datetime,
    this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reciverId': reciverId,
      'datetime': datetime,
      'text': text,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'] ?? '',
      reciverId: json['reciverId'] ?? '',
      datetime: json['datetime'] ?? '',
      text: json['text'] ?? '',
    );
  }
}
