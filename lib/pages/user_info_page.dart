// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:form_train_app/model/user.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({this.userInfo});
  final User? userInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '${userInfo?.name}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text('${userInfo?.story}'),
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              trailing: Text('${userInfo?.country}'),
            ),
            ListTile(
              title: Text(
                '${userInfo?.phone}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text(
                '${userInfo?.email}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.email,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
