import 'package:flutter/material.dart';

class SignUpFields extends StatelessWidget {
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
                decoration: InputDecoration(
                  hintText: 'Enter Email Address',
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
              SizedBox(
                height: 5,
              ),
              TextFormField(
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
              SizedBox(
                height: 5,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
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
              SizedBox(
                height: 5,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('Signup'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
