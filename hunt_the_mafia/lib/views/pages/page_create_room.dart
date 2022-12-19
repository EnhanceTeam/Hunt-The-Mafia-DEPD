part of 'pages.dart';

class Createroom extends StatefulWidget {
  const Createroom({super.key});

  @override
  State<Createroom> createState() => _CreateroomState();
}

class _CreateroomState extends State<Createroom> {
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
            height: 200,
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Enter Code",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Poppins"),
                      ),
                  ],
                ),
                SizedBox(
                  width: 250,
                  height: 30,
                ),
                SizedBox(
                    width: 250,
                    height: 60,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        hintText: 'Enter code here!',
                        hintStyle:
                            TextStyle(fontSize: 15.0, color: Color(0xFF311A46)),
                      ),
                    )),
              ],
            ),
          )
        ],
      )
    ])));
  }
}
