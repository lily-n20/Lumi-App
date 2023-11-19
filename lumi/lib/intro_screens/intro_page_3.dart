import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[100],
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the column
            children: <Widget>[
              const Text(
                'L U M I', // Replace with your desired text
                style: TextStyle(
                  fontSize: 24, // Optional: Adjust the font size
                  fontWeight: FontWeight.bold, // Optional: Adjust the font weight
                  color: Colors.black, // Optional: Adjust the text color
                ),
              ),
              const SizedBox(height: 30), // Optional: Add space between text and Lottie asset
              Lottie.asset('lib/assets/ghibli.json'),
            ],
          ),
        ),
      ),
    );
  }
}