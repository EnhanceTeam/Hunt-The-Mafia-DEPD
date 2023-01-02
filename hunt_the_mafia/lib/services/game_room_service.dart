part of 'services.dart';

class GameRoomService {
  static Future<bool> isPlayerHost(String roomId, String nickname) async {
    CollectionReference roomsColRef =
        FirebaseFirestore.instance.collection("rooms");
    DocumentSnapshot roomDocRef = await roomsColRef.doc(roomId).get();

    if (roomDocRef.exists) {
      Map<String, dynamic> data = roomDocRef.data() as Map<String, dynamic>;
      String hostname = data["hostname"];
      if (hostname.toLowerCase() == nickname.toLowerCase()) {
        return true;
      }
    }

    return false;
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
    CollectionReference playerColRef = FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players");
    DocumentReference playerDocRef = playerColRef.doc(nickname);

    playerDocRef.delete().then((value) {
      return true;
    }).catchError((e) {
      debugPrint(e);
    });

    return false;
  }
}
