import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  _TabNavitatorState createState() => _TabNavitatorState();

}
class _TabNavitatorState extends State<SearchPage>{
  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('搜索'),
      ),
    );
  }

}
