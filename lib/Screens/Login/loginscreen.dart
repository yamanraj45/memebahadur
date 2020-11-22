import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:memebahadur/NavigationBar.dart';
// import 'package:memebahadur/Screens/Login/loginfields.dart';
// import 'package:memebahadur/Screens/Login/signupform.dart';
import 'package:memebahadur/utils/StateManagement/loginScreenState.dart';
import 'package:memebahadur/utils/login_authentication.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            // 6
            topSection(context),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Center(
                  child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/45logo.png'),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget topSection(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(child: Image.asset('assets/images/logo.png')),
        SizedBox(
          height: 32.0,
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
                width: double.infinity,
                child: SignInButton(
                  Buttons.Facebook,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  text: 'Continue With Facebook',
                  onPressed: () async {
                    final user =
                        await AuthenticationService.loginWithFB(context);
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return NavigationBar();
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: SignInButton(
                  Buttons.Google,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onPressed: () async {
                    final user = await AuthenticationService.signinWithGoogle();
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return NavigationBar();
                          },
                        ),
                      );
                    }
                  },
                  text: 'Continue With Google',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
//   Widget topSection(context) {
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset('assets/images/logo.png'),
//         SizedBox(
//           height: 32.0,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => Dialog(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: LoginFields(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   height: 50.0,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30.0)),
//                   child: Center(
//                     child: Text(
//                       'Login',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 20.0),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 16.0,
//             ),
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => Dialog(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: SignUpFields(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   height: 50.0,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30.0)),
//                   child: Center(
//                     child: Text(
//                       'SignUp',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 20.0),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget bottomSection(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Or via social media',
//           style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 18.0),
//         ),
//         SizedBox(
//           height: 10.0,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: () async {
//                 final user = await AuthenticationService.signinWithGoogle();
//                 if (user != null) {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) {
//                     return NavigationBar();
//                   }));
//                 }
//               },
//               child: Container(
//                 height: 32.0,
//                 width: 32.0,
//                 decoration:
//                     BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('G'),
//                 ),
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
