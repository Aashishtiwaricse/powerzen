import 'package:_attandance/Authservice/authService.dart';
import 'package:_attandance/Screens/Home/home.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool isLoading = false;
  bool isPasswordVisible = false;

 Future<void> handleLogin() async {
  setState(() => isLoading = true);

  final result = await _authService.login(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
  );

  setState(() => isLoading = false);

  if (result["success"] == true) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result["message"])),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result["message"]), // 🔥 REAL ERROR FROM API
        backgroundColor: Colors.red,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 Background Logo
          Positioned.fill(
            child: Opacity(
              opacity: 0.08, // adjust for watermark effect
              child: Image.asset(
                "assets/powerzen.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🔷 Main UI
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    /// 🔷 Logo Top
                    Image.asset(
                      "assets/powerzen.png",
                      height: 120,
                    ),

                    const SizedBox(height: 30),

                    /// 🔷 Title
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Login to continue",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    /// 📧 Email Field
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔒 Password Field
                    TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// 🔘 Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : handleLogin,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔗 Footer
                  
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}