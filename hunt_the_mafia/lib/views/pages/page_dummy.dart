part of 'pages.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({Key? key}) : super(key: key);
  static const String routeName = "/dummy";

  @override
  State<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Dummy Page"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MainMenuPage.routeName);
                  },
                  child: const Text("Main menu"),
                ),
                SizedSpacer.vertical(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          GameDialog.createDialog(context: context),
                    );
                  },
                  child: const Text("Create room"),
                ),
                SizedSpacer.vertical(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          GameDialog.joinDialog(context: context),
                    );
                  },
                  child: const Text("Join room"),
                ),
                SizedSpacer.vertical(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ShopPage.routeName);
                  },
                  child: const Text("Shop"),
                ),
                SizedSpacer.vertical(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, GameRoomPage.routeName);
                  },
                  child: const Text("Game room"),
                ),
                SizedSpacer.vertical(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, GamePage.routeName);
                  },
                  child: const Text("Game"),
                ),
                SizedSpacer.vertical(),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            GameDialog.guessDialog(context: context),
                      );
                    },
                    child: const Text("Take a Guess Mr. White")),
                SizedSpacer.vertical(),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            GameDialog.winDialog(context: context),
                      );
                    },
                    child: const Text("Winner PopUp")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
