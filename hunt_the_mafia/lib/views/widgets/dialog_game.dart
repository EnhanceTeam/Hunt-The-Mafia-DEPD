part of 'widgets.dart';

class GameDialog {
  static AlertDialog guessDialog({required BuildContext context}) {
    return AlertDialog(
      title: const Text("Kamu adalah Mr. White. Silahkan tebak kata"),
      content: const TextField(
        decoration: InputDecoration(hintText: "Tuliskan tebakanmu disini..."),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Submit"))
      ],
    );
  }

  static AlertDialog winDialog({required BuildContext context}) {
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

  static AlertDialog joinDialog({required BuildContext context}) {
    return AlertDialog(
      backgroundColor: Color(0xFF311A46),
      content: Wrap(children: [
        Center(
            child: Container(
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
        )),
      ]),
    );
  }

  static AlertDialog createOrJoinDialog({required BuildContext context}) {
    return AlertDialog(
      backgroundColor: Color(0xFF311A46),
      content: Wrap(children: [
        Center(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xFF311A46),
          ),
          height: 250,
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
        )),
      ]),
    );
  }

  static AlertDialog createDialog({required BuildContext context}) {
    final ctrlNickname = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      backgroundColor: Color(0xFF311A46),
      content: Wrap(children: [
        Center(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xFF311A46),
          ),
          height: 220,
          width: 330,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 60,
                child: Form(
                    child: TextFormField(
                  key: _formKey,
                  controller: ctrlNickname,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    hintText: 'Enter nickname!',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter nickname';
                    }

                    if (value.length > 8) {
                      return 'Nickname must be less than 8 characters';
                    }

                    return null;
                  },
                )),
              ),
              SizedBox(
                width: 250,
                height: 20,
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  onPressed: (() {
                    // todo: create room and change page to room page
                    if (ctrlNickname == null || ctrlNickname.text.isEmpty) {
                      // Toast null nickname error
                    } else if (ctrlNickname.text.length > 8) {
                      // Toast nickname too long error
                    } else {
                      CreateRoomService.addRooms(ctrlNickname.text.trim())
                          .then((value) => {
                                // Navigate to room page
                              })
                          .catchError((onError) => {
                                // Toast firebase or connection error
                              });
                      // Navigate to room page
                    }
                  }),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Color(0xFF311A46)),
                  ),
                ),
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
