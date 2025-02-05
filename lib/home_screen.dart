import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App logo or any image
              Icon(
                Icons.account_balance_wallet,
                size: 120,
                color: Colors.blueAccent,
              ),
              SizedBox(height: 40),
              // Title
              Text(
                'DDU Payroll System',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              // Description text
              Text(
                'Effortless payroll management for businesses of all sizes.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              // Start button
             
              SizedBox(height: 20),
              // Additional action button, like contact or info
              
            ],
          ),
        ),
      ),
    );
  }
}
