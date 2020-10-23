import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Exit"),
      content: Text("Do You Want To Discard Changes ?"),
      actions: <Widget>[
        FlatButton(
            child: Text("Yes"),
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false)),
        FlatButton(
          child: Text("No"),
          onPressed: Navigator.of(context).pop,
        )
      ],
    ),
  );
}

void showAlertDialog(BuildContext context,
    {List<Widget> children,
    String title = "",
    String content = "",
    bool autoClose = true}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: children != null ? children : []);

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (autoClose) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
      }
      return alert;
    },
  );
}

void showSavingDialog(BuildContext context) {
  // showAlertDialog(
  //   context,
  //   title: "Saving",
  //   content: "Please wait...",
  // );
  StatusAlert.show(
    context,
    duration: Duration(seconds: 20),
    titleOptions: StatusAlertTextConfiguration(
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    title: 'Saved',
    blurPower: 100,
    configuration: IconConfiguration(icon: Icons.done),
  );
}

void showFailedDialog(BuildContext context, String error) {
  showAlertDialog(
    context,
    title: "Error",
    content: error,
    autoClose: false,
  );
}
