part of 'pages.dart';

class GameRoomPage extends StatefulWidget {
  const GameRoomPage({super.key});

  static const routeName = '/game-room';

  @override
  State<GameRoomPage> createState() => _GameRoomPageState();
}

class _GameRoomPageState extends State<GameRoomPage> {
  bool isPlayerEnough = false;

  void checkPlayerAmount(int playerAmount) {
    if (playerAmount > 1 && playerAmount <= 20) {
      isPlayerEnough = true;
    }

    isPlayerEnough = false;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as GameRoomPageArguments;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: () async {
        // bool isPlayerHost =
        //     await GameRoomService.isPlayerHost(args.roomId, args.nickname);

        // if (!isPlayerHost) {

        await GameRoomService.removePlayer(args.roomId, args.nickname);

        // }

        if (!mounted) return Future.value(false);
        await FirebaseFirestore.instance
            .collection("rooms")
            .doc(args.roomId)
            .collection("players")
            .get()
            .then((value) {
          if (value.docs.isEmpty) {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(args.roomId)
                .delete()
                .then(((value) {
              Navigator.pop(context, false);
            }));
          } else {
            FirebaseFirestore.instance
                .collection("rooms")
                .doc(args.roomId)
                .update({"hostname": value.docs[0].id});
          }
        });
        Navigator.pop(context, false);

        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(),
        body: SafeArea(
          minimum: const EdgeInsets.all(Space.medium),
          child: Column(
            children: [
              Column(
                children: [
                  const Text(
                    'Room Code',
                    style: TextStyle(fontSize: 32),
                  ),
                  Text(
                    args.roomId,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedSpacer.vertical(space: Space.medium),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Space.small),
                  decoration: BoxDecoration(
                      color: const Color(0xFF311A46),
                      borderRadius:
                          BorderRadius.circular(Shape.roundedRectangle)),
                  child: SingleChildScrollView(
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("rooms")
                          .doc(args.roomId)
                          .snapshots(),
                      builder: (_, snapshotHost) =>
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("rooms")
                            .doc(args.roomId)
                            .collection("players")
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error = ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            var hostname = snapshotHost.data!.get("hostname");
                            var data = snapshot.data!.docs;
                            var playerNicknames = data
                                .map((doc) => doc.id)
                                .where((nickname) => nickname != hostname)
                                .toList();

                            return Column(
                              children: [
                                SizedSpacer.vertical(space: Space.small),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: playerNicknames.length + 1,
                                  itemBuilder: ((context, index) {
                                    if (index == 0) {
                                      return WaitingRoomPlayerItemCard(
                                        playerName: hostname,
                                        isHost: true,
                                      );
                                    }

                                    return WaitingRoomPlayerItemCard(
                                      playerName: playerNicknames[index - 1],
                                    );
                                  }),
                                ),
                                SizedSpacer.vertical(space: Space.medium),
                                if (playerNicknames.length < 3) ...[
                                  Text(
                                    'Waiting for players...',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                  SizedSpacer.vertical(space: Space.small)
                                ],
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedSpacer.vertical(space: Space.medium),
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("rooms")
                    .doc(args.roomId)
                    .snapshots(),
                builder: (_, snapshotHost) =>
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("rooms")
                      .doc(args.roomId)
                      .collection("players")
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error = ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      var hostname = snapshotHost.data!.get("hostname");
                      var data = snapshot.data!.docs;
                      var playerNicknames = data.map((doc) {
                        return doc.id;
                      }).toList();
                      bool isPlayerEnough = playerNicknames.length > 2;
                      // bool isPlayerEnough = true;

                      if (args.nickname == hostname) {
                        return PrimaryGameButton(
                          label: 'Start Game',
                          maxSize: true,
                          onPressed: isPlayerEnough
                              ? () {
                                  FirebaseFirestore.instance
                                      .collection("rooms")
                                      .doc(args.roomId)
                                      .update({"preparation": true});

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    PreparationPage.routeName,
                                    (route) => false,
                                    arguments: PreparationPageArguments(
                                      args.roomId,
                                      args.nickname,
                                      playerNicknames.length,
                                    ),
                                  );
                                }
                              : null,
                        );
                      } else {
                        // return Text("Waiting for host to start the game");
                        return StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection("rooms")
                              .doc(args.roomId)
                              .snapshots(),
                          builder: (_, snapshotRoomReadiness) {
                            if (snapshotRoomReadiness.hasError) {
                              return Text(
                                  "Error = ${snapshotRoomReadiness.error}");
                            } else if (snapshotRoomReadiness.hasData) {
                              var preparationPhase = snapshotRoomReadiness.data!
                                  .get("preparation");

                              var gameStart =
                                  snapshotRoomReadiness.data!.get("gameStart");

                              if (!preparationPhase && !gameStart) {
                                return Text(
                                    "Waiting for host to start the game");
                              } else if (preparationPhase) {
                                return Text(
                                    "Waiting for host in preparation phase");
                              } else if (gameStart) {
                                // WidgetsBinding.instance
                                //     .addPostFrameCallback((_) {
                                Future.delayed(Duration(milliseconds: 2500),
                                    () {
                                  GameplayService.showPlayerRole(
                                      args.nickname,
                                      args.roomId,
                                      _scaffoldKey.currentContext!);
                                });
                              }
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              SizedSpacer.vertical(space: Space.large),
              const Text(
                'Note: Max players is 20 and min players is 3',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameRoomPageArguments {
  final String roomId;
  // final String hostname;
  final String nickname;

  GameRoomPageArguments(
    this.roomId,
    // this.hostname,
    this.nickname,
  );
}
