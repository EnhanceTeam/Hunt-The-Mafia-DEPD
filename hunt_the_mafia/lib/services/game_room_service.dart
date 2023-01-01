part of 'services.dart';

class GameRoomService {
  static Future<bool> isPlayerHost(String roomId, String nickname) async {
    CollectionReference roomsColRef = FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players");
    QuerySnapshot playerDocRef = await roomsColRef.get();

    List<String> playerNicknames = playerDocRef.docs.map((doc) {
      return doc.id;
    }).toList();

    if (playerNicknames.contains(nickname)) {
      return false;
    }

    return true;
  }

  static Future<bool> removeRoom(String roomId) async {
    CollectionReference roomsCollectionReference =
        FirebaseFirestore.instance.collection("rooms");
    DocumentReference roomDocRef = roomsCollectionReference.doc(roomId);

    roomDocRef.delete().then((value) {
      return true;
    }).catchError((e) {
      debugPrint(e);
    });

    return false;
  }

  static Future<bool> removePlayer(String roomId, String nickname) async {
    CollectionReference roomsColRef = FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players");
    DocumentReference playerDocRef = roomsColRef.doc(nickname);

    playerDocRef.delete().then((value) {
      return true;
    }).catchError((e) {
      debugPrint(e);
    });

    return false;
  }
}
