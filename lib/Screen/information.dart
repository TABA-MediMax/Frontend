import 'package:flutter/material.dart';
import '../constants.dart';
import './camera.dart';

class ExplainScreen extends StatefulWidget {
  const ExplainScreen({super.key});

  @override
  State<ExplainScreen> createState() => _ExplainScreenState();
}

// BottomNavigator 안에 있는거 위젯 만들어본거에요;
Widget buildUsageInstructions() {
  return Column(
    children: [
      Text(
        infor,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 2.0,
          fontSize: 40,
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: 20),
      Text(
        dummy,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 2.0,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _ExplainScreenState extends State<ExplainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 100,
              color: whiteColor,
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                medicineName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              width: 360,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      ingredientDescription,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: TextStyle(
                        color: Colors.black,
                        height: 1.4,
                        fontSize: FontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffC74847),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          height: 500.0,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: buildUsageInstructions(),
          ),
        ),
      ),
    );
  }
}
