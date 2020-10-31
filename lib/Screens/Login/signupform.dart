import 'package:flutter/material.dart';
import 'package:memebahadur/utils/login_authentication.dart';

class SignUpFields extends StatelessWidget {
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUppassword = TextEditingController();
  TextEditingController confirmsignuppassword = TextEditingController();

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
                controller: signUpEmail,
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
                controller: signUppassword,
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
                validator: (value) {
                  if (value == signUppassword.text) {
                    return null;
                  } else {
                    return 'Not Matching';
                  }
                },
                controller: confirmsignuppassword,
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
                onPressed: () async {
                  final email = signUpEmail.text;
                  final password = confirmsignuppassword.text;
                  if (confirmsignuppassword.text == signUppassword.text) {
                    print('Same');
                    print('$email $password');

                    final user = await AuthenticationService.signInWithEmail(
                        email: email, password: password);
                    if (user != null) {
                      return Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return AlertDialog(
                          title: Text('Success'),
                          content: Text('Verify Your Account And Login'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }));
                    }
                  } else if (confirmsignuppassword.text !=
                      signUppassword.text) {
                    print('Differnet');
                    return 'Enter Same Passowrd';
                  } else {
                    print('empty');
                    return null;
                  }
                },
                child: Text('Signup'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
