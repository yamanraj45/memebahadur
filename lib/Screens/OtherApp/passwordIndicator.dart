import 'package:flutter/material.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:memebahadur/widgets/InputText.dart';

class PasswordIndicatorMeme extends StatelessWidget {
  TextEditingController _weakpassword = TextEditingController();
  TextEditingController _strongpassword = TextEditingController();
  TextStyle _newPasswordStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  InputDecoration _inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(2.0),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return MemeScaffold(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Card(
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Password:',
                    style: _newPasswordStyle,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                        readOnly: true,
                        controller: _weakpassword,
                        decoration: _inputDecoration),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Container(
                          child: SizedBox(
                            height: 5,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Container(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Text('Weak Password'),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'New Password:',
                    style: _newPasswordStyle,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                        controller: _strongpassword,
                        readOnly: true,
                        decoration: _inputDecoration),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: SizedBox(
                            height: 5,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Container(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Strong Password'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Edit Password Fields',
                        style: _newPasswordStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InputText(
                        multiline: false,
                        counterText: '',
                        maxLength: 50,
                        controller: _weakpassword,
                        label: 'Enter Weak Password',
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InputText(
                        maxLength: 50,
                        controller: _strongpassword,
                        label: 'Enter Strong Password',
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
