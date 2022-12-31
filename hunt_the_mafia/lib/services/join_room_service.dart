part of 'services.dart';

class JoinRoomService {
  static Future<bool> isRoomExists(String roomId) async {
    CollectionReference roomsCollectionReference =
        FirebaseFirestore.instance.collection("rooms");
    DocumentSnapshot roomDoc = await roomsCollectionReference.doc(roomId).get();

    return roomDoc.exists;
  }

  static Future<bool> isNicknameExistsInRoom(
      String roomId, String nickname) async {
    CollectionReference roomsCollectionReference =
        FirebaseFirestore.instance.collection("rooms");
    DocumentReference roomDocRef = roomsCollectionReference.doc(roomId);
    DocumentSnapshot roomDocSnapshot = await roomDocRef.get();

    String playerNicknamesField = "playerNicknames";

    if (roomDocSnapshot.exists) {
      Map<String, dynamic> data =
          roomDocSnapshot.data() as Map<String, dynamic>;
      List<dynamic> playerNicknames = data[playerNicknamesField] ?? [];

      debugPrint("playerNicknames: $playerNicknames");
      if (!playerNicknames.contains(nickname)) {
        debugPrint("nickname not exists in room");
        roomDocRef.update({
          playerNicknamesField: FieldValue.arrayUnion([nickname]),
        });
        return false;
      }
    }

    return true;
  }
}
