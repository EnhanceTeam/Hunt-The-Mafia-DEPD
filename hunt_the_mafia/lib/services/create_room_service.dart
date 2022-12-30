part of "services.dart";

class CreateRoomService {
  static Future<void> addRooms(String nickname) {
    CollectionReference roomsRef =
        FirebaseFirestore.instance.collection("rooms");

    String roomId = (new Random().nextInt(900000) + 100000).toString();

    return roomsRef.doc(roomId).set({"hostname": nickname});
  }
}
