import 'package:flutter/material.dart';

class LoginFields extends StatelessWidget {
  InputDecoration textfielddecoration = InputDecoration(
    // counterText: widget.counterText,
    isDense: true,
    // labelText: widget.label,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.red),
    ),
  );
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
                onPressed: () {},
                child: Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
