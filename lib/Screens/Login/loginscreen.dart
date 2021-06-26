import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memebahadur/NavigationBar.dart';
import 'package:memebahadur/utils/circularprogressindicator.dart';
import 'package:memebahadur/utils/dialogs.dart';
// import 'package:memebahadur/Screens/Login/loginfields.dart';
// import 'package:memebahadur/Screens/Login/signupform.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:memebahadur/utils/login_authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(),
          Opacity(
            opacity: _loading ? 0.1 : 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/mainlogo.png'),
                  ).shimmer(
                      showAnimation: true,
                      primaryColor: Colors.red,
                      secondaryColor: Colors.blue),
                ),
                Expanded(flex: 2, child: topSection(context)),
                Container(
                  child: Text(
                    'MemeBahadur',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 24.0),
                  ).shimmer(count: 2),
                ),
              ],
            ),
          ),
          _loading ? LoadingProgressIndictor() : Container()
        ],
      ),
    );
  }

  Widget topSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
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
                      borderRadius: BorderRadius.circular(15)),
                  text: 'Continue With Facebook',
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    final user =
                        await AuthenticationService.loginWithFB(context);
                    setState(() {
                      _loading = false;
                    });
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return NavigationBar();
                          },
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("user null"),
                          content: Text("Try Other Method"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
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
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    final user = await AuthenticationService.signinWithGoogle();
                    setState(() {
                      _loading = false;
                    });
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
        ),
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
