import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String label;
  final Function onChanged;
  final int maxLength;
  final bool multiline;
  final String counterText;
  InputText(
      {@required this.label,
      @required this.onChanged,
      this.maxLength = 4,
      this.multiline = false,
      this.counterText = ""});
  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        keyboardType: widget.multiline ? TextInputType.multiline : null,
        maxLines: widget.multiline ? null : 1,
        controller: _controller,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          counterText: widget.counterText,
          isDense: true,
          labelText: widget.label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
