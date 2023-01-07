part of "services.dart";

class GameplayService {
  static void guessProcess(
      String roomId, String guessWord, BuildContext context) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players")
        .get()
        .then((value) {
      FirebaseFirestore.instance.collection("rooms").doc(roomId).update({
        "mr_white_guessing": false,
      });

      var answer = value.docs
          .firstWhere((element) => element.get("role") == "civilian")
          .get("word");

      if (guessWord == answer) {
        FirebaseFirestore.instance.collection("rooms").doc(roomId).update({
          "winner": "mr_white",
        }).then((value) {
          // todo: show mr_white win dialog
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  static void voteProcess(
      String votedPlayer, String roomId, BuildContext context) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players")
        .doc(votedPlayer)
        .update({"voted": true}).then((value) {
      FirebaseFirestore.instance
          .collection("rooms")
          .doc(roomId)
          .collection("players")
          .doc(votedPlayer)
          .get()
          .then((value) {
        var role = value.get("role");

        if (role == "mr_white") {
          Fluttertoast.showToast(
              msg: "Mr. White is voted out!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          // todo: show guess pop up

          FirebaseFirestore.instance
              .collection("rooms")
              .doc(roomId)
              .update({"mr_white_guessing": true}).then((value) => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: ((context) {
                    return GameDialog.guessDialog(
                        roomId: roomId, context: context);
                  })));
        } else {
          if (role == "mr_black") {
            Fluttertoast.showToast(
                msg: "Mr. Black is voted out!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (role == "civilian") {
            Fluttertoast.showToast(
                msg: "Civilian is voted out!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (role == "mafia") {
            Fluttertoast.showToast(
                msg: "Mafia is voted out!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }

        Navigator.pop(context);

        FirebaseFirestore.instance
            .collection("rooms")
            .doc(roomId)
            .get()
            .then((value) {
          if (value.get("winner") == "None") {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(roomId)
                .collection("players")
                .get()
                .then((value) {
              var civilianCount = 0;
              var mafiaCount = 0;

              value.docs.forEach((element) {
                if (element["role"] == "civilian" &&
                    element["voted"] == false) {
                  civilianCount++;
                } else if (element["role"] == "mafia" &&
                    element["voted"] == false) {
                  mafiaCount++;
                }
              });

              if (civilianCount == 1) {
                FirebaseFirestore.instance
                    .collection("rooms")
                    .doc(roomId)
                    .update({"winner": "mafia"});
              } else {
                if (mafiaCount == 0) {
                  FirebaseFirestore.instance
                      .collection("rooms")
                      .doc(roomId)
                      .update({"winner": "civilian"});
                }
              }
            });
          }
        });
      });
    });
  }

  static Future<List<String>> getPlayers(String roomId) async {
    return await FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players")
        .get()
        .then((value) {
      List<String> players = [];

      value.docs.forEach((element) {
        if (element.get("voted") == true) {
          players.add(element.id);
        }
      });

      return players;
    });
  }

  static String convertNumToTurns(var num) {
    if (num == 1) {
      return "1st";
    } else if (num == 2) {
      return "2nd";
    } else if (num == 3) {
      return "3rd";
    } else {
      return num.toString() + "th";
    }
  }

  static Future<void> setPlayerTurns(String roomId) {
    return FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players")
        .get()
        .then((value) {
      var turns = [];
      var valueLen = value.docs.length;

      for (var i = 0; i < valueLen; i++) {
        turns.add(i + 1);
      }

      turns.shuffle();

      var playerTurn = {};

      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("rooms")
            .doc(roomId)
            .collection("players")
            .doc(element.id)
            .update({
          "turn": turns[0],
        });

        turns.removeAt(0);
      });
    });
  }

  static void showPlayerRole(
      String nickname, String roomId, BuildContext context) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("players")
        .doc(nickname)
        .get()
        .then((value) {
      print(value.data());
      var role = value.get("role");
      var word1 = value.get("word");
      var word2 = "";

      if (role == "mr_black") {
        word2 = value.get("word2");
      }

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: ((context) => GameDialog.roleDialog(
              context: context,
              nickname: nickname,
              role: role,
              roomCode: roomId,
              word: word1,
              word2: word2)));
    });
  }

  static Future<void> wordRandomizer(String roomId) {
    return FirebaseFirestore.instance.collection("words").get().then((value) {
      var words = value.docs;
      var wordsIndex = Random().nextInt(words.length);
      var chosenWords = words.elementAt(wordsIndex);

      var randomCivilianWord = Random().nextInt(2);
      var civilianWord = chosenWords.get(randomCivilianWord.toString());
      var mafiaWord = chosenWords.get(randomCivilianWord == 0 ? "1" : "0");

      FirebaseFirestore.instance
          .collection("rooms")
          .doc(roomId)
          .collection("players")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.get("role").toString() == "civilian") {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(roomId)
                .collection("players")
                .doc(element.id)
                .update({
              "word": civilianWord,
            });
          } else if (element.get("role").toString() == "mafia") {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(roomId)
                .collection("players")
                .doc(element.id)
                .update({
              "word": mafiaWord,
            });
          } else if (element.get("role").toString() == "mr_black") {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(roomId)
                .collection("players")
                .doc(element.id)
                .update({
              "word": civilianWord,
              "word2": mafiaWord,
            });
          } else if (element.get("role").toString() == "mr_white") {
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

  static Future<void> roleRandomizer(String roomId) {
    return FirebaseFirestore.instance
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
            var availableRoles = [];

            for (var i = 0; i < civilianCount; i++) {
              availableRoles.add("civilian");
            }

            for (var i = 0; i < mafiaCount; i++) {
              availableRoles.add("mafia");
            }

            for (var i = 0; i < mrWhiteCount; i++) {
              availableRoles.add("mr_white");
            }

            for (var i = 0; i < mrBlackCount; i++) {
              availableRoles.add("mr_black");
            }

            value.docs.forEach((element) {
              // todo: randomize role
              var randomRole = Random().nextInt(availableRoles.length);

              FirebaseFirestore.instance
                  .collection("rooms")
                  .doc(roomId)
                  .collection("players")
                  .doc(element.id)
                  .update({
                "role": availableRoles.elementAt(randomRole),
                "voted": false
              });

              availableRoles.removeAt(randomRole);
            });
          }
        });
      }
    });
  }
}
