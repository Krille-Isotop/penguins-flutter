import 'package:flutter/material.dart';
import './routes/penguinListScreen.dart';

void main() => runApp(
  MaterialApp(
      title: 'Penguins',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PenguinListRoute()
  )
);

