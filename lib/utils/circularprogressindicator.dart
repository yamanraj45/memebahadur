import 'package:flutter/material.dart';

class LoadingProgressIndictor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.blue,
      ),
    );
  }
}
