part of "services.dart";

class GameplayService {
  static void roleRandomizer(String roomId) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .get()
        .then((value) {
      if (value.exists) {
        var civilianCount = value.get("civilian_count");
        var mafiaCount = value.get("mafia_count");
        var mrWhiteCount = value.get("mr_white_count");
        var mrBlackCount = value.get("mr_black_count");

        FirebaseFirestore.instance
            .collection("rooms")
            .doc(roomId)
            .collection("players")
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            value.docs.forEach((element) {
              // todo: randomize role
              var rng = Random().nextInt(4);

              FirebaseFirestore.instance
                  .collection("rooms")
                  .doc(roomId)
                  .collection("players")
                  .doc(element.id)
                  .update({
                "role": "civilian",
                "is_alive": true,
              });
            });
          }
        });
      }
    });
  }
}
