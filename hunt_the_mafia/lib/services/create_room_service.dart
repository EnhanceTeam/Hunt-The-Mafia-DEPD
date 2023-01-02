part of "services.dart";

class CreateRoomService {
  // static String roomId = "";

  static Future<void> addRooms(String nickname, BuildContext context) {
    CollectionReference roomsRef =
        FirebaseFirestore.instance.collection("rooms");

    String roomId = (new Random().nextInt(900000) + 100000).toString();

    return roomsRef.doc(roomId).set({"hostname": nickname}).then((value) {
      roomsRef.doc(roomId).collection("players").doc(nickname).set({
        "role": null,
      });

      Navigator.pushNamed(
        context,
        PreparationPage.routeName,
        arguments: PreparationPageArguments(
          roomId,
          nickname,
        ),
      );
    }).catchError((error) => {
          Fluttertoast.showToast(
              msg: "Error: $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0)
        });
  }

  // static String getCurrentRoomId() {
  //   return roomId;
  // }
}
