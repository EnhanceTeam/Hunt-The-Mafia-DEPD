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
      appBar: AppBar(
        title: Text("Dummy Page"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                SizedSpacer.vertical(),
                ElevatedButton(
                    onPressed: () {
                      GameDialog.guessDialog(context: context);
                    },
                    child: const Text("Take a Guess Mr. White")),
                SizedSpacer.vertical(),
                ElevatedButton(
                    onPressed: () {
                      GameDialog.winDialog(context: context);
                    },
                    child: const Text("Winner PopUp")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future guessDialog() => showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text("Kamu adalah Mr. White. Silahkan tebak kata"),
  //         content: const TextField(
  //           decoration:
  //               InputDecoration(hintText: "Tuliskan tebakanmu disini..."),
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text("Submit"))
  //         ],
  //       ),
  //     );
  //
  // Future winDialog() => showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text("Congratulations!"),
  //         content: Wrap(children: [
  //           Center(
  //             child: Column(
  //               children: [
  //                 Lottie.asset("assets/lottie/champion.json", width: 200),
  //                 Text("Semua mafia telah dikalahkan."),
  //                 Text(" Tim Civillian menang!"),
  //               ],
  //             ),
  //           ),
  //         ]),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text("Hooray!"))
  //         ],
  //       ),
  //     );
}
