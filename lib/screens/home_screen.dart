import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:taba/constants.dart';
import 'package:provider/provider.dart';
import 'package:taba/models/pill_attribute.dart';
import 'package:taba/providers/pill_attribute_controller.dart';

import '../http/dto.dart';
import '../http/request.dart';
import '../models/current_index.dart';
import 'kyu/imforBlockSelect.dart';
import 'my_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class MyCustomClass {
  const MyCustomClass();

  Future<void> myAsyncMethod(BuildContext context, VoidCallback onSuccess) async {
    await Future.delayed(const Duration(seconds: 2));
    onSuccess.call();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController = TextEditingController(
      text: ""
  );

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      return pickedFile;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> cameraPickedImage(PillAttribute? tempPillAttribute, BuildContext context) async {
    try {
      final pickedImage = await pickImage(ImageSource.camera);
      if (pickedImage != null) {
        // 로딩 중 표시
        showDialog(
            context: context,
            barrierDismissible: false,  // Prevents the dialog from closing on outside tap
            builder: (BuildContext context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text("Processing..."),
                    ],
                  ),
                ),
              );
            }
        );
        // image API
        String filename = "image.png";
        ResponseData responseData = await ImageSearchRequest(
            File(pickedImage.path), filename);
        tempPillAttribute?.pillId = responseData.body.items[0].itemSeq!;
        tempPillAttribute?.name = responseData.body.items[0].itemName!;
        tempPillAttribute?.howToUse =
            responseData.body.items[0].useMethodQesitm!;
        tempPillAttribute?.effect = responseData.body.items[0].efcyQesitm!;
        tempPillAttribute?.warning = responseData.body.items[0].atpnQesitm!;
        tempPillAttribute?.howToStore =
            responseData.body.items[0].depositMethodQesitm!;
        tempPillAttribute?.sideEffect = responseData.body.items[0].seQesitm!;
        tempPillAttribute?.interaction = responseData.body.items[0].intrcQesitm!;

        // Copy the image to new location with desired name
        String oldPath = pickedImage.path;
        String newPath = join(
            dirname(oldPath), '${tempPillAttribute?.name}.png');
        tempPillAttribute?.imgPath = newPath;
        await File(oldPath).copy(newPath);
        // 이미지 호출: Image.file(File(tempPillAttribute?.imgPath))
        PillAttributeController.set(tempPillAttribute!);
        PillAttributeController.show();
        print("[debug]image search done");
        Navigator.of(context).pop();  // Close the dialog
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SelectScreen()),
        );
      }
    }catch (error) {
      Navigator.of(context).pop();  // Close the dialog
      print("Error in processPickedImage: $error");
    }
  }
  Future<void> galleryPickedImage(PillAttribute? tempPillAttribute, BuildContext context) async {
    try {
      final pickedImage = await pickImage(ImageSource.gallery);
      if (pickedImage != null) {
        // 로딩 중 표시
        showDialog(
            context: context,
            barrierDismissible: false,  // Prevents the dialog from closing on outside tap
            builder: (BuildContext context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text("Processing..."),
                    ],
                  ),
                ),
              );
            }
        );
        // image API
        String filename = "image.png";
        ResponseData responseData = await ImageSearchRequest(
            File(pickedImage.path), filename);
        tempPillAttribute?.pillId = responseData.body.items[0].itemSeq!;
        tempPillAttribute?.name = responseData.body.items[0].itemName!;
        tempPillAttribute?.howToUse =
        responseData.body.items[0].useMethodQesitm!;
        tempPillAttribute?.effect = responseData.body.items[0].efcyQesitm!;
        tempPillAttribute?.warning = responseData.body.items[0].atpnQesitm!;
        tempPillAttribute?.howToStore =
        responseData.body.items[0].depositMethodQesitm!;
        tempPillAttribute?.sideEffect = responseData.body.items[0].seQesitm!;
        tempPillAttribute?.interaction = responseData.body.items[0].intrcQesitm!;

        // Copy the image to new location with desired name
        String oldPath = pickedImage.path;
        String newPath = join(
            dirname(oldPath), '${tempPillAttribute?.name}.png');
        tempPillAttribute?.imgPath = newPath;
        await File(oldPath).copy(newPath);
        // 이미지 호출: Image.file(File(tempPillAttribute?.imgPath))
        PillAttributeController.set(tempPillAttribute!);
        PillAttributeController.show();
        print("[debug]image search done");
        Navigator.of(context).pop();  // Close the dialog
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SelectScreen()),
        );
      }
    }catch (error) {
      Navigator.of(context).pop();  // Close the dialog
      print("Error in processPickedImage: $error");
    }
  }


  @override
  Widget build(BuildContext context) {

    CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);
    PillAttribute? pillAttribute = Provider.of<PillAttribute?>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 검색 창
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: paddingBetween),
                    child: const Text(
                      "무엇을 찾으시나요?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: fontSizeHeader1,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: TextField(
                              controller: searchTextController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                hintText: '검색어를 입력해주세요.',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: IconButton(
                              icon: const Icon(Icons.search, color: Colors.black),
                              onPressed: () async {
                                try {
                                  String inputValue = searchTextController.text;
                                  // 로딩 중 표시
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,  // Prevents the dialog from closing on outside tap
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircularProgressIndicator(),
                                                SizedBox(width: 20),
                                                Text("Processing..."),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                  ResponseData responseData = await TextSearchRequest(inputValue);
                                  pillAttribute?.pillId = responseData.body.items[0].itemSeq!;
                                  pillAttribute?.name = responseData.body.items[0].itemName!;
                                  pillAttribute?.howToUse = responseData.body.items[0].useMethodQesitm!;
                                  pillAttribute?.effect = responseData.body.items[0].efcyQesitm!;
                                  pillAttribute?.warning = responseData.body.items[0].atpnQesitm!;
                                  pillAttribute?.howToStore = responseData.body.items[0].depositMethodQesitm!;
                                  pillAttribute?.sideEffect = responseData.body.items[0].seQesitm!;
                                  pillAttribute?.interaction = responseData.body.items[0].intrcQesitm!;
                                  PillAttributeController.set(pillAttribute!);
                                  PillAttributeController.show();
                                  Navigator.of(context).pop();  // Close the dialog
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => const SelectScreen()),
                                  );
                                } catch (error) {
                                  print('Error while searching: $error');
                                  // TODO: Maybe show a dialog or snackbar to inform the user about the error
                                }
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '인기있는',
                    style: TextStyle(
                        color: Colors.black, letterSpacing: 2.0, fontSize: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: paddingBetween),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('타이레놀',
                              style: TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('케토톱',
                              style: TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('아스피린',
                              style: TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: padding),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: paddingBetween),
                    child: const Text(
                      "카테고리 별 약 찾기",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: fontSizeHeader2,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      'lib/assets/medicine.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain, // 이미지를 부모 위젯에 맞게 조절하되, 원본 비율을 유지합니다.
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home, size: iconSizeBig), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt, size: iconSizeBig), label: "사진으로 검색"),
          BottomNavigationBarItem(icon: Icon(Icons.settings, size: iconSizeBig), label: "설정"),
        ],
        currentIndex: currentIndex.index,
        selectedItemColor: mainColor,
        onTap: (value) {
          currentIndex.setCurrentIndex(value);
          switch (value) {
            case 0:
              break;

            case 1:
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: listTileSize),
                        leading: const Icon(Icons.camera_alt, size: iconSizeBig),
                        title: const Text(
                          '카메라로 사진 찍기',
                          style: TextStyle(fontSize: fontSizeLarge),
                        ),
                        onTap: () {
                          print("Gallery onTap triggered");
                          cameraPickedImage(pillAttribute,context);
                        },
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: listTileSize),
                        leading: const Icon(Icons.photo, size: iconSizeBig),
                        title: const Text(
                          '갤러리에서 사진 선택',
                          style: TextStyle(fontSize: fontSizeLarge),
                        ),
                        onTap: () {
                          print("Gallery onTap triggered");
                          galleryPickedImage(pillAttribute,context);
                        },
                      ),
                    ],
                  );
                },
              );
              break;

            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyInfoScreen()),
              );
              break;
          }

          setState(() {});
        },
      ),
    );
  }
}
