import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/pill_attribute.dart';

class ExplainScreen extends StatefulWidget {
  final String medicineDetail;

  const ExplainScreen({Key? key, required this.medicineDetail}) : super(key: key);

  @override
  State<ExplainScreen> createState() => _ExplainScreenState();
}

class _ExplainScreenState extends State<ExplainScreen> {
  // Define a map for the variable names to display names
  Map<String, String> detailNameMapping = {
    'pillId': 'Pill ID',
    'name': '이름',
    'howToUse': '사용법',
    'effect': '효능',
    'warning': '주의사항',
    'howToStore': '보관법',
    'sideEffect': '부작용',
    'interaction': '위험 약+음식',
    'imgPath': 'Image Path',
  };

  String getDisplayName(PillAttribute attribute) {
    if (attribute.pillId == widget.medicineDetail) return detailNameMapping['pillId'] ?? 'Unknown';
    if (attribute.name == widget.medicineDetail) return detailNameMapping['name'] ?? 'Unknown';
    if (attribute.howToUse == widget.medicineDetail) return detailNameMapping['howToUse'] ?? 'Unknown';
    if (attribute.effect == widget.medicineDetail) return detailNameMapping['effect'] ?? 'Unknown';
    if (attribute.warning == widget.medicineDetail) return detailNameMapping['warning'] ?? 'Unknown';
    if (attribute.howToStore == widget.medicineDetail) return detailNameMapping['howToStore'] ?? 'Unknown';
    if (attribute.sideEffect == widget.medicineDetail) return detailNameMapping['sideEffect'] ?? 'Unknown';
    if (attribute.interaction == widget.medicineDetail) return detailNameMapping['interaction'] ?? 'Unknown';
    if (attribute.imgPath == widget.medicineDetail) return detailNameMapping['imgPath'] ?? 'Unknown';
    return 'Unknown';
  }
  @override
  Widget build(BuildContext context) {
    PillAttribute? pillAttribute = Provider.of<PillAttribute?>(context);
    String displayName = getDisplayName(pillAttribute!);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarSize),
        child: AppBar(
          backgroundColor: mainColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: iconSizeAppBar, color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 15,),
                Container(
                  color: Colors.white,
                  child: AutoSizeText(
                    pillAttribute.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: fontSizeHeader1, // This will be the maximum font size
                        fontFamily: fontStyleNanumBold
                    ),
                    maxLines: 2, // Specify the maximum number of lines for the text
                    minFontSize: fontSizeMin, // Specify the minimum font size
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          displayName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeHeader1,
                            fontWeight: FontWeight.w800,
                              fontFamily: fontStyleNanumBold
                          ),
                        ),
                        SizedBox(width: 20,height: 20,),
                        Text(
                          widget.medicineDetail,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeHeader2,
                            fontWeight: FontWeight.w700,
                              fontFamily: fontStyleNanumBold,
                            height: 1.4
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

