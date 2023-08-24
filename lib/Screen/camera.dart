import 'package:flutter/material.dart';
import 'home.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({required String localImagePath});

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            color: Colors.pink,
            child: const Center(
              child: Text(
                'Container 1',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 200,
            color: Colors.red,
            child: const Center(
              child: Text(
                'Container 2',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
