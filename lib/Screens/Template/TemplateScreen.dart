import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:memebahadur/Screens/Template/transitionScreen.dart';

import 'TemplateListItem.dart';

Future<Size> getUiImage(String imageAssetPath) async {
  final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
  image.Image baseSizeImage =
      image.decodeImage(assetImageByteData.buffer.asUint8List());
  return Size(baseSizeImage.width, baseSizeImage.height);
}

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template>
    with AutomaticKeepAliveClientMixin<Template> {
  @override
  bool get wantKeepAlive => true;
  final _templateList = [
    for (int trendImage = 1; trendImage < 10; trendImage++)
      {
        'name': 'Trend $trendImage',
        'image': 'assets/images/1/Trend ($trendImage).jpg'
      },
    //Nepali Image
    for (int pashupatiImage = 1; pashupatiImage < 5; pashupatiImage++)
      {
        'name': 'Pashupati $pashupatiImage',
        'image': 'assets/images/2/Pashupati ($pashupatiImage).jpg'
      },
    for (int haribahadurImage = 1; haribahadurImage < 4; haribahadurImage++)
      {
        'name': 'Haribahadur $haribahadurImage',
        'image': 'assets/images/3/Hari ($haribahadurImage).jpg'
      },
    for (int herapheriImage = 1; herapheriImage < 6; herapheriImage++)
      {
        'name': 'Pashupati $herapheriImage',
        'image': 'assets/images/4/HeraPheri ($herapheriImage).jpg'
      },
    for (int extraImage = 1; extraImage < 64; extraImage++)
      {
        'name': 'Extra $extraImage',
        'image': 'assets/images/5/Extra ($extraImage).jpg'
      },
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.00)),
            Expanded(
              child: GridView.builder(
                cacheExtent: 1000,
                itemCount: _templateList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  return InkResponse(
                    child: TemplateListItem(
                      templateImage: _templateList[index]['image'],
                      templateName: _templateList[index]['name'],
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TemplateTransition(_templateList, index);
                      }));
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
