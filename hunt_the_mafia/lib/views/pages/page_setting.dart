part of 'pages.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  static const routeName = '/setting';

  @override
  _SettingPageState createState() => _SettingPageState();
}

_openSourceCode() async {
  var url = Uri.parse('https://github.com/EnhanceTeam/Hunt-The-Mafia-DEPD');

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw "Could not launch $url";
  }
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        iconTheme: IconThemeData(color: Const.baseColor),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Night Mode",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Switch(
                  value: false,
                  onChanged: ((value) {
                    value == true ? false : true;
                  }),
                  activeColor: Const.baseColor,
                )
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Source Code",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              RawMaterialButton(
                onPressed: (() async {
                  await _openSourceCode();
                }),
                child: Icon(Icons.open_in_new),
              )
            ],
          ),
          SizedBox(height: 24),
          Container(
            width: MediaQuery.of(context).size.width * 90,
            child: ElevatedButton(
              onPressed: () {
                //Logout
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.logout_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Logout")
                  ]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Const.baseColor,
                foregroundColor: Const.accentColor,
                elevation: 4,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
