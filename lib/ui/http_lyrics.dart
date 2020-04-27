import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const baseUrl = "https://0c22c856.ngrok.io/get_lyrics";

//#################################
//      HTTP POST to generate Song(s)
//#################################
class API {
  static Future<List<Song>> fetchLyrics(conds) async {
    var songs = new List<Song>();
    //  The conds are already in the format expected by the API
    String body = json.encode(conds);

    final response = await http.post(baseUrl, body: body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Iterable list = json.decode(response.body);
      songs = list.map((model) => Song.fromJson(model)).toList();
      return songs;

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load lyrics');
    }
  }
}

//#################################
//      A Song instance
//#################################
class Song {
  String lyrics;
  String genre;
  String songName;
  String artist;
  String album;
  String year;
  String initLyrics;
  int batchIndex;

  Song({
    this.lyrics,
    this.genre,
    this.songName,
    this.artist,
    this.album,
    this.year,
    this.initLyrics,
    this.batchIndex,
  });

  factory Song.fromJson(Map json){
    return Song(
        lyrics: json['lyrics'],
        genre: json['genre'],
        artist: json['artist'],
        album: json['album'],
        year: json['year'],
        songName: json['song_name'],
        initLyrics: json['init_lyrics'],
        batchIndex: json['batch_size']
    );
  }

}