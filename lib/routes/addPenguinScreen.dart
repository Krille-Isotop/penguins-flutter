import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPenguinRoute extends StatefulWidget {
  AddPenguinRoute({Key? key}) : super(key: key);
  @override
  AddPenguinForm createState() {
    return AddPenguinForm();
  }
}

class AddPenguinForm extends State<AddPenguinRoute> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penguins'),
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.all(50),
          child: Column(children: <Widget>[
            TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: "Enter penguin breed"),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "You need to enter a breed";
                }

                return null;
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("Save penguin"),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  http.post(Uri.parse('http://127.0.0.1:3000/penguins/'), body: { 'breed': _textEditingController.text })
                    .then((result) => {
                      Navigator.pop(context)
                    });
                }
              },
            ),
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]),
        ),
        key: _formKey
      )
    );
  }
}