import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About DDU Payroll System',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'The DDU Payroll System is designed to streamline payroll management, ensuring that employees are paid accurately and on time. Our platform simplifies payroll calculations, tax deductions, and compliance with regulatory requirements.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Our Team\'s Motive',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'At DDU Payroll System, our team is dedicated to making payroll management efficient and reliable. We continuously innovate to improve our platform, ensuring it meets the highest standards of security, accuracy, and user satisfaction.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'A Special Thank You',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We would like to extend our heartfelt gratitude to Mr. Biniyam for giving us the opportunity to work on this project. His support and guidance have been invaluable, and we are grateful for the trust he placed in us. Thank you, Mr. Biniyam, for believing in our team and this vision!',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
