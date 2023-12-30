import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> data = jsonDecode(response.body);
    print(data);
    List<Album> albums = data.map((json) => Album.fromJson(json)).toList();
    print(albums.length);
    return albums;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    print('ALBUM Created');
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return Album.fromJson(jsonResponse);
  } else {
    throw Exception(
        'Failed to create album. Status Code: ${response.statusCode}');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album Data',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Album>> futureAlbum;
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  Future<void> deleteAlbum(int albumId) async {
    final http.Response response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$albumId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Album deleted successfully
      setState(() {
        futureAlbum = fetchAlbum();
        print('ALBUM deleted');
      }); // Refresh the album list
    } else {
      // Failed to delete album
      throw Exception('Failed to delete album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album Data'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Create New Album'),
                content: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Album Title'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      createAlbum(_titleController.text.toString())
                          .then((value) {
                        setState(() {
                          _titleController.clear();
                          futureAlbum = fetchAlbum();
                        });
                        Navigator.of(context).pop();
                      }).catchError((error) {
                        print('Error creating album: $error');
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text('Create'),
                  ),
                  TextButton(
                    onPressed: () {
                      _titleController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        label: Text('Add Album'),
        icon: Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No Albums Found');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Album album = snapshot.data![index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(album.title),
                      subtitle: Text('ID: ${album.id}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteAlbum(album.id).then((_) {
                            setState(() {
                              futureAlbum = fetchAlbum();
                            });
                          }).catchError((error) {
                            print('Error deleting album: $error');
                          });
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
