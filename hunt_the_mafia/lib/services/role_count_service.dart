part of 'services.dart';

class RoleCountService{
  static Future<void> addRole(String roomId, String roleName, int roleCount) {
    CollectionReference roomsRef =
    FirebaseFirestore.instance.collection("rooms");

    return roomsRef.doc(roomId).update({roleName: roleCount});
  }
}