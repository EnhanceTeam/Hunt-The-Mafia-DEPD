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
    CollectionReference roomsColRef = FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players");
    DocumentReference roomDocRef = roomsColRef.doc(nickname);
    DocumentSnapshot roomDocSnapshot = await roomDocRef.get();

    debugPrint(roomDocSnapshot.exists.toString());
    // Nickname exists
    if (roomDocSnapshot.exists) {
      return true;
      // Map<String, dynamic> data =
      //     roomDocSnapshot.data() as Map<String, dynamic>;
      // List<dynamic> playerNicknames = data[playerNicknamesField] ?? [];

      // if (!playerNicknames.contains(nickname)) {
      //   roomDocRef.update({
      //     playerNicknamesField: FieldValue.arrayUnion([nickname]),
      //   });
      //   return false;
      // }
    }

    // Nickname doesn't exist
    roomDocRef.set({"role": null});
    return false;
  }
}
