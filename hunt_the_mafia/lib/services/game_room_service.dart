part of 'services.dart';

class GameRoomServie {
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
