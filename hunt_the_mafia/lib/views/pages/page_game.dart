part of "pages.dart";

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static const String routeName = "/game";

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as GamePageArguments;

    final String nickname = args.nickname;
    final String roomId = args.roomId;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Text("Your Word",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("rooms")
                      .doc(roomId)
                      .collection("players")
                      .doc(nickname)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      var role = snapshot.data!.get("role");

                      return role != "mr_black"
                          ? Text(snapshot.data!.get("word"),
                              style: TextStyle(
                                fontSize: 23,
                              ))
                          : Text(snapshot.data!.get("word") +
                              " and " +
                              snapshot.data!.get("word2"));
                    }
                  },
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("rooms")
                        .doc(args.roomId)
                        .collection("players")
                        .snapshots(),
                    builder: (_, snapshot) => snapshot.connectionState !=
                            ConnectionState.waiting
                        ? Container(
                            child: Column(
                              children: [
                                GridView.count(
                                  physics: ScrollPhysics(),
                                  crossAxisCount: 3,
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: [
                                    for (int i = 0;
                                        i < snapshot.data!.docs.length;
                                        i++)
                                      Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                child: Text(
                                                  GameplayService
                                                      .convertNumToTurns(
                                                          snapshot.data!.docs
                                                              .elementAt(i)
                                                              .get("turn")),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                ),
                                              ),
                                              Text(snapshot.data!.docs
                                                  .elementAt(i)
                                                  .id
                                                  .toString()),
                                              snapshot.data!.docs
                                                      .elementAt(i)
                                                      .get("voted")
                                                  ? Text(
                                                      "Voted: " +
                                                          snapshot.data!.docs
                                                              .elementAt(i)
                                                              .get("role"),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(""),
                                            ],
                                          )),
                                  ],
                                ),
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("rooms")
                                        .doc(roomId)
                                        .snapshots(),
                                    builder: (_, snapshotHost) {
                                      if (snapshotHost.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else {
                                        var hostname =
                                            snapshotHost.data!.get("hostname");
                                        var winner =
                                            snapshotHost.data!.get("winner");
                                        if (winner == "None") {
                                          if (nickname != hostname) {
                                            if (snapshotHost.data!
                                                .get("mr_white_guessing")) {
                                              return Text(
                                                  "Mr. White is guessing");
                                            } else {
                                              return Text(
                                                  "Only host can start the voting session!");
                                            }

                                            // return FutureBuilder(
                                            //     future: FirebaseFirestore.instance
                                            //         .collection("rooms")
                                            //         .doc(roomId)
                                            //         .get(),
                                            //     builder: ((_, snapshot) {
                                            //       if (snapshot.connectionState ==
                                            //           ConnectionState.waiting) {
                                            //         return CircularProgressIndicator();
                                            //       } else {
                                            //         if (snapshot.data!.get(
                                            //             "mr_white_guessing")) {
                                            //           return Text(
                                            //               "Mr. White is guessing");
                                            //         } else {
                                            //           return Text(
                                            //               "Only host can start the voting session!");
                                            //         }
                                            //       }
                                            //     }));
                                          } else {
                                            if (snapshotHost.data!
                                                .get("mr_white_guessing")) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: ((context) {
                                                      return GameDialog
                                                          .guessDialog(
                                                              roomId: roomId,
                                                              context: context);
                                                    }));
                                              });

                                              return Text(
                                                  "Mr. White is guessing");
                                            } else {
                                              return StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("rooms")
                                                      .doc(roomId)
                                                      .collection("players")
                                                      .snapshots(),
                                                  builder: (_, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    } else {
                                                      return ElevatedButton(
                                                          onPressed: () {
                                                            List<String>
                                                                playersList =
                                                                [];

                                                            snapshot.data!.docs
                                                                .forEach(
                                                                    (element) {
                                                              if (element.get(
                                                                      "voted") ==
                                                                  false) {
                                                                playersList.add(
                                                                    element.id);
                                                              }
                                                            });

                                                            showDialog(
                                                                context: _scaffoldKey
                                                                    .currentContext!,
                                                                builder: ((context) =>
                                                                    GameDialog.votingDialog(
                                                                        context:
                                                                            context,
                                                                        roomId:
                                                                            roomId,
                                                                        players:
                                                                            playersList)));
                                                          },
                                                          child: Text(
                                                              "Vote Now!"));
                                                    }
                                                  });
                                            }
                                          }
                                        } else {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            // Add Your Code here.
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: ((context) {
                                                  return GameDialog.winDialog(
                                                      context: context,
                                                      winner: StringUtils
                                                          .capitalize(winner
                                                              .toString()
                                                              .replaceAll(
                                                                  "_", " ")));
                                                }));
                                          });

                                          return Text("Game Over");
                                        }
                                      }
                                    }),
                              ],
                            ),
                          )
                        : CircularProgressIndicator())
              ],
            ),
          ),
        ));
  }
}

class GamePageArguments {
  final String roomId;
  final String nickname;

  GamePageArguments(
    this.roomId,
    this.nickname,
  );
}
