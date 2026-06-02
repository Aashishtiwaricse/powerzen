import 'package:_attandance/Screens/Home/home.dart';
import 'package:_attandance/Screens/Login/loginScreen.dart';
import 'package:_attandance/SesssionManager/sessionManager.dart';
import 'package:flutter/material.dart';

class Appstartup extends StatefulWidget {
  const Appstartup({super.key});

  @override
  State<Appstartup> createState() => _AppstartupState();
}

class _AppstartupState extends State<Appstartup> {
  @override
  void initState() {
    super.initState();
    startApp();
  }

  Future<void> startApp() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      print("Splash delay done");

      if (!mounted) return;

      final token = await SessionManager.getToken();

      print("Token: $token");

      if (!mounted) return;

      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      }
    } catch (e) {
      print("Startup Error: $e");

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
    
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: Image.asset(
              "assets/powerzen.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}