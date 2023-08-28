import 'package:flutter/material.dart';
import 'package:taba/screens/home_screen.dart';
import 'package:taba/screens/kyu/information.dart';

import '../../constants.dart';
import 'imformation_block_only_for_useage.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              // Your navigation logic here
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: AspectRatio(
                  aspectRatio: 2,
                  child: Image.asset(
                    'lib/assets/dummyMedicine.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: const BoxDecoration(
            color: Colors.white, // 여기서 바텀네비게이션 Color 변경.
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicineName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 10), // 텍스트 간격 조절
              Text(
                medicineExplain,
                style: TextStyle(
                  fontSize: 20, // 원하는 크기로 조정
                  color: Colors.black, // 원하는 색상
                ),
              ),
              // SizedBox(height: 20),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // 가로 정렬을 가운데로 설정
                    children: [
                      Container(
                        width: 140, // 원하는 너비 설정
                        height: 80, // 원하는 높이 설정
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExplainScreen2()),
                            );
                          },
                          child: const Text('사효부',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      ),
                      Container(
                        width: 140, // 원하는 너비 설정
                        height: 80, // 원하는 높이 설정
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExplainScreen()),
                            );
                          },
                          child: const Text('주의사항',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 40),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // 가로 정렬을 가운데로 설정
                    children: [
                      Container(
                        width: 140, // 원하는 너비 설정
                        height: 80, // 원하는 높이 설정
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExplainScreen2()),
                            );
                          },
                          child: const Text('부작용',
                              style:
                              TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      ),
                      Container(
                        width: 140, // 원하는 너비 설정
                        height: 80, // 원하는 높이 설정
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExplainScreen()),
                            );
                          },
                          child: const Text('상호작용',
                              style:
                              TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 1000, // 원하는 너비 설정
                height: 40, // 원하는 높이 설정
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(60), // 모서리를 둥글게 설정
                ),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('보관함에 담기',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}