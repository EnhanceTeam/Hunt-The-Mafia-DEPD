part of 'pages.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);
  static const String routeName = "/main-menu";

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                onPressed: () {
                  Navigator.pushNamed(context, GameRoomPage.routeName);
                },
                elevation: 2.0,
                fillColor: Const.baseColor,
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
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Const.baseColor,
                      size: 45,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.60),
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SettingPage.routeName);
                      },
                      child: const Icon(
                        Icons.settings,
                        color: Const.baseColor,
                        size: 45,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ])),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
              elevation: 8,
              backgroundColor: Const.baseColor,
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
