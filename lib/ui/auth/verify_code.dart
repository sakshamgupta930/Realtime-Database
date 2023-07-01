import 'package:firebase/ui/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final verifyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: verifyController,
              decoration: const InputDecoration(hintText: "6 digits code"),
            ),
            const SizedBox(height: 40),
            RoundButton(
              title: "Verify",
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verifyController.text.toString(),
                );

                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(),
                    ),
                  );
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
