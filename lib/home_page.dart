import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];
  bool isLo = true;
  String url = 'https://randomuser.me/api/?results=50';

  Future<String> getData() async {
    var res = await http.get(Uri.parse(url));
    // print(res.body);
    List datas = jsonDecode(res.body)["results"];
    setState(() {
      data = datas;
      isLo = false;
    });
    return '';
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RU's"),
      ),
      body: Container(
        child: Center(
          child: isLo
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Row(
                        children: [
                          Container(
                            child: Image(
                              width: 70.0,
                              height: 70.0,
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                data[index]['picture']['thumbnail'],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(data[index]['name']['title'] +
                                    " " +
                                    data[index]['name']['first'] +
                                    " " +
                                    data[index]['name']['last']),
                                Text(data[index]['email']),
                                Text(data[index]['phone']),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
