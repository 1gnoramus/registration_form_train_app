// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool hidePass = true;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final storyController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    storyController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register From Page'),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'What is your name?',
                prefixIcon: Icon(Icons.person),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  borderSide: BorderSide(color: Colors.black45, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  borderSide: BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number *',
                hintText: 'How can we reach you?',
                helperText: 'Phone Formar: (XXX)-XXX-XX-XX',
                prefixIcon: Icon(Icons.call),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  borderSide: BorderSide(color: Colors.black45, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  borderSide: BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Addess',
                hintText: 'Enter your e-mail address',
                prefixIcon: Icon(Icons.mail),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: storyController,
              decoration: InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell us about yourself',
                helperText: 'Keep it short please',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: passController,
              obscureText: hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password *',
                hintText: 'Enter the password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePass = !hidePass;
                    });
                  },
                  icon:
                      Icon(hidePass ? Icons.visibility : Icons.visibility_off),
                ),
                icon: Icon(Icons.security),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: confirmPassController,
              obscureText: hidePass,
              decoration: InputDecoration(
                  labelText: 'Confirm Password*',
                  hintText: 'Confirm the password',
                  icon: Icon(Icons.check_box)),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
                onPressed: () {
                  submitForm();
                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }

  void submitForm() {
    print('Name: ${nameController.text}');
    print('Phone: ${phoneController.text}');
    print('Email: ${emailController.text}');
    print('Story: ${storyController.text}');
  }
}
