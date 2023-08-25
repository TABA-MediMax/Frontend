import 'package:flutter/material.dart';
import 'package:taba/screens/kyu/imforBlockSelect.dart';
import '../../constants.dart';
import 'information.dart';
import 'imforBlockSelect.dart';

class ExplainScreen2 extends StatefulWidget {
  const ExplainScreen2({super.key});

  @override
  State<ExplainScreen2> createState() => _ExplainScreenState();
}

// BottomNavigator 안에 있는거 위젯 만들어본거에요;
Widget buildUsageInstructions(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 400, // 원하는 너비 설정
            height: 100, // 원하는 높이 설정
            color: Colors.white,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ExplainScreen()),
                );
              },
              child: Text('사용법',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
          SizedBox(height: 80),
          Container(
            width: 400, // 원하는 너비 설정
            height: 100,  // 원하는 높이 설정
            color: Colors.white,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ExplainScreen()),
                );
              },
              child: Text('효능',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
          SizedBox(height: 80),
          Container(
            width: 400, // 원하는 너비 설정
            height: 100, // 원하는 높이 설정
            color: Colors.white,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ExplainScreen()),
                );
              },
              child: Text('보관법',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
        ],
      ),
    ),
  );
}

class _ExplainScreenState extends State<ExplainScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // 원하는 appBar 높이 설정
        child: AppBar(
          backgroundColor: mainColor,
          leading: IconButton(
            onPressed: () {
              // Your navigation logic here
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: iconSize, color: Colors.white),
          ),

          actions: [
            IconButton(
              onPressed: () {
                // Your navigation logic here
              },
              icon: Icon(Icons.list, size: iconSize, color: Colors.white),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 100,
              color: Colors.white,
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
                        fontSize: fontSizeMiddle,
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
              topLeft: Radius.circular(20), // BottomApp자른거에요
            ),
          ),
          height: 500.0,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: buildUsageInstructions(context),
          ),
        ),
      ),
    );
  }
}
