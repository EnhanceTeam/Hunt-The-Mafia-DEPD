part of 'widgets.dart';

class GameDialog{
  static AlertDialog guessDialog({required BuildContext context}){
    return AlertDialog(
      title: const Text("Kamu adalah Mr. White. Silahkan tebak kata"),
      content: const TextField(
        decoration:
        InputDecoration(hintText: "Tuliskan tebakanmu disini..."),
      ),
      actions: [TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Submit"))],
    );
  }

  static AlertDialog winDialog({required BuildContext context}){
    return AlertDialog(
      title: const Text("Congratulations!"),
      content: Wrap(children: [
        Center(
          child: Column(
            children: [
              Lottie.asset("assets/lottie/champion.json", width: 200),
              Text("Semua mafia telah dikalahkan."),
              Text(" Tim Civillian menang!"),
            ],
          ),
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Hooray!"))
      ],
    );
  }

}
