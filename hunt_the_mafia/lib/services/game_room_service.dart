part of 'services.dart';

class GameRoomService {
  static Future<bool> isPlayerHost(String roomId, String nickname) async {
    CollectionReference roomsCollectionReference =
        FirebaseFirestore.instance.collection("rooms");
    DocumentReference roomDocRef = roomsCollectionReference.doc(roomId);
    DocumentSnapshot roomDocSnapshot = await roomDocRef.get();

    String playerNicknamesField = "playerNicknames";

    if (roomDocSnapshot.exists) {
      Map<String, dynamic> data =
          roomDocSnapshot.data() as Map<String, dynamic>;
      List<dynamic> playerNicknames = data[playerNicknamesField] ?? [];

      if (!playerNicknames.contains(nickname)) {
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
    CollectionReference roomsCollectionReference =
        FirebaseFirestore.instance.collection("rooms");
    DocumentReference roomDocRef = roomsCollectionReference.doc(roomId);
    DocumentSnapshot roomDocSnapshot = await roomDocRef.get();

    String playerNicknamesField = "playerNicknames";

    if (roomDocSnapshot.exists) {
      Map<String, dynamic> data =
          roomDocSnapshot.data() as Map<String, dynamic>;
      List<dynamic> playerNicknames = data[playerNicknamesField] ?? [];

      if (playerNicknames.contains(nickname)) {
        roomDocRef.update({
          playerNicknamesField: FieldValue.arrayRemove([nickname]),
        });
        return true;
      }
    }

    return false;
  }
}
