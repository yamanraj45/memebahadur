import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';
import 'package:memebahadur/Screens/Template/TemplateScreen.dart';
import 'package:memebahadur/utils/Hiveconstant.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TemplateTransition extends StatefulWidget {
  List templateList;
  int index;
  TemplateTransition(this.templateList, this.index);

  @override
  _TemplateTransitionState createState() =>
      _TemplateTransitionState(this.index);
}

class _TemplateTransitionState extends State<TemplateTransition> {
  int currentIndex;
  _TemplateTransitionState(this.currentIndex);
  @override
  Widget build(BuildContext context) {
    int templateLength = widget.templateList.length;
    return ValueListenableBuilder(
      valueListenable: Hive.box(Stared_Template).listenable(),
      builder: (context, box, child) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: box.containsKey(widget.templateList[currentIndex]['image'])
                  ? Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )
                  : Icon(Icons.star_border),
              onPressed: () async {
                print(widget.templateList[currentIndex]['image']);
                setState(() {
                  if (box.containsKey(
                      widget.templateList[currentIndex]['image'])) {
                    box.delete(widget.templateList[currentIndex]['image']);
                  } else {
                    box.put(
                      widget.templateList[currentIndex]['image'],
                      {
                        "image": widget.templateList[currentIndex]['image'],
                        "name": widget.templateList[currentIndex]['name']
                      },
                    );
                  }
                });
              },
            ),
          ],
        ),
        bottomSheet: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final path = widget.templateList[currentIndex]['image'];
              Image image = Image.asset(path);
              final imageSize = await getUiImage(path);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => Editor(image, imageSize),
                  maintainState: true,
                  transitionsBuilder: (c, anim, a2, child) => SlideTransition(
                      position: Tween(
                        begin: Offset(1.0, 0.0),
                        end: Offset(0.0, 0.0),
                      ).animate(
                        CurvedAnimation(parent: anim, curve: Curves.linear),
                      ),
                      child: child),
                  transitionDuration: Duration(milliseconds: 400),
                ),
              );
            },
            child: Text('Proceed'),
          ),
        ),
        body: Container(
          child: Center(
              child: Stack(
            children: [
              Image.asset(widget.templateList[currentIndex]['image']),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_left),
                      onPressed: () {
                        if (currentIndex != 0) {
                          setState(() {
                            currentIndex--;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('No More Content')));
                        }
                      },
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_right),
                      onPressed: () {
                        if (currentIndex < templateLength - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('End of List')));
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
