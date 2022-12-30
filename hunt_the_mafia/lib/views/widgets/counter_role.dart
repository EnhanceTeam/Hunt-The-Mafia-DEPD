part of 'widgets.dart';

class RoleCounter extends StatefulWidget {
  const RoleCounter({Key? key, required this.roleName, required this.initialCount}) : super(key: key);

  final String roleName;
  final int initialCount;

  @override
  State<RoleCounter> createState() => _RoleCounterState();
}

class _RoleCounterState extends State<RoleCounter> {


  @override
  Widget build(BuildContext context) {
    int _count = 0;

    return Center(
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
            child: const Icon(IconData(0xe15b, fontFamily: 'MaterialIcons'),
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}
