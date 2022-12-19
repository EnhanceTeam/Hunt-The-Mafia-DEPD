part of 'widgets.dart';

class GuessDialog{
  Future guessDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Kamu adalah Mr. White. Silahkan tebak kata"),
          content: const TextField(
            decoration:
                InputDecoration(hintText: "Tuliskan tebakanmu disini..."),
          ),
          actions: [TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Submit"))],
        ),
      );
}
