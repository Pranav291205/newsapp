import 'package:flutter/material.dart';
import 'package:newsapp/auth/signin.dart';
// ignore: unused_import
import 'package:newsapp/auth/signup.dart';
import 'package:newsapp/screens/homepage.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: [
          Material(
            elevation: 6.0,
            shadowColor: Colors.black38,
            borderRadius: BorderRadius.circular(30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                "images/health.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.7,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          const Center(
            child: Text(
              "News from all over the world\ncan be read here",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          Column(
  children: [
    ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 10),
        padding: const EdgeInsets.symmetric(horizontal: 133, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      child: const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    ),
    const SizedBox(height: 20.0),
    ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      },
      child: const Text(
        "Sign in as Guest",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    ),
  ],
),
],
),
),
),
);
}
}