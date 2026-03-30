/* 
    Author - Kayla Thornton
    Purpose - Signup form for users to create a new account
 */
import 'package:flutter/material.dart';
import './success_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
    // 🔑 The Global Key - acts like a remote control for the form
    final _formKey = GlobalKey<FormState>();

    // change visibility for password fields
    bool isPasswordHidden = true;
    bool isConfirmPasswordHidden = true;
    
    // 📝 Controllers to track what the user types
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPswdController = TextEditingController();

    // clear all fields on successful signup
    void _resetForm() {
        setState(() {
            _nameController.text = '';
            _emailController.text = '';
            _passwordController.text = '';
            _confirmPswdController.text = '';
        });
    }
    
    // toggle visibility for password fields
    void _setPasswordVisibility() {
        setState(() { isPasswordHidden = !isPasswordHidden; } );
    }

    void _setConfirmPasswordVisibility() {
        setState(() { isConfirmPasswordHidden = !isConfirmPasswordHidden; } );
    }

    @override
    void dispose() {
        _nameController.dispose();
        _emailController.dispose();
        _passwordController.dispose();
        _confirmPswdController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold( // 👨 Parent
        appBar: AppBar(
            title: const Text('Create a new account today!'),
            backgroundColor: Colors.purple,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0), // adds padding to form
            child: Form( // 👶 Child
            key: _formKey,
            child: Column(
                children: [
                const Text(
                    'Create Your Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                
                // 👤 Name Field
                TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                        return 'Please enter your name'; // actually display message
                    }
                    return null;
                    },
                ),
                const SizedBox(height: 16),
                
                // 📧 Email Field
                TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                        return 'Please enter a valid email';
                    }
                    return null;
                    },
                ),
                const SizedBox(height: 16),
                
                // 🔒 Password Field
                TextFormField(
                    controller: _passwordController,
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        // add visibility toggle to password field
                        suffixIcon: IconButton(
                            icon: Icon( isPasswordHidden ? Icons.visibility_off : Icons.visibility),
                            onPressed: _setPasswordVisibility,
                        ),
                    ),
                    
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                        return 'Please enter a password'; // renders to screen if condition met
                    }
                    if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                    }
                    return null; // do nothing if input correct
                    },
                ),
                const SizedBox(height: 16),

                TextFormField(
                    controller: _confirmPswdController,
                    obscureText: isConfirmPasswordHidden,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                            icon: Icon( isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility),
                            onPressed: _setConfirmPasswordVisibility,
                        ),
                    ),
                    validator: (value) {
                        // compare data in password field to value in this field
                        if ( value == null  || value.isEmpty ) {
                            return 'Confirmation password required';
                        }
                        if ( value != _passwordController.text ) {
                            return 'Passwords do not match';
                        }
                        return null; // do nothing if everything correct
                    }
                ),
                const SizedBox(height: 24),
                
                //  Sign Up Button
                ElevatedButton(
                    onPressed: () {
                    if (_formKey.currentState!.validate()) { 
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuccessPage(name: _nameController.text),
                            ),
                        );
                        _resetForm();
                        }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}