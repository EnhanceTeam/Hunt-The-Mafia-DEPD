part of "pages.dart";

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static const String routeName = "/game";

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as GamePageArguments;

    final String nickname = args.nickname;
    final String roomId = args.roomId;

    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Text("Hello")
            // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            //     stream: FirebaseFirestore.instance
            //         .collection("rooms")
            //         .doc(args.roomId)
            //         .collection("players")
            //         .snapshots(),
            //     builder: (_, snapshot) => CustomScrollView(
            //           primary: false,
            //           slivers: [
            //             SliverPadding(
            //               padding: EdgeInsets.all(15),
            //               sliver: SliverGrid.count(
            //                 crossAxisCount: 3,
            //                 crossAxisSpacing: 10,
            //                 mainAxisSpacing: 10,
            //                 children: [

            //                   // for (var i = 0;
            //                   //     i < snapshot.data!.docs.length;
            //                   //     i++)
            //                   // Container(
            //                   //     padding: EdgeInsets.all(8),
            //                   //     child: Column(
            //                   //       children: [
            //                   //         CircleAvatar(
            //                   //           backgroundColor: Theme.of(context)
            //                   //               .colorScheme
            //                   //               .onSurfaceVariant,
            //                   //           child: Text(
            //                   //             snapshot.data!.docs
            //                   //                 .elementAt(0)
            //                   //                 .id
            //                   //                 .toString()
            //                   //                 .substring(0, 1)
            //                   //                 .toUpperCase(),
            //                   //             style: TextStyle(
            //                   //               color: Theme.of(context)
            //                   //                   .colorScheme
            //                   //                   .onPrimary,
            //                   //             ),
            //                   //           ),
            //                   //         ),
            //                   //         Text(snapshot.data!.docs
            //                   //             .elementAt(0)
            //                   //             .id
            //                   //             .toString())
            //                   //       ],
            //                   //     )),
            //                 ],
            //               ),
            //             )
            //           ],
            //         ))
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
