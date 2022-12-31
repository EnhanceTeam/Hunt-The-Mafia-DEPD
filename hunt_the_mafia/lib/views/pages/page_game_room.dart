part of 'pages.dart';

class GameRoomPage extends StatefulWidget {
  const GameRoomPage({super.key});

  static const routeName = '/game-room';

  @override
  State<GameRoomPage> createState() => _GameRoomPageState();
}

class _GameRoomPageState extends State<GameRoomPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as GameRoomPageArguments;

    return WillPopScope(
      onWillPop: () {
        GameRoomServie.removePlayer(args.roomId, args.nickname);

        Navigator.pop(context, false);

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          minimum: const EdgeInsets.all(Space.medium),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Room Code',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedSpacer.vertical(space: Space.small),
                  Text(
                    'N1310',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              SizedSpacer.vertical(space: Space.medium),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(Space.small),
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
                      builder: (_, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error = ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          var data = snapshot.data!.data();
                          var hostname = data!['hostname'];
                          var playerNicknames = data['playerNicknames'];

                          return Column(
                            children: [
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
                              if (playerNicknames.length < 4)
                                Text(
                                  'Waiting for players...',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                              SizedSpacer.vertical(space: Space.medium),
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
              SizedSpacer.vertical(space: Space.medium),
              PrimaryGameButton(
                label: 'Start Game',
                maxSize: true,
                onPressed: () {},
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
  final String nickname;

  GameRoomPageArguments(
    this.roomId,
    this.nickname,
  );
}
