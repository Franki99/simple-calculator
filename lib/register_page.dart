import "package:coffee_card/components/my_button.dart";
import "package:coffee_card/components/square_tile.dart";
import "package:coffee_card/components/textfield.dart";
import "package:coffee_card/services/auth_service.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign up user method
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try registering a user
    try {
      //check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // show error message
        showErrorMessage("Passwords don't match");
      }
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  //wrong email message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                //logo
                Icon(
                  Icons.lock,
                  size: 50,
                ),
                const SizedBox(height: 20),
                Text(
                  "Create an account to enjoy our services",
                  style: TextStyle(color: Colors.grey[800], fontSize: 16),
                ),
                const SizedBox(height: 20),
                //Email TextField
                Mytextfield(
                  controller: emailController,
                  hinText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                //password textfield
                Mytextfield(
                  controller: passwordController,
                  hinText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                //password textfield
                Mytextfield(
                  controller: confirmPasswordController,
                  hinText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                //sign in Button
                Mybutton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with:',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //google & github sign-in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    //Google button
                    SquareTile(
                      onTap: () async {
                        User? user = await AuthService().signInWithGoogle();
                        if (user != null) {
                          // Handle successful sign-in
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          // Handle sign-in error
                          showErrorMessage('Google sign-in failed');
                        }
                      },
                      imagePath: 'lib/images/download.jfif',
                    ),
                    const SizedBox(width: 10),
                    //github button
                    SquareTile(
                      onTap: () {},
                      imagePath: 'lib/images/github.jpg',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                //not a member? register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
