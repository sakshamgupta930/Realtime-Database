import 'dart:async';

import 'package:firebase/ui/auth/login_Screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
      email: _emailcontroller.text.toString(),
      password: _passwordcontroller.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SignUp",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter email";
                      }
                      // else {
                      //   return null;
                      // }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.key),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            RoundButton(
              title: 'SignUp',
              loading: loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  login();
                  Utils().toastMessage("Creating User");
                  Timer(Duration(seconds: 2), () {
                    Utils().toastMessage("User Created");
                  });
                  Timer(Duration(seconds: 3), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  });
                }
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text("Login"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
