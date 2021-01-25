import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AssetImage logoImage=AssetImage('images/logo.png');
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Color(0xFFFFFFFF),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                height: 250,
                width: 250,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: logoImage
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 4,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF163172)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}