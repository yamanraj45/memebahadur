import 'package:flutter/material.dart';
import 'package:memebahadur/NavigationBar.dart';
import 'package:memebahadur/Screens/Login/loginfields.dart';
import 'package:memebahadur/Screens/Login/signupform.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            Positioned(
              top: 16.0,
              right: 0,
              child: FlatButton(
                child: Text('Skip'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NavigationBar();
                      },
                    ),
                  );
                },
              ),
            ),
            topSection(context),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: bottomSection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget topSection(context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo.png'),
        SizedBox(
          height: 32.0,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: LoginFields(),
                    ),
                  );
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SignUpFields(),
                    ),
                  );
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Center(
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget bottomSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Or via social media',
          style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 18.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 32.0,
                width: 32.0,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Facebook'),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            InkWell(
              child: Container(
                height: 32.0,
                width: 32.0,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('G'),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
