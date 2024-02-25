import 'package:flutter/material.dart';
import 'signup.dart';
import 'page2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_lib.dart' as user;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none
              ),
              fillColor: Colors.blue.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.account_circle)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        Text(
          errorMessage,
          style: TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            var username = usernameController.text;
            var password = passwordController.text;

            if (username == "" || password == "") {
              return;
            }

            var url = Uri.parse('http://127.0.0.1:5000/login/$username/$password'); // replace with your URL
            var response = await http.get(url);

            var success = jsonDecode(response.body)["status"];

            if (success == 'success') {
              user.setName(username);
              user.setUserID(jsonDecode(response.body)["UserID"]);

              Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              Navigator.push(context, MaterialPageRoute(builder: (context) => Page2()));
            } else {
              setState(() {
                errorMessage = 'Username or password invalid';
              });
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Forgot Password?"),
              content: const Text("Enter your email address and we will send you a link to reset your password."),
              actions: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Email Sent"),
                          content: const Text("An email has been sent to your email address. Please click the link in the email to reset your password."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("WOMP WOMP"),
                                      content: Image.asset("images/).png"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("LOL"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Confirm"),
                ),
              ],
            );
          },
        );
      },
      child: const Text("Forgot password?",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
            },
            child: const Text("Sign Up", style: TextStyle(color: Colors.blue),)
        )
      ],
    );
  }
}