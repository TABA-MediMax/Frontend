import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taba/constants.dart';
import 'package:provider/provider.dart';
import 'package:taba/models/pill_attribute.dart';
import 'package:taba/providers/pill_attribute_controller.dart';

import '../http/dto.dart';
import '../http/request.dart';
import '../models/current_index.dart';
import 'alarm/screens/alarm_home.dart';
import 'kyu/inforBlockSelect.dart';

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
  // List to hold alarms
  late List<AlarmSettings> alarms;
  @override
  void initState() {
    super.initState();
    alarms = Alarm.getAlarms();
    alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
  }

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
                  padding: const EdgeInsets.all(padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 50,  // Adjust the width as needed
                        height: 50,  // Adjust the height as needed
                        child: CircularProgressIndicator(
                          strokeWidth: 5,  // Adjust the stroke width for a larger visual
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        "검색중...",
                        style: TextStyle(fontSize: fontSizeLarge,fontFamily: fontStyleNanumBold)),  // Adjust the font size as needed
                      ],),),);});
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
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        String newPath = join(appDocPath, '${tempPillAttribute?.pillId}.png');

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
                  padding: const EdgeInsets.all(padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 50,  // Adjust the width as needed
                        height: 50,  // Adjust the height as needed
                        child: CircularProgressIndicator(
                          strokeWidth: 5,  // Adjust the stroke width for a larger visual
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        "검색중...",
                        style: TextStyle(fontSize: fontSizeLarge,fontFamily: fontStyleNanumBold),  // Adjust the font size as needed
                      ),],),),);});
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
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        String newPath = join(appDocPath, '${tempPillAttribute?.pillId}.png');

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
    currentIndex.index = 0;
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
                      "검색창",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: fontSizeHeader1+20,
                          fontFamily: fontStyleNanumBold
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: TextField(
                              controller: searchTextController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(searcherBorderRadius),
                                  ),
                                ),
                                hintText: '약 이름을 입력해주세요.',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: const Icon(Icons.search, color: Colors.black,size: 40),
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
                                            padding: const EdgeInsets.all(padding),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: 50,  // Adjust the width as needed
                                                  height: 50,  // Adjust the height as needed
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 5,  // Adjust the stroke width for a larger visual
                                                  ),
                                                ),
                                                SizedBox(width: 30),
                                                Text(
                                                  "검색중...",
                                                  style: TextStyle(fontSize: fontSizeLarge,fontFamily: fontStyleNanumBold),  // Adjust the font size as needed
                                                ),],),),);});
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
                    '검색기록',
                    style: TextStyle(
                        color: Colors.black, letterSpacing: 2.0, fontSize: fontSizeMiddle,fontFamily: fontStyleNanumBold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: paddingBetween),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 20,),
                        OutlinedButton(
                          onPressed: () async{
                            pillAttribute?.pillId = T.pillId;
                            pillAttribute?.name = T.name;
                            pillAttribute?.howToUse = T.howToUse;
                            pillAttribute?.effect = T.effect;
                            pillAttribute?.warning = T.warning;
                            pillAttribute?.howToStore = T.howToStore;
                            pillAttribute?.sideEffect = T.sideEffect;
                            pillAttribute?.interaction = T.interaction;
                            pillAttribute?.imgPath = await assetToFilePath('lib/assets/data/T.png');
                            PillAttributeController.set(pillAttribute!);
                            PillAttributeController.show();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const SelectScreen()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: mainColor, width: 2),
                          ),
                          child: Text('타이레놀', style: TextStyle(fontSize: fontSizeMiddle, color: Colors.black,fontFamily: fontStyleNanumBold)),
                        ),
                        SizedBox(width: 20,),
                        OutlinedButton(
                          onPressed: () async{
                            pillAttribute?.pillId = K.pillId;
                            pillAttribute?.name = K.name;
                            pillAttribute?.howToUse = K.howToUse;
                            pillAttribute?.effect = K.effect;
                            pillAttribute?.warning = K.warning;
                            pillAttribute?.howToStore = K.howToStore;
                            pillAttribute?.sideEffect = K.sideEffect;
                            pillAttribute?.interaction = K.interaction;
                            pillAttribute?.imgPath = await assetToFilePath('lib/assets/data/K.png');
                            PillAttributeController.set(pillAttribute!);
                            PillAttributeController.show();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const SelectScreen()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: mainColor, width: 2),
                          ),
                          child: Text('케토톱',
                              style: TextStyle(fontSize: fontSizeMiddle, color: Colors.black,fontFamily: fontStyleNanumBold)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 20,),
                        OutlinedButton(
                          onPressed: () async{
                            pillAttribute?.pillId = A.pillId;
                            pillAttribute?.name = A.name;
                            pillAttribute?.howToUse = A.howToUse;
                            pillAttribute?.effect = A.effect;
                            pillAttribute?.warning = A.warning;
                            pillAttribute?.howToStore = A.howToStore;
                            pillAttribute?.sideEffect = A.sideEffect;
                            pillAttribute?.interaction = A.interaction;
                            pillAttribute?.imgPath = await assetToFilePath('lib/assets/data/A.png');
                            PillAttributeController.set(pillAttribute!);
                            PillAttributeController.show();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const SelectScreen()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: mainColor, width: 2),
                          ),
                          child: Text('아스피린', style: TextStyle(fontSize: fontSizeMiddle, color: Colors.black,fontFamily: fontStyleNanumBold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //TODO: Alarm
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: alarms.map((alarmSetting) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      TimeOfDay(hour: alarmSetting.dateTime.hour, minute: alarmSetting.dateTime.minute).format(context),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Alarm.stop(alarmSetting.id).then((_) => setState(() {
                          alarms = Alarm.getAlarms();
                        }));
                      },
                    ),
                    onTap: () {
                      // Optionally, navigate to alarm details or perform another action when tapped
                    },
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home, size: iconSizeBottomNavi), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt, size: iconSizeBottomNavi), label: "사진으로 검색"),
          BottomNavigationBarItem(icon: Icon(Icons.alarm, size: iconSizeBottomNavi), label: "알람"),
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
                        leading: const Icon(Icons.camera_alt, size: iconSizeBottomNavi),
                        title: const Text(
                          '카메라로 사진 찍기',
                          style: TextStyle(fontSize: fontSizeLarge,fontFamily: fontStyleNanumBold),
                        ),
                        onTap: () {
                          print("Gallery onTap triggered");
                          cameraPickedImage(pillAttribute,context);
                        },
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: listTileSize),
                        leading: const Icon(Icons.photo, size: iconSizeBottomNavi),
                        title: const Text(
                          '갤러리에서 사진 선택',
                          style: TextStyle(fontSize: fontSizeLarge,fontFamily: fontStyleNanumBold),
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
                MaterialPageRoute(builder: (context) => AlarmHomeScreen(alarmKey: '',)),
              );
              break;
          }

          setState(() {});
        },
      ),
    );
  }
}








PillAttribute K = PillAttribute(
    pillId: "001",
    name: "케토톱겔(케토프로펜)",
    howToUse: "약면의 박리지를 떼어낸 후 환부(질환 부위)에 1일 1회 부착합니다.",
    effect: "이 약은 퇴행성관절염(골관절염), 어깨관절주위염, 건염(힘줄염)ㆍ건초염(힘줄윤활막염), 건(힘줄)주위염, 상완골(위팔뼈)상과염(테니스엘보우 등), 근육통, 외상후의 종창ㆍ동통(상처후의 부기ㆍ통증)의 진통ㆍ소염(항염)에 사용합니다.",
    warning: "이 약에 과민증 및 광과민증 환자, 아스피린 천식(비스테로이드성 소염진통제 등에 의한 천식발작) 또는 경험자, 교차과민반응을 유발할 수 있는 성분(티아프로펜산, 페노피브레이트, 베자피브레이트, 시프로피브레이트, 옥시벤존)에 과민증 환자, 임신기간 6개월 이상인 임부, 15세 미만의 소아, 눈, 점막, 무좀, 백선에는 이 약을 사용하지 마십시오. 이 약을 사용하기 전에 기관지 천식 환자, 임부 또는 수유부, 손상된 피부, 습진, 발진 부위에 사용은 의사 또는 약사와 상의하십시오. 이 약을 사용 중이거나 사용 후 2주까지는 날씨에 관계없이, 옥외활동을 피하고, 일상 외출할 때에는 이 약의 도포부위를 옷, 선글라스, 모자, 자외선 차단제 등으로 가려 자외선에 노출되지 않도록 하십시오.밀봉붕대법을 사용하지 마십시오. 1주일 정도 사용하고도 증상개선이 보이지 않을 경우 사용을 즉각 중지하고 의사 또는 약사와 상의하십시오.",
    howToStore: "빛을 피해 실온에서 보관하십시오. 어린이의 손이 닿지 않는 곳에 보관하십시오.",
    sideEffect: "드물게 쇼크, 아나필락시양 증상(두드러기, 호흡곤란, 얼굴부기 등 과민성유사증상), 천식발작(건성 수포음(거품소리), 천명(숨을 쌕쌕거림), 호흡곤란), 때때로 발적(충혈되어 붉어짐), 발진, 가려움, 수포, 짓무름, 자극감 및 종창(부기) 등의 접촉피부염, 피부건조 및 색소침착 등이 나타나는 경우 사용을 즉각 중지하고 의사 또는 약사와 상의하십시오.",
    interaction: "",
    imgPath: "path_to_image/aspirin.png"
);

PillAttribute T = PillAttribute(
    pillId: "001",
    name: "타이레놀산500밀리그램(아세트아미노펜)",
    howToUse: "만 12세 이상 소아 및 성인은 1회 1~2정씩, 1일 3~4회(4~6시간 마다) 필요시 복용합니다. 이 약은 가능한 최단기간동안 최소 유효용량으로 복용하며, 1일 최대 4 g(8정)을 초과하여 복용하지 않습니다.",
    effect: "이 약은 감기로 인한 발열 및 동통(통증), 두통, 신경통, 근육통, 월경통, 염좌통(삔 통증), 치통, 관절통, 류마티양 동통(통증)에 사용합니다",
    warning: "이 약에 과민증, 소화성궤양, 심한 혈액 이상, 간장애, 신장(콩팥)장애, 심장기능저하 환자, 아스피린 천식(비스테로이드성 소염(항염)제에 의한 천식발작 유발) 환자 또는 경험자, 바르비탈계 약물 또는 삼환계 항우울제 복용한 환자, 알코올을 복용한 사람, 12세 미만의 소아는 이 약을 복용하지 마십시오. 이 약을 복용하기 전에 간장애 또는 경험자, 신장(콩팥)장애 또는 경험자, 소화성궤양의 경험자, 혈액이상 환자 또는 경험자, 출혈경향이 있는 환자, 심장기능이상이 있는 환자, 과민증 경험자, 기관지천식 환자, 고령자(노인), 임부 또는 수유부, 글루타치온 보유량이 낮은 상태의 환자는 의사 또는 약사와 상의하십시오. 복용 중에 음주하지 마십시오.",
    howToStore: "실온에서 보관하십시오. 어린이의 손이 닿지 않는 곳에 보관하십시오.",
    sideEffect: "쇼크 증상(호흡곤란, 온몸이 붉어짐, 혈관부기, 두드러기 등), 천식발작, 혈소판감소, 과립구감소, 용혈성빈혈, 메트헤모글로빈혈증, 혈소판기능 저하(출혈시간 연장), 청색증, 과민증상(얼굴부기, 땀이 남, 저혈압), 구역, 구토, 식욕부진, 위장출혈, 소화성궤양, 천공(뚦림), 발진, 알레르기 반응, 피부점막안증후군(스티븐스-존슨증후군), 독성표피괴사증(리엘증후군), AST 상승, ALT 상승, 고정발진 등이 나타나는 경우 복용을 즉각 중지하고 의사 또는 약사와 상의하십시오.",
    interaction: "바르비탈계 약물, 삼환계 항우울제 및 알코올을 투여한 환자, 와파린, 플루클록사실린을 복용하는 환자는 의사 또는 약사와 상의하십시오.",
    imgPath: "path_to_image/aspirin.png"
);

PillAttribute A = PillAttribute(
    pillId: "001",
    name: "바이엘아스피린정500밀리그람",
    howToUse: "성인 및 만 15세 이상은 1회 1~2정(500~1,000 mg)을 최소 4시간 이상 간격으로 복용합니다. 1일 최대 용량으로서 8정(4,000 mg)을 초과하지 않도록 합니다.",
    effect: "이 약은 두통, 치통, 인후통, 생리통, 근육 및 관절의 통증, 요통, 경미한 관절염 통증의 증상 완화와 감기로 인한 통증 및 열 증상의 완화에 사용합니다.",
    warning: "이 약에 과민증 환자, 소화성궤양, 아스피린천식(비스테로이드성 소염진통제 등에 의한 천식발작의 유발) 또는 그 경험자, 환자혈우병, 중증의 간장애, 중증의 신장애, 중증의 심기능부전, 출혈경향이 있는 환자, 메토트렉세이트 15밀리그람(15 mg/주) 이상의 용량을 병용 투여하는 환자, 임신 3기에 해당하는 임부는 이 약을 복용하지 마십시오. 이 약을 복용하기 전에 신장애, 심혈관순환기능이상 환자(신혈관 질환, 울혈성 심부전, 체액 감소, 큰 수술, 패혈증 또는 주요 출혈 사고 등), 간장애, 심기능이상 환자, 혈액 이상 또는 그 경험자, 기관지천식, 수술전의 환자, 고령자, 중증 포도당-6-인산염 탈수소효소결핍증 환자, 만 15세 미만의 수두 또는 인플루엔자 환자는 의사 또는 약사와 상의하십시오.",
    howToStore: "실온에서 보관하십시오. 어린이의 손이 닿지 않는 곳에 보관하십시오.",
    sideEffect: "쇽 증상(호흡곤란, 전신홍조, 혈관부종, 두드러기 등), 홍반, 가려움, 코막힘, 심장-호흡기 장애, 때때로 발진, 부종, 두드러기, 비염양 증상, 결막염, 드물게 리엘증후군(독성표피괴사용해), 스티븐스-존슨증후군(피부점막안증후군), 박탈성 피부염, 재생불량성빈혈, 빈혈, 백혈구감소, 혈소판감소, 혈소판기능 저하(출혈시간의 지연), 식욕부진, 가슴쓰림, 위통, 구역, 구토, 위장출혈, 소화성궤양 및 뚫림(천공), 귀울림, 귀 먹음, 어지러움, 두통, 흥분, 간장애, 신장애, 급성 신부전, 과호흡, 대사성 산증 증상이 나타나는 경우 복용을 즉각 중지하고 의사 또는 약사와 상의하십시오.",
    interaction: "메토트렉세이트 15밀리그람(15 mg/주) 이상의 용량, 다른 비스테로이드성 소염진통제 및 살리실산 제제와 함께 사용하지 마십시오. 항응고제, 혈전용해제/다른 혈소판응집억제제, 지혈제 및 당뇨병치료제(인슐린제제, 톨부타미드 등), 요산배설촉진제(벤즈브로마론, 프로베네시드), 저용량의 메토트렉세이트, 리튬제제, 이부프로펜, 선택적 세로토닌 재흡수 억제제, 디곡신, 전신 작용 부신피질호르몬 제제(애디슨병 대체요법용 히드로코티손 제외), 안지오텐신 전환 효소 억제제, 발프로산을 복용하는 환자는 의사 또는 약사와 상의하십시오.",
    imgPath: "path_to_image/aspirin.png"
);

Future<String> assetToFilePath(String assetPath) async {
  final ByteData byteData = await rootBundle.load(assetPath);
  final List<int> bytes = byteData.buffer.asUint8List();

  final Directory dir = await getTemporaryDirectory();
  final String fileName = assetPath.split('/').last;  // Extracting the name of the file from the asset path
  final String path = '${dir.path}/$fileName';
  final File file = File(path);

  await file.writeAsBytes(bytes, flush: true);
  return path;
}