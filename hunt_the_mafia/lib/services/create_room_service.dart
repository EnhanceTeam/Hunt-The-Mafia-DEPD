part of "services.dart";

class CreateRoomService {

  static String roomId = "";

  static Future<void> addRooms(String nickname) {
    CollectionReference roomsRef =
        FirebaseFirestore.instance.collection("rooms");

    roomId = (new Random().nextInt(900000) + 100000).toString();

    return roomsRef.doc(roomId).set({"hostname": nickname});
  }

  static String getCurrentRoomId(){
    return roomId;
  }

}
