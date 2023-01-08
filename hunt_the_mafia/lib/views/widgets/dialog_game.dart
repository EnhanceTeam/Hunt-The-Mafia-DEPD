part of 'widgets.dart';

class GameDialog {
  static StatefulBuilder votingDialog(
      {required var context,
      required List<String> players,
      required String roomId}) {
    // final ctrlNickname = TextEditingController();
    // final _formKey = GlobalKey<FormState>();
    var selectedPlayer = null;

    return StatefulBuilder(
      builder: ((context, setState) {
        return AlertDialog(
          title: const Text("Who to Vote?"),
          content: Wrap(children: [
            Center(
                child: Container(
              height: 220,
              width: 330,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 75,
                    child: Form(
                        child: DropdownButton(
                            value: selectedPlayer,
                            hint: Text("Select a player..."),
                            items: players
                                .map((player) => DropdownMenuItem(
                                    value: player, child: Text(player)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedPlayer = value.toString();
                              });
                            })),
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
                          backgroundColor: Colors.black,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      onPressed: (() {
                        // todo: create room and change page to room page
                        if (selectedPlayer.isEmpty || selectedPlayer == null) {
                          Fluttertoast.showToast(
                              msg: "Selected player cannot be empty!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          // todo: check if nickname role is mr white or not
                          GameplayService.voteProcess(
                              selectedPlayer, roomId, context);
                        }
                      }),
                      child: const Text(
                        'Vote!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ]),
        );
      }),
    );
  }

  static AlertDialog guessDialog({
    required BuildContext context,
    required String roomId,
  }) {
    final ctrlGuessWord = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: const Text("You are Mr. White. Guess the word"),
      content: Form(
          child: TextFormField(
        key: _formKey,
        controller: ctrlGuessWord,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
          hintText: 'Enter the word...',
        ),
      )),
      actions: [
        TextButton(
            onPressed: () {
              if (ctrlGuessWord != null || ctrlGuessWord.text.isNotEmpty) {
                GameplayService.guessProcess(
                    roomId, ctrlGuessWord.text.toString(), context);
              } else {
                Fluttertoast.showToast(
                    msg: "Guess word cannot be empty!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Text("Submit"))
      ],
    );
  }

  static AlertDialog winDialog(
      {required BuildContext context, required String winner}) {
    return AlertDialog(
      title: const Text("Congratulations!"),
      content: Wrap(children: [
        Center(
          child: Column(
            children: [
              Lottie.asset("assets/lottie/champion.json", width: 200),
              Text("$winner win!"),
            ],
          ),
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                context,
                MainMenuPage.routeName,
                (route) => false,
              );
            },
            child: Text("Hooray!"))
      ],
    );
  }

  static AlertDialog joinDialog(
      {required BuildContext context, bool mounted = true}) {
    final codeController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    String? validateCode(String? code) {
      if (code == null || code.isEmpty) {
        return 'Please enter room code';
      } else if (code.length != 6) {
        return 'Room code must be 6 digits';
      }
      return null;
    }

    return AlertDialog(
      backgroundColor: const Color(0xFF311A46),
      content: Wrap(
        children: [
          SizedBox(
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Enter Code",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
                SizedSpacer.vertical(space: Space.large),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: codeController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(Space.medium),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      hintText: 'Enter code here!',
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFF311A46),
                      ),
                    ),
                    validator: (value) {
                      return validateCode(value);
                    },
                  ),
                ),
                SizedSpacer.vertical(space: Space.medium),
                PrimaryGameButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String roomId = codeController.text;
                      bool isRoomExists =
                          await JoinRoomService.isRoomExists(roomId);
                      bool roomHasStarted =
                          await JoinRoomService.roomHasStarted(roomId);

                      if (isRoomExists) {
                        if (!roomHasStarted) {
                          if (!mounted) return;
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                GameDialog.joinEnterNicknameDialog(
                                    roomId: roomId, context: context),
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: "This room has started the game!");
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Room doesn't exist",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    }
                  },
                  label: "Enter room",
                  foregroundColor: const Color(0xFF311A46),
                  backgroundColor: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static AlertDialog joinEnterNicknameDialog({
    required String roomId,
    required BuildContext context,
    bool mounted = true,
  }) {
    final nicknameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    String? validateNickname(String? nickname) {
      if (nickname == null || nickname.isEmpty) {
        return 'Please enter a nickname';
      }

      return null;
    }

    return AlertDialog(
      backgroundColor: const Color(0xFF311A46),
      content: Wrap(
        children: [
          SizedBox(
            width: 330,
            child: Column(
              children: [
                SizedSpacer.vertical(),
                const Text(
                  "Enter Nickname",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedSpacer.vertical(space: Space.large),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: nicknameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(Space.medium),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: "Enter nickname here!",
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFF311A46),
                      ),
                    ),
                    validator: (value) {
                      return validateNickname(value);
                    },
                  ),
                ),
                SizedSpacer.vertical(space: Space.medium),
                PrimaryGameButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String nickname = nicknameController.text.trim();
                      bool isNicknameExistsInRoom =
                          await JoinRoomService.isNicknameExistsInRoom(
                              roomId, nickname);
                      if (!isNicknameExistsInRoom) {
                        String hostname =
                            await JoinRoomService.getHostname(roomId);
                        if (!mounted) return;
                        Navigator.of(context).pop();
                        Navigator.pushNamed(
                          context,
                          GameRoomPage.routeName,
                          arguments: GameRoomPageArguments(
                            roomId,
                            nickname,
                            // nickname,
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Nickname already exists",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    }
                  },
                  label: "Join Game",
                  foregroundColor: const Color(0xFF311A46),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
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
                  onPressed: (() {
                    // todo: Navigate to create room pop up
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          GameDialog.createDialog(context: context),
                    );
                  }),
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
                  onPressed: (() {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          GameDialog.joinDialog(context: context),
                    );
                  }),
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
                height: 75,
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
                      Fluttertoast.showToast(
                          msg: "Nickname cannot be empty!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (ctrlNickname.text.length > 8) {
                      Fluttertoast.showToast(
                          msg: "Nickname cannot be more than 8 characters!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      CreateRoomService.addRooms(
                          ctrlNickname.text.trim(), context);
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

  static AlertDialog roleDialog(
      {required BuildContext context,
      required String nickname,
      required String role,
      required String roomCode,
      required String word,
      required String word2}) {
    return AlertDialog(
      content: Wrap(
        children: [
          Center(
            child: Column(
              children: [
                SizedSpacer.vertical(space: Space.medium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(nickname, style: TextStyle(fontSize: 18)),
                    SizedSpacer.horizontal(space: Space.small),
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.onSurfaceVariant,
                      child: Text(
                        nickname.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    SizedSpacer.horizontal(space: Space.small),
                    Text(role, style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedSpacer.vertical(space: Space.medium),
                const Text('Your secret word is:',
                    style: TextStyle(fontSize: 14, color: Colors.black54)),
                SizedSpacer.vertical(space: Space.medium),
                role == "mr_black"
                    ? Text(word + " and " + word2,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                    : Text(word,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                context,
                GamePage.routeName,
                (route) => false,
                arguments: GamePageArguments(roomCode, nickname),
              );
            },
            child: const Text("OK"))
      ],
    );
  }

  static AlertDialog describeDialog({required BuildContext context}) {
    return AlertDialog(
      content: Wrap(
        children: [
          SizedBox(
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Describe your word to the others",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedSpacer.vertical(space: Space.small),
                SizedBox(
                  width: 200.0,
                  height: 40.0,
                  child: PrimaryGameButton(
                      onPressed: () {},
                      label: "NEXT",
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF311A46)),
                ),
                SizedSpacer.vertical(space: Space.small),
                const Text('push the button if you are done',
                    style: TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static AlertDialog waitDialog({required BuildContext context}) {
    return const AlertDialog(
      title: Text(
        "Daniel",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "Poppins",
        ),
      ),
      content: Text('is describing their word',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.black)),
    );
  }
}
