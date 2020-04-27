import 'package:flutter/material.dart';
import 'package:lyricsflutterapp/ui/login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TheGorgeousLogin',
      theme: new ThemeData(
        accentColor: Color(0xFF1eb2a6),
      ),
      home: new LoginPage(),
    );
  }
}