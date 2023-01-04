part of 'services.dart';

class JoinRoomService {
  static Future<String> getHostname(String roomId) async {
    CollectionReference roomsCollectionReference =
        FirebaseFirestore.instance.collection("rooms");
    DocumentReference roomDocRef = roomsCollectionReference.doc(roomId);
    DocumentSnapshot roomDocSnapshot = await roomDocRef.get();

    Map<String, dynamic> data = roomDocSnapshot.data() as Map<String, dynamic>;
    var hostname = data["hostname"];

    return hostname;
  }

  static Future<bool> isRoomExists(String roomId) async {
    CollectionReference roomsColRef =
        FirebaseFirestore.instance.collection("rooms");
    DocumentSnapshot roomDoc = await roomsColRef.doc(roomId).get();

    return roomDoc.exists;
  }

  static Future<bool> isNicknameExistsInRoom(
      String roomId, String nickname) async {
    CollectionReference playerColRef = FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players");
    DocumentReference playerDocRef = playerColRef.doc(nickname);
    DocumentSnapshot playerDocSnapshot = await playerDocRef.get();

    // Nickname exists
    if (playerDocSnapshot.exists) {
      return true;
    }

    // Nickname doesn't exist
    playerDocRef.set({"role": null});
    return false;
  }

  static Future<bool> roomHasStarted(String roomId) async {
    CollectionReference roomsColRef =
        FirebaseFirestore.instance.collection("rooms");
    DocumentReference roomDocRef = roomsColRef.doc(roomId);
    DocumentSnapshot roomDocSnapshot = await roomDocRef.get();

    Map<String, dynamic> data = roomDocSnapshot.data() as Map<String, dynamic>;
    var hasStarted = data["hasStarted"];

    return hasStarted;
  }
}
