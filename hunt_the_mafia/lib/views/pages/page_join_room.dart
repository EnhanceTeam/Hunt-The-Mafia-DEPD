part of 'pages.dart';

class Joinroom extends StatefulWidget {
  const Joinroom({super.key});

  @override
  State<Joinroom> createState() => _JoinroomState();
}

class _JoinroomState extends State<Joinroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFF311A46),
            ),
            height: 300,
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: (RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal)),
                    onPressed: (() {}),
                    child: const Text(
                      'Create New Game',
                      style: TextStyle(color: Color(0xFF311A46)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 30,
                ),
                SizedBox(
                  width: 250,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: (RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal)),
                    onPressed: (() {}),
                    child: const Text(
                      'Joinroom Game with Code',
                      style: TextStyle(color: Color(0xFF311A46)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    ])));
  }
}
