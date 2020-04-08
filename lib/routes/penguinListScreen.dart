import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/routes/addPenguinScreen.dart';
import 'package:test_app/routes/penguinDetailsScreen.dart';
import '../penguinList.dart';
import '../penguin.dart';

Future<PenguinList> fetchPenguins() async {
  final response = await http.get('http://127.0.0.1:3000/penguins');

  if (response.statusCode == 200) {
    print(response.body);
    return PenguinList.fromJson(json.decode(response.body));
  } else {
    throw Exception('fetchPenguin() failed with non successful status code');
  }
}


class PenguinListRoute extends StatefulWidget {
  PenguinListRoute({ Key key }) : super(key: key);

  @override
  _PenguinListState createState() => _PenguinListState();
}

class _PenguinListState extends State<PenguinListRoute> {
  Future<PenguinList> futurePenguins;

  void refreshPenguins() {
    futurePenguins = fetchPenguins();
  }

  @override
  void initState() {
    super.initState();
    refreshPenguins();
  }

  _navigateToScreenAndRefresh(BuildContext buildContext, StatefulWidget route) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => 
        route
      ),
    );

    refreshPenguins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penguins'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.plus_one),
            onPressed: () {
              _navigateToScreenAndRefresh(context, AddPenguinRoute());
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<PenguinList>(
          future: futurePenguins,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var penguins = snapshot.data.penguins;
              return ListView.builder(
                itemCount: penguins.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(penguins[index].breed),
                    onTap: () {
                      _navigateToScreenAndRefresh(context, PenguinDetailsRoute(penguin: penguins[index]));
                    },
                  );
                }
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}