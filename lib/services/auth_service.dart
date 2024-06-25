import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign In
  signInWithGoogle() async {
    // Create a new instance of GoogleSignIn
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Sign out the current user to prompt the account selection
    await googleSignIn.signOut();

    // Begin interactive sign in process
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

    if (gUser != null) {
      // Obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Finally, let's sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }
}
