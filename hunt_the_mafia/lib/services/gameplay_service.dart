part of "services.dart";

class GameplayService {
  static Future<AlertDialog> showPlayerRole(
      String nickname, String roomId, BuildContext context) {
    roleRandomizer(roomId);
    wordRandomizer(roomId);

    // todo: randomize word for each player

    return FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players")
        .doc(nickname)
        .get()
        .then((value) {
      var role = value.get("role");
      var word1 = value.get("word");
      var word2 = value.get("word2");

      return GameDialog.roleDialog(
          context: context,
          nickname: nickname,
          role: role,
          roomCode: roomId,
          word: word1,
          word2: word2);
    });
  }

  static void wordRandomizer(String roomId) {
    FirebaseFirestore.instance.collection("words").get().then((value) {
      var words = value.docs;
      var wordsIndex = Random().nextInt(words.length);
      var chosenWords = words[wordsIndex];

      var randomCivilianWord = Random().nextInt(2);
      var civilianWord = chosenWords.get(randomCivilianWord);
      var mafiaWord = chosenWords.get(randomCivilianWord == 0 ? 1 : 0);

      FirebaseFirestore.instance
          .collection("rooms")
          .doc(roomId)
          .collection("players")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.get("role") == "civilian") {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(roomId)
                .collection("players")
                .doc(element.id)
                .update({
              "word": civilianWord,
            });
          } else if (element.get("role") == "mafia") {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(roomId)
                .collection("players")
                .doc(element.id)
                .update({
              "word": mafiaWord,
            });
          } else if (element.get("role") == "mr_black") {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(roomId)
                .collection("players")
                .doc(element.id)
                .update({
              "word": civilianWord,
              "word2": mafiaWord,
            });
          } else if (element.get("role") == "mr_white") {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(roomId)
                .collection("players")
                .doc(element.id)
                .update({"word": "None, since you're the Mr. White"});
          }
        });
      });
    });
  }

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
            var availableRoles = 0;

            if (civilianCount > 0) {
              availableRoles += 1;
            }

            if (mafiaCount > 0) {
              availableRoles += 1;
            }

            if (mrWhiteCount > 0) {
              availableRoles += 1;
            }

            if (mrBlackCount > 0) {
              availableRoles += 1;
            }

            value.docs.forEach((element) {
              // todo: randomize role
              var randomRole = Random().nextInt(availableRoles);

              if (randomRole == 0) {
                FirebaseFirestore.instance
                    .collection("rooms")
                    .doc(roomId)
                    .collection("players")
                    .doc(element.id)
                    .update({
                  "role": "civilian",
                  "is_alive": true,
                }).then((_) {
                  availableRoles -= 1;
                  civilianCount -= 1;
                });
              } else if (randomRole == 1) {
                FirebaseFirestore.instance
                    .collection("rooms")
                    .doc(roomId)
                    .collection("players")
                    .doc(element.id)
                    .update({
                  "role": "mafia",
                  "is_alive": true,
                }).then((_) {
                  availableRoles -= 1;
                  mafiaCount -= 1;
                });
              } else if (randomRole == 2) {
                FirebaseFirestore.instance
                    .collection("rooms")
                    .doc(roomId)
                    .collection("players")
                    .doc(element.id)
                    .update({
                  "role": "mr_white",
                  "is_alive": true,
                }).then((_) {
                  availableRoles -= 1;
                  mrWhiteCount -= 1;
                });
              } else if (randomRole == 3) {
                FirebaseFirestore.instance
                    .collection("rooms")
                    .doc(roomId)
                    .collection("players")
                    .doc(element.id)
                    .update({
                  "role": "mr_black",
                  "is_alive": true,
                }).then((_) {
                  availableRoles -= 1;
                  mrBlackCount -= 1;
                });
              }
            });
          }
        });
      }
    });
  }
}
