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

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String?> countries = ['Russia', 'Ukraine', 'Germany', 'France'];
  String? _selectedCountry;

  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final passFocus = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    storyController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    passFocus.dispose();
    super.dispose();
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register From Page'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                fieldFocusChange(context, nameFocus, phoneFocus);
              },
              validator: validateName,
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'What is your name?',
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    nameController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
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
              focusNode: phoneFocus,
              onFieldSubmitted: (_) {
                fieldFocusChange(context, phoneFocus, passFocus);
              },
              inputFormatters: [
                // FilteringTextInputFormatter.digitsOnly
                FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                    allow: true),
              ],
              validator: (val) => validatePhoneNumber(val)
                  ? null
                  : 'Phone number must be entered as requiered',
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number *',
                hintText: 'How can we reach you?',
                helperText: 'Phone Formar: (XXX)-XXX-XX-XX',
                prefixIcon: Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    phoneController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
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
              validator: validateEmail,
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
            DropdownButtonFormField(
              validator: (val) {
                // return val == null ? 'Please select a country' : null;
              },
              items: countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country!),
                );
              }).toList(),
              onChanged: (data) {
                print(data);
                setState(() {
                  _selectedCountry = data;
                });
              },
              value: _selectedCountry,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: 'Country?'),
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
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              maxLines: 3,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              focusNode: passFocus,
              controller: passController,
              obscureText: hidePass,
              validator: validatePassword,
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
              validator: validatePassword,
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: nameController.text);
      print('Form is valid!');
      print('Name: ${nameController.text}');
      print('Phone: ${phoneController.text}');
      print('Country: $_selectedCountry');
      print('Email: ${emailController.text}');
      print('Story: ${storyController.text}');
    } else {
      print('Form is not valid. Please check again');
    }
  }

  String? validateName(String? value) {
    final nameExp = RegExp(r'^[A-Za-z]+$');
    if (value!.isEmpty) {
      return 'Name is requiered';
    } else if (!nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters';
    }
    return null;
  }

  bool validatePhoneNumber(String? input) {
    final phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return phoneExp.hasMatch(input!);
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailController.text.contains('@')) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  String? validatePassword(value) {
    if (passController.text.length != 8) {
      return '8 characters are requiered';
    } else if (confirmPassController.text != passController.text) {
      return 'Password doesn\'t match';
    } else {
      return null;
    }
  }

  void _showDialog({String? name}) {
    showDialog(
      context: (context),
      builder: ((context) {
        return AlertDialog(
          title: Text('Registration is successful',
              style: TextStyle(color: Colors.green)),
          content: Text(
            '$name is now vetified a register form',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Verified',
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              ),
            ),
          ],
        );
      }),
    );
  }

  // void showMessage({String? message}) {
  //   _scaffoldKey.currentState.showSnackBar(
  //     SnackBar(
  //       duration: Duration(seconds: 5),
  //       content: Text(
  //         message!,
  //         style: TextStyle(
  //             color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18.0),
  //       ),
  //       backgroundColor: Colors.red,
  //     ),
  //   );
  // }
}
