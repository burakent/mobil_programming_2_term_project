import 'dart:convert';

import 'package:final_project/header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<dynamic> news = [];
  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<Map<String, dynamic>> fetchNews() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=tr&apiKey=f0a28b4162ee46fab4cea445e47216b7');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      print(json);
      return json;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchNews(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final news = snapshot.data['articles'];
              return ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    final haber = news[index];
                    final title = haber['title'];
                    final description = haber['description'];
                    final urlToImage = haber['urlToImage'];
                    return Card(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: urlToImage != null
                              ? Image.network(
                                  urlToImage,
                                  width: 90,
                                )
                              : const Text("IMAGE NOT FOUND!",
                                  style:
                                      TextStyle(backgroundColor: Colors.red)),
                        ),
                        title: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Text(title),
                        ),
                        subtitle: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Text(description),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

