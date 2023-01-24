import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  static CollectionReference<Message> getMessageCollection(String roomID) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomID)
        .collection(Message.collectionName)
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (message, options) => message.toJson(),
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

  static void logOUt() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> insertMessage(Message message) {
    var collection = getMessageCollection(message.roomID);
    var docRef = collection.doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> getMessageFromFirebase(String roomID) {
    return getMessageCollection(roomID).orderBy('date_time').snapshots();
  }
}
