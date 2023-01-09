class Room {
  static const String collectionName = 'rooms';

  String roomID;
  String title;
  String description;
  String categoryID;

  Room({
    required this.roomID,
    required this.title,
    required this.description,
    required this.categoryID,
  });

  Room.fromJson(Map<String, dynamic> json)
      : this(
          roomID: json['room_id'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          categoryID: json['category_id'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'room_id': roomID,
      'title': title,
      'description': description,
      'category_id': categoryID,
    };
  }
}
