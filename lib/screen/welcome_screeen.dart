
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktuck/data/colors.dart';
import 'package:tiktuck/screen/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 30,
          ),
          child:
            Column(
              children: [
                SizedBox(
                    height: 200,
                    child: Image.asset('img/logo.webp'),
                  ),Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                ),
                child: Text(
                  "Take control of your meals and discover a world of culinary possibilities with our innovative food management and meal suggestion app.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: tipo,
                    fontSize: 16,
                  ),
                ),),SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () { setState(() {
                    LoginScreen();
                  });},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tipo,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(13),
                  ),
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                      color: unselectedColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              ],
            ),
        ),
            
      
            
            
            
          ]));
        
      
    
  }
}
