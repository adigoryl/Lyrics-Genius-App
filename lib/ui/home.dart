import 'package:lyricsflutterapp/utils/bottom_nav_bar/bottom_navy_bar.dart';
import 'package:lyricsflutterapp/ui/style_tab.dart';
import 'package:flutter/material.dart';
import 'package:lyricsflutterapp/ui/generate_tab.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

// Link below - reactive programming explained (Streams, rxdart, BLoC modelling)
// https://www.didierboelens.com/2018/08/reactive-programming-streams-bloc/

class HomePage extends StatefulWidget {
  
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  final List<Color> appBarColours = <Color>[Color(0xFF1eb2a6), Colors.orange[300], Colors.brown[300], Colors.grey];
  final List<String> appBarText = ["Add Styles", "Generate Lyrics", "Saved Lyrics", "Settings"];

}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController pageController;
  Color color = Color(0xFF1eb2a6);
  String title = "Add Styles";

  final StreamController<Map> condsStreamCtrl = BehaviorSubject<Map>();

  //  Tabs that manipulate the above properties
  StyleTab styleTab;
  GenerateTab genTab;

  @override
  void initState() {
    pageController = PageController(keepPage: true);
    styleTab = StyleTab(
      pageController: pageController,
      condsStreamCtrl: condsStreamCtrl,

    );
    genTab = GenerateTab(
      condsStreamCtrl: condsStreamCtrl,
      pageController: pageController,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    condsStreamCtrl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(title),
        backgroundColor: this.color,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
            setState(() => title = widget.appBarText[index]);
            setState(() => color = widget.appBarColours[index]);
          },
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: styleTab,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.expand(),
                child: genTab,
            ),
            Container(color: Colors.brown[50]),
            Container(color: Colors.grey[50]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        },
          items: [
          BottomNavyBarItem(
            icon: Icon(Icons.queue),
            title: Text('Add Styles'),
            activeColor: Color(0xFF1eb2a6),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.music_note),
            title: Text('Generate'),
            activeColor: Color(0xFFe78200),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.save),
            title: Text("Saved Lyrics"),
            activeColor: Color(0xFF4c2b00),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}