import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication{
  static final auth=FirebaseAuth.instance;
  static Future signin_with_email(String email,String pass) async{
    print("sign in");
    await auth.signInWithEmailAndPassword(email: email, password: pass);
    print("added");
  }
  static Future createuser(String email,String pass) async{
    await auth.createUserWithEmailAndPassword(email: email, password: pass);
  }




  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static SignOut()async{
    await auth.signOut();
  }
}
