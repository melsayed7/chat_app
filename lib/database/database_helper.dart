import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static CollectionReference<ChatUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(ChatUser.collectionName)
        .withConverter<ChatUser>(
          fromFirestore: (snapshot, options) =>
              ChatUser.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
          fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
          toFirestore: (room, options) => room.toJson(),
        );
  }

  static Future<void> registerUser(ChatUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<ChatUser?> getUser(String userID) async {
    var docSnapshot = await getUserCollection().doc(userID).get();
    return docSnapshot.data();
  }

  static Future<void> addRoomToFirebase(Room room) async {
    var docRef = getRoomCollection().doc();
    room.roomID = docRef.id;
    return docRef.set(room);
  }

  static Stream<QuerySnapshot<Room>> getRoomsFromFirebase() {
    return getRoomCollection().snapshots();
  }
}
