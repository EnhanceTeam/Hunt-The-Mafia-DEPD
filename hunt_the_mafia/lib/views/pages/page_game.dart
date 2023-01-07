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
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("rooms")
                      .doc(roomId)
                      .collection("players")
                      .doc(nickname)
                      .get(),
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
                                                radius: 30,
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
                                                  .toString())
                                            ],
                                          )),
                                  ],
                                ),
                                FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection("rooms")
                                        .doc(roomId)
                                        .get(),
                                    builder: (_, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else {
                                        var hostname =
                                            snapshot.data!.get("hostname");

                                        if (nickname != hostname) {
                                          return Text(
                                              "Only host can start the voting session!");
                                        } else {
                                          return FutureBuilder(
                                              future: FirebaseFirestore.instance
                                                  .collection("rooms")
                                                  .doc(roomId)
                                                  .collection("players")
                                                  .get(),
                                              builder: (_, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator();
                                                } else {
                                                  return ElevatedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: ((context) =>
                                                                GameDialog.votingDialog(
                                                                    context:
                                                                        context,
                                                                    roomId:
                                                                        roomId,
                                                                    players: snapshot
                                                                        .data!
                                                                        .docs
                                                                        .map((e) =>
                                                                            e.id)
                                                                        .toList())));
                                                      },
                                                      child: Text("Vote Now!"));
                                                }
                                              });
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
