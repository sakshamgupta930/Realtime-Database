import 'package:firebase/firebase_services/splash_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Firebase",
              style: TextStyle(fontSize: 30),
            ),
            LoadingAnimationWidget.staggeredDotsWave(color: Colors.black, size: 50)
          ],
        ),
      ),
    );
  }
}
