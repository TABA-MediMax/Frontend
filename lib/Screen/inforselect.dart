import 'package:flutter/material.dart';

import '../constants.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), //appbar 사이즈 조절
        child: AppBar(
          backgroundColor: mainColor,
          leading: IconButton(
            onPressed: () {
              // Your navigation logic here
            },
            icon: Icon(Icons.arrow_back, size: IconSize, color: whiteColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Your navigation logic here
              },
              icon: Icon(Icons.list, size: IconSize, color: whiteColor),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,


      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          height: 400.0,
        ),
      ),
    );
  }
}
