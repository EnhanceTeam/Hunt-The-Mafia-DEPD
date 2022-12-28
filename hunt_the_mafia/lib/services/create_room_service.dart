part of "services.dart";

class CreateRoomService {
  static Future<void> addRooms(String nickname) {
    CollectionReference roomsRef =
        FirebaseFirestore.instance.collection("rooms");

    return roomsRef.add("410102");
  }
}
