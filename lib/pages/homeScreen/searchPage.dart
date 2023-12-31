import 'package:flutter/material.dart';
import '../webView.dart';
import 'homepage.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String?> filterList(List<String?> list, String search) {
    return list
        .where((item) => item!.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  final _textControl = TextEditingController();
  List<String?> exList = ["ankara", "istanbul", "haydar", "ahmet"];
  String searchString = "";
  List<Text> tec = [];

  void _Ref() {
    tec.clear();
    tec.addAll(
        filterList(TitlesData, searchString).map((e) => Text(e!)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextFormField(
          controller: _textControl,
          onChanged: (value) {
            setState(() {
              searchString = value;
              _Ref();
            });
          },
          decoration: InputDecoration(
            hintText: 'Arama',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: tec.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) =>
                      WebViewScreen(texturl: TitlesUrl[index]!),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Icon(Icons.search),
                      tec[index],
                    ],
                  ),
                ),
                Divider(height: 10,)
              ],
            ),
          );
        },
      ),
    );
  }
}
