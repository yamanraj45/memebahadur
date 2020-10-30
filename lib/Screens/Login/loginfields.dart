import 'package:flutter/material.dart';

class LoginFields extends StatelessWidget {
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                  controller: loginEmail,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: loginpassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  final email = loginEmail.text;
                  final password = loginpassword.text;
                  print('Email: $email   password: $password');
                },
                child: Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
