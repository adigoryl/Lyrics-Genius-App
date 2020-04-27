import 'dart:ui';

import 'package:lyricsflutterapp/ui/http_lyrics.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class GenerateTab extends StatefulWidget {

  GenerateTab({
    Key key,
    @required this.pageController,
    @required this.condsStreamCtrl,
  }): super(key: key);

  PageController pageController;
  StreamController<Map> condsStreamCtrl;

  Map condsMap;

  @override
  _GenerateTabState createState() => _GenerateTabState();

}

class _GenerateTabState extends State<GenerateTab> {
  StreamController<bool> getLyricsStreamCtrl = PublishSubject<bool>();
  var songs = new List<Song>();

  @override
  void dispose() {
    getLyricsStreamCtrl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(246, 247, 249, 1),
              border: BorderDirectional(
                  bottom: BorderSide(width: 1, color: Colors.black12))),
          child: Padding(
              padding: EdgeInsets.only(top: 22, left: 26),
              child: Row(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text("Lyrics Genius",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold)
                            )
                        ),
                        Container(
                            child: Text("Generate Lyrics",
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                        ),
                      ]
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 0, left: 70, bottom: 22),
                      child: Container(
                          width: 60,
                          height: 60,
                          child: RaisedButton(
//                            color: Color(0xFF1eb2a6),
                            child: const Text('Gen',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              getLyricsStreamCtrl.sink.add(true);
                            },
                          )
                      )
                  ),
                ],
              )
          ),
        ),
        preferredSize: Size.fromHeight(90));


    Widget displayOneCond(String condName, String condVal, int iconCode,
        Color backgroundColor) {
      return Container(
//        color: Colors.red,
          width: 170.0,
          margin:  new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: new BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  spreadRadius: 2,
                  offset: new Offset(0.75, 0.75),
                  blurRadius: 5.0,
                ),
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
  //                        color: Colors.yellow,
                            child: Icon(
                                IconData(iconCode, fontFamily: 'MaterialIcons'),
                                color: Color(0xFFe78200))
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 0, top: 13),
                          child: Text("$condName", style: TextStyle(
                              fontSize: 13, color: Colors.black38))
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                    child: Text("$condVal",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center)
                )
              )
            ],
          )
      );
    }

    Widget displayConditions(batchSize, genre, artist, year, album, songTitle,
        initLyrics) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
          child: Scrollbar(child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              displayOneCond("Genre", genre, 58373, Colors.orange[50]),
              displayOneCond("Artist", artist, 59603, Colors.white),
              displayOneCond("Year", year, 59670, Colors.orange[50]),
              displayOneCond("Album", album, 57369, Colors.white),
              displayOneCond("Title", songTitle, 57956, Colors.orange[50])
            ],
          )
      ));
    }

    return Scaffold(
        appBar: appBar,
        backgroundColor: Colors.grey[150],
        body: Theme(
          data: ThemeData(
            accentColor: Colors.orange,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                // Heigth of the conds display cards
                height: 150,
                child: StreamBuilder<Map>(
                    stream: widget.condsStreamCtrl.stream.asBroadcastStream(),
                    //                      initialData: _counter,
                    builder: (BuildContext context, AsyncSnapshot<Map> d) {
                      if (d.hasData) {
                        widget.condsMap = d.data;
                        return displayConditions(
                            d.data["batch_size"],
                            d.data["genre"],
                            d.data["artist"],
                            d.data["year"],
                            d.data["album"],
                            d.data["song_name"],
                            d.data["init_lyrics"]
                        );
                      }
                      return Center(
                        child: Text(
                          'Please set conditions first:\n Go to "Add Style" tab\n\n then',
                          style: TextStyle(
                            fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  ),

              ),
              Expanded(
                child: StreamBuilder<bool>(
                    stream: getLyricsStreamCtrl.stream.asBroadcastStream(),
                    initialData: false,
                    builder: (BuildContext context, AsyncSnapshot<bool> d) {
                      if (d.hasData) {
                        if (d.data) {
                          return DisplayLyrics(conds: widget.condsMap);
                        }
                      }
                      return Center(
                        child: Text(
                          'Press "Gen" button to generate song lyrics using the set conditions.',
                          style: TextStyle(
                            fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                      );

                    }
                ),
              ),
            ],
          ),
        ),
    );

  }

}

class DisplayLyrics extends StatefulWidget{
  Map conds;

  DisplayLyrics({Key key, this.conds}) : super(key: key);

  @override
  _DisplayLyricsState createState() => _DisplayLyricsState();

}

class _DisplayLyricsState extends State<DisplayLyrics> {

    Future<List<Song>> futureSongs;

    @override
    void initState() {
      futureSongs = API.fetchLyrics(widget.conds);
      super.initState();
    }

    @override
    Widget build(BuildContext context) {

      _showFullLyrics(String title, String lyrics){
        return showDialog(
          context: context,
          barrierDismissible: true, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(lyrics),
//                    Text('You\’re like me. I’m never satisfied.'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  color: Color(0xFFe78200),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      return Container(
        padding: EdgeInsets.all(7),
          child: FutureBuilder<List<Song>>(
            future: futureSongs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scrollbar(child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(5),
                        leading: new Image(
                            width: 40.0,
                            height: 32.0,
                            fit: BoxFit.fill,
                            image: new AssetImage('assets/img/login_logo.png')
                        ),
//                        title: Text("${snapshot.data[index].genre} - ${snapshot.data[index].artist}"),
                        title: Text("${index+1} Generated Song - ${snapshot.data[index].genre}"),
                        subtitle: Text("${snapshot.data[index].lyrics.length > 110 ? "${snapshot.data[index].initLyrics} ${snapshot.data[index].lyrics.substring(0, 110)} ... (press to view)" : "Lyrics too short to show in preview"}" ),
                        trailing: Icon(Icons.more_vert),
                        isThreeLine: true,
                        onTap: (){
                          _showFullLyrics("${index+1} Generated Song", "${snapshot.data[index].initLyrics} " " ${snapshot.data[index].lyrics}");
                         },
                      ),
                    );
                  }));

              } else if (snapshot.hasError) {
                return Column(
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ]
                );
              }
              // By default, show a loading spinner.
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFe78200)),
                      ),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Generating lyrics...'),
                    )
                  ]
              );
            },
          ),
        );

    }
  }

