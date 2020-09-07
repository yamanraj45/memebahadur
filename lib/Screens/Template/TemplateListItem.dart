import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TemplateListItem extends StatelessWidget {
  final templateImage;
  final templateName;

  TemplateListItem({this.templateImage, this.templateName});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(templateImage),
      ),
    );
  }
}
