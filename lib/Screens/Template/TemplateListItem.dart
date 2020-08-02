import 'package:flutter/widgets.dart';

class TemplateListItem extends StatelessWidget {
  final templateImage;
  final templateName;

  TemplateListItem({this.templateImage, this.templateName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.00),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(templateImage),
      ),
    );
  }
}
