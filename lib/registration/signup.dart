import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/registration/verify.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    email.addListener(_checkInput);
    password.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      isButtonEnabled = email.text.trim().isNotEmpty && password.text.trim().isNotEmpty;
    });
  }

  Future<void> signup() async {
    final String emailText = email.text.trim();
    final String passwordText = password.text.trim();

    final passwordRegex = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'
);

    if (!passwordRegex.hasMatch(passwordText)) {
      showSnackbar('Invalid Password', 'Password must be at least 8 characters and include uppercase, lowercase, number, and special character.');
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailText,
        password: passwordText,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Verify()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already registered.';
      } else {
        errorMessage = e.message ?? 'Signup failed. Please try again.';
      }
      showSnackbar('Signup Error', errorMessage);
    } catch (e) {
      showSnackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  void showSnackbar(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$title\n$message"),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text(
      "Sign Up",
      style: TextStyle(color: Colors.white  ,fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.blueAccent,
    elevation: 4,
    centerTitle: true,
  ),
  body: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Create your account",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isButtonEnabled ? signup : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(color:Colors.white ,fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  ),
);
}
}
