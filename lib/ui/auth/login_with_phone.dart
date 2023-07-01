import 'package:firebase/ui/auth/verify_code.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();

  void login() {
    setState(() {
      loading = true;
    });
    auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneNumberController.text}",
      verificationCompleted: (phoneAuthCredential) {
        setState(() {
          loading = false;
        });
      },
      verificationFailed: (error) {
        setState(() {
          loading = false;
        });
        Utils().toastMessage(error.toString());
      },
      codeSent: (String verificationId, int? token) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyCode(verificationId: verificationId),
          ),
        );
        setState(() {
          loading = false;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        // Utils().toastMessage(verificationId.toString());
        setState(() {
          loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login with Phone"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneNumberController,
                    decoration:
                        const InputDecoration(hintText: "+91 234 4565 678"),
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Enter Number";
                          }else{
                            return null;
                          }
                        },
                  ),
                  const SizedBox(height: 40),
                  RoundButton(
                      title: "Login",
                      loading: loading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) ;
                        login();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
