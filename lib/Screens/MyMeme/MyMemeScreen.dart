import 'package:memebahadur/Screens/Editor/DraggableItem.dart';
import 'package:flutter/material.dart';
import 'package:memebahadur/widgets/MemeTextInput.dart';

class MyMemeScreen extends StatefulWidget {
  @override
  _MyMemeScreenState createState() => _MyMemeScreenState();
}

class _MyMemeScreenState extends State<MyMemeScreen> {
  int currentIndex;
  List<Widget> items = [];
  int latestIndex = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Focus(
        child: GestureDetector(
          onTap: () {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            setState(() {
              currentIndex = null;
            });
          },
          onDoubleTap: () {
            setState(() {
              currentIndex = null;
            });
          },
          child: Stack(
            children: <Widget>[
                  Container(
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/images/1/Trend (1).jpg"),
                      ),
                    ),
                  ),
                  DraggableItem(
                    isVisible: 0 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    index: 0,
                    isSelected: currentIndex == 0,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 0,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 1 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    index: 1,
                    isSelected: currentIndex == 1,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 1,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 2 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    },
                    index: 2,
                    isSelected: currentIndex == 2,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 2,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 3 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 3;
                      });
                    },
                    index: 3,
                    isSelected: currentIndex == 3,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 3,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 4 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 4;
                      });
                    },
                    index: 4,
                    isSelected: currentIndex == 4,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 4,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 5 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 5;
                      });
                    },
                    index: 5,
                    isSelected: currentIndex == 5,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 5,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 6 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 6;
                      });
                    },
                    index: 6,
                    isSelected: currentIndex == 6,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 6,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 7 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 7;
                      });
                    },
                    index: 7,
                    isSelected: currentIndex == 7,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 7,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 8 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 8;
                      });
                    },
                    index: 8,
                    isSelected: currentIndex == 8,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 8,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 9 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 9;
                      });
                    },
                    index: 9,
                    isSelected: currentIndex == 9,
                    child: MemeTextInput(
                      text: "Add text here",
                      isEnabled: currentIndex == 9,
                    ),
                  ),
                  DraggableItem(
                    isVisible: 10 > latestIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 10;
                      });
                    },
                    index: 10,
                    isSelected: currentIndex == 10,
                    child: MemeTextInput(
                      isEnabled: currentIndex == 10,
                    ),
                  ),
                ] +
                <Widget>[
                  Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          latestIndex--;
                        });
                      },
                    ),
                  )
                ],
          ),
        ),
      ),
    );
  }
}

// var ges = GestureDetector(
//   onScaleStart: (ScaleStartDetails details) {
//     _previouScale = _scale;
//     print(details);
//     setState(() {});
//   },
//   onScaleUpdate: (ScaleUpdateDetails details) {
//     _scale = _previouScale * details.scale;
//     print(details);
//     setState(() {});
//   },
//   onScaleEnd: (ScaleEndDetails details) {
//     _previouScale = 1.0;
//     print(details);
//     setState(() {});
//   },
//   child: Center(
//     child: Transform(
//       transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
//       child: null,
//     ),
//   ),
// );

// class MyMemeScreen extends StatefulWidget {
//   @override
//   _MyMemeScreenState createState() => _MyMemeScreenState();
// }

// class _MyMemeScreenState extends State<MyMemeScreen> {
//   int currentSelectedIndex;
//   int count = 0;
//   List<Widget> items = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: GestureDetector(
//               onTap: () {
//                 print("Hello");
//                 WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
//                 setState(() {
//                   currentSelectedIndex = null;
//                 });
//               },
//               child: Text('Selected index is $currentSelectedIndex')),
//         ),
//         body: Container(
//           child: GestureDetector(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 CustomWidget(
//                   index: 0,
//                   isSelected: currentSelectedIndex == 0,
//                   onSelect: () {
//                     setState(() {
//                       currentSelectedIndex = 0;
//                     });
//                   },
//                 ),
//                 CustomWidget(
//                   index: 1,
//                   isSelected: currentSelectedIndex == 1,
//                   onSelect: () {
//                     setState(() {
//                       currentSelectedIndex = 1;
//                     });
//                   },
//                 ),
//                 CustomWidget(
//                   index: 2,
//                   isSelected: currentSelectedIndex == 2,
//                   onSelect: () {
//                     setState(() {
//                       currentSelectedIndex = 2;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

// class CustomWidget extends StatefulWidget {
//   final int index;
//   final bool isSelected;
//   final VoidCallback onSelect;

//   const CustomWidget({
//     Key key,
//     @required this.index,
//     @required this.isSelected,
//     @required this.onSelect,
//   })  : assert(index != null),
//         assert(isSelected != null),
//         assert(onSelect != null),
//         super(key: key);

//   @override
//   _CustomWidgetState createState() => _CustomWidgetState();
// }

// class _CustomWidgetState extends State<CustomWidget> {
//   final controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onSelect,
//       child: Container(
//         margin: EdgeInsets.all(15.0),
//         child: ListTile(
//           title: Column(
//             children: [
//               Text(
//                 "Click me",
//                 style: TextStyle(fontSize: 25),
//               ),
//             ],
//           ),
//           subtitle: Text("Description ${widget.index}"),
//         ),
//         decoration: widget.isSelected
//             ? BoxDecoration(
//                 color: Colors.black38, border: Border.all(color: Colors.black))
//             : BoxDecoration(),
//       ),
//     );
//   }
// }
