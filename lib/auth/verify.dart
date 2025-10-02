import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/homepage.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool isVerified = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    sendVerifyLink();
  }

  Future<void> sendVerifyLink() async {
    final user = FirebaseAuth.instance.currentUser!;
    if (!user.emailVerified) {
      try {
        await user.sendEmailVerification();
        showSnackbar('A verification link has been sent to your email');
      } catch (e) {
        showSnackbar('Failed to send verification link.');
      }
    } else {
      showSnackbar('Email is already verified.');
      setState(() {
        isVerified = true;
      });
    }
  }

  Future<void> reload() async {
    setState(() => isLoading = true);

    await FirebaseAuth.instance.currentUser!.reload();
    final user = FirebaseAuth.instance.currentUser!;

    if (user.emailVerified) {
      setState(() => isVerified = true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      setState(() => isVerified = false);
      showSnackbar("Email not verified yet.");
    }

    setState(() => isLoading = false);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text(
      "Verification",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.blueAccent,
    centerTitle: true,
    elevation: 4,
  ),
  body: Padding(
    padding: const EdgeInsets.all(28.0),
    child: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : const Text(
              '📬\nCheck your email inbox\n\nA verification link has been sent.\n \nPress reload button after verification to enter APP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
    ),
  ),
  floatingActionButton: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      FloatingActionButton(
        heroTag: 'reload',
        onPressed: isLoading ? null : reload,
        tooltip: isVerified ? 'Verified' : 'Reload to Check Verification',
        backgroundColor: isVerified ? Colors.green : Colors.blueAccent,
        child: const Icon(Icons.refresh),
      ),
      const SizedBox(height: 12),
      FloatingActionButton(
        heroTag: 'signout',
        onPressed: isLoading ? null : signOut,
        tooltip: 'Sign Out',
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.logout),
      ),
    ],
  ),
);
}
}
