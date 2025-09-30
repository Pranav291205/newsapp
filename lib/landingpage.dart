import 'package:flutter/material.dart';
import 'package:newsapp/registration/signin.dart';
// ignore: unused_import
import 'package:newsapp/registration/signup.dart';

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
          const SizedBox(height: 60.0),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        
                        minimumSize: const Size(150, 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 133, vertical: 16),
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
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
}
}