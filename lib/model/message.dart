class Message {
  static const String collectionName = 'message';

  String id;
  String roomID;
  String content;
  String senderID;
  String senderName;
  int dateTime;

  Message({
    this.id = '',
    required this.roomID,
    required this.content,
    required this.senderID,
    required this.senderName,
    required this.dateTime,
  });

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          roomID: json['room_id'] as String,
          content: json['content'] as String,
          senderID: json['sender_id'] as String,
          senderName: json['sender_name'] as String,
          dateTime: json['date_time'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id': roomID,
      'content': content,
      'sender_id': senderID,
      'sender_name': senderName,
      'date_time': dateTime,
    };
  }
}
