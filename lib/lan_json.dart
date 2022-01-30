import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}


class LanJson extends StatefulWidget {
  const LanJson({Key? key}) : super(key: key);

  @override
  _LanJsonState createState() => _LanJsonState();
}

class _LanJsonState extends State<LanJson> {
  late Future<Post> futurePost;
  @override

  void initState(){
    super.initState();
    futurePost = fetchPost();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              SizedBox(height: 100,),
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 50 , child: Text('UserID'),),
                    SizedBox(width: 20,),
                    Flexible(
                      child: SizedBox(
                        child: FutureBuilder<Post>(
                          future: futurePost,
                          builder: (context, snapshot){
                            if (snapshot.hasData) {
                              return Text(snapshot.data!.userId.toString());
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 50, child: Text('ID'),),
                  SizedBox(width: 20,),
                  Flexible(
                    child: SizedBox(
                      child: FutureBuilder<Post>(
                        future: futurePost,
                        builder: (context, snapshot){
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.id.toString());
                          } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 50, height: 60, child: Text('Title'),),
                  SizedBox(width: 20,),
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: FutureBuilder<Post>(
                        future: futurePost,
                        builder: (context, snapshot){
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.title);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Flexible(
                child: Row(
                  children: [
                    SizedBox(width: 50, height: 120,child: Text('Body:'),),
                    SizedBox(width: 20,),
                    SizedBox(
                      width: 300,
                      height: 120,
                      child: FutureBuilder<Post>(
                        future: futurePost,
                        builder: (context, snapshot){
                          if (snapshot.hasData) {
                            return Text('Body: '+ snapshot.data!.body);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
