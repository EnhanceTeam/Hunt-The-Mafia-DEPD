part of 'services.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const ProfilePage();
          } else {
            return const MainMenuPage();
          }
        });
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut().then((value) {
      print("User Signed Out");
    });
  }
}
