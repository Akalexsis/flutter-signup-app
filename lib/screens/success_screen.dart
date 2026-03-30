/* 
    Author - Kayla Thornton
    Purpose - Routes users to success page after creating a new account
 */
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
    final String name; 
    const SuccessPage({super.key, required this.name});

    @override
    Widget build(BuildContext context) {
        return Scaffold( // 👨 Parent
            body: Center(
                child: Text(
                    'Welcome ${name}!'
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                )
            )
        );
    }
} 