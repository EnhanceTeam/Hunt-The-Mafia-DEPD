part of 'pages.dart';

class Mainmenu extends StatefulWidget {
  const Mainmenu({Key? key}) : super(key: key);

  @override
  _MainmenuState createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hunt The Mafia",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 32,
              ),
              RawMaterialButton(
                onPressed: () {},
                splashColor: Color.fromARGB(255, 255, 183, 0),
                elevation: 2.0,
                fillColor: Color.fromARGB(255, 49, 26, 70),
                child: Icon(
                  Icons.play_arrow,
                  size: 100,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              SizedBox(height: 32),
              Text(
                "Play",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins"),
              )
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(height: 50),
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    Icons.language,
                    size: 45,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.65),
                  Icon(
                    Icons.settings,
                    size: 45,
                  )
                ],
              ),
            ),
          ],
        ),
      ])),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
              elevation: 8,
              backgroundColor: Color.fromARGB(255, 49, 26, 70),
              splashColor: Color.fromARGB(255, 255, 183, 0),
              onPressed: () {},
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
