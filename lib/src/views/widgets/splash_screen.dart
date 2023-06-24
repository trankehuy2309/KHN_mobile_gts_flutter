import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:khn_tracking/src/views/pages/control_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ControlPage()),
            (route) => false);
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    // Get.find<LoginController>().statusLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0,
          duration: const Duration(milliseconds: 1200),
          child: Lottie.asset('assets/files/car-running.json'),
        ),
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: [
    //         Theme.of(context).accentColor,
    //         Theme.of(context).primaryColor
    //       ],
    //       begin: const FractionalOffset(0, 0),
    //       end: const FractionalOffset(1.0, 0.0),
    //       stops: const [0.0, 1.0],
    //       tileMode: TileMode.clamp,
    //     ),
    //   ),
    //   child: AnimatedOpacity(
    //     opacity: _isVisible ? 1.0 : 0,
    //     duration: const Duration(milliseconds: 1200),
    //     child: Center(
    //       child: Container(
    //         height: 140.0,
    //         width: 140.0,
    //         child: const Center(
    //           child: ClipOval(
    //             child: Image(image: AssetImage('assets/images/logo_khn.png')),
    //             //put your logo here
    //           ),
    //         ),
    //         decoration: BoxDecoration(
    //             shape: BoxShape.circle,
    //             color: Colors.white,
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withOpacity(0.3),
    //                 blurRadius: 2.0,
    //                 offset: const Offset(5.0, 3.0),
    //                 spreadRadius: 2.0,
    //               )
    //             ]),
    //       ),
    //     ),
    //   ),
    // );
  }
}
