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

    final String player = args.nickname;

    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: RawMaterialButton(
                onPressed: () {},
                splashColor: Color.fromARGB(255, 255, 183, 0),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 30,
                  color: Colors.black,
                ),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
              ),
            ),
            Text(
              "Room Code",
              style: TextStyle(fontSize: 32),
            ),
            Text(
              args.roomId,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    Text("Nickname")
                  ],
                ),
              ],
            )
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
