import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsapp/homepage.dart';
import 'package:newsapp/registration/forgotpass.dart';
import 'package:newsapp/registration/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;

  // Show snackbar message
  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Sign in user
  Future<void> signIn() async {
    setState(() {
      isloading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Navigate to homepage after login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar("Error: ${e.message ?? e.code}");
    } catch (e) {
      showSnackbar("Something went wrong. Please try again.");
    }

    setState(() {
      isloading = false;
    });
  }
  google() async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
    // prompt: 'select_account', // This is key for showing account picker
  );

  await googleSignIn.signOut(); // Ensure it doesn't reuse previous account

  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  await FirebaseAuth.instance.signInWithCredential(credential);

  // Navigate to Verify page
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const Home()),
  );
}

  signout() async {
    await FirebaseAuth.instance.signOut(); // Firebase logout
    await GoogleSignIn().signOut();       // Google logout

    // Navigate back to this Google sign in page replacing current
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => google()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login to Flutter",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(
              "News",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              )
              ],
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0.0,
      ),
            body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        const Text(
          'Welcome Back!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: email,
          decoration: InputDecoration(
            hintText: 'Enter email',
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter password',
            prefixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: signIn,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.blue,
            ),
            child: const Text("Login", style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPass()),
            );
          },
          child: const Text("Forgot Password?",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Signup()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
          ),
          child: const Text("Sign Up", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: google,
          icon: const Icon(Icons.login),
          label: const Text("Sign In with Google",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    ),
  ),
),
);
}
}
