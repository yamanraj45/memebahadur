import 'package:flutter/material.dart';

class TemplateTransition extends StatefulWidget {
  @override
  _TemplateTransitionState createState() => _TemplateTransitionState();
}

class _TemplateTransitionState extends State<TemplateTransition> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text('Hello'),
        ),
        ElevatedButton(
            onPressed: () async {
              // final path = _templateList[index]['image'];
              // Image image = Image.asset(path);
              // final imageSize = await getUiImage(path);
              // Navigator.push(
              //   context,
              //   PageRouteBuilder(
              //     pageBuilder: (c, a1, a2) => Editor(image, imageSize),
              //     maintainState: true,
              //     transitionsBuilder: (c, anim, a2, child) =>
              //         SlideTransition(
              //             position: Tween(
              //               begin: Offset(1.0, 0.0),
              //               end: Offset(0.0, 0.0),
              //             ).animate(
              //               CurvedAnimation(
              //                   parent: anim, curve: Curves.linear),
              //             ),
              //             child: child),
              //     transitionDuration: Duration(milliseconds: 400),
              //   ),
              // );
            },
            child: Text('Hello'))
      ],
    );
  }
}
