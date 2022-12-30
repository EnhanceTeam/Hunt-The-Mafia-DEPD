part of 'pages.dart';

class PreparationPage extends StatefulWidget {
  const PreparationPage({Key? key}) : super(key: key);

  static const String routeName = "/preparation";

  @override
  State<PreparationPage> createState() => _PreparationPageState();
}

class _PreparationPageState extends State<PreparationPage> {
  @override
  Widget build(BuildContext context) {
    int _count = 0;
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(Space.large),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedSpacer.vertical(space: Space.medium),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Room Code',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedSpacer.vertical(space: Space.medium),
                    Text(
                      'N1310',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              SizedSpacer.vertical(space: Space.medium),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _count++;
                    });
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
                Text('$_count', style: const TextStyle(fontSize: 60.0)),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _count--;
                    });
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.remove,
                      color: Colors.black),
                ),
              ],
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
