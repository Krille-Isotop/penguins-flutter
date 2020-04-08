import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../penguin.dart';

class PenguinDetailsRoute extends StatefulWidget {
  final Penguin penguin;

  PenguinDetailsRoute({ Key key, @required this.penguin }): super(key: key);

  @override
  PenguinForm createState() {
    return PenguinForm(penguin: penguin);
  }
}

class PenguinForm extends State<PenguinDetailsRoute> {
  final Penguin penguin;
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  PenguinForm({ @required this.penguin });

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = penguin.breed;

    return Scaffold(
      appBar: AppBar(
        title: Text('Penguins'),
      ),
      body: Form(
        key: _formKey, 
        child: Container(margin: const EdgeInsets.all(50.0), child: Column(children: <Widget>[
          TextFormField(
            controller: _textEditingController,
            validator: (value) {
              if (value.isEmpty) {
                return "You need to enter a breed";
              }

              return null;
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                http.put(
                  'http://127.0.0.1:3000/penguins/${this.penguin.id.toString()}', 
                  body: { 'breed': _textEditingController.text 
                })
                  .then((result) => {
                    Navigator.pop(context)
                  });
                }
            },
            child: Text('Update penguin breed'),
          ),
          SizedBox(height: 10),
          RaisedButton(
            onPressed: () {
              http.delete('http://127.0.0.1:3000/penguins/${this.penguin.id.toString()}')
                .then((result) => {
                  Navigator.pop(context)
                });
            },
            child: Text('Delete penguin'),
          ),
          SizedBox(height: 10),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Avbryt'),
          )
        ]))
      )
    );
  }
}