import 'dart:convert';

class ResponseData {
  Header header;
  Body body;

  ResponseData({
    required this.header,
    required this.body
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      header: Header.fromJson(json['header']),
      body: Body.fromJson(json['body']),
    );
  }
}

class Header {
  String resultCode;
  String resultMsg;

  Header({
    required this.resultCode,
    required this.resultMsg
  });

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      resultCode: json['resultCode'],
      resultMsg: json['resultMsg'],
    );
  }
}

class Body {
  int pageNo;
  int totalCount;
  int numOfRows;
  List<Item> items;

  Body({
    required this.pageNo,
    required this.totalCount,
    required this.numOfRows,
    required this.items
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      pageNo: json['pageNo'],
      totalCount: json['totalCount'],
      numOfRows: json['numOfRows'],
      items: (json['items'] as List).map((i) => Item.fromJson(i)).toList(),
    );
  }
}
class Item {
  String? entpName;
  String? itemName;
  String? itemSeq;
  String? efcyQesitm;
  String? useMethodQesitm;
  String? atpnWarnQesitm;
  String? atpnQesitm;
  String? intrcQesitm;
  String? seQesitm;
  String? depositMethodQesitm;
  String? openDe;
  String? updateDe;
  String? itemImage;
  String? bizrno;

  Item({
    this.entpName,
    this.itemName,
    this.itemSeq,
    this.efcyQesitm,
    this.useMethodQesitm,
    this.atpnWarnQesitm,
    this.atpnQesitm,
    this.intrcQesitm,
    this.seQesitm,
    this.depositMethodQesitm,
    this.openDe,
    this.updateDe,
    this.itemImage,
    this.bizrno,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      entpName: json['entpName'] as String?,
      itemName: json['itemName'] as String?,
      itemSeq: json['itemSeq'] as String?,
      efcyQesitm: json['efcyQesitm'] as String?,
      useMethodQesitm: json['useMethodQesitm'] as String?,
      atpnWarnQesitm: json['atpnWarnQesitm'] as String?,
      atpnQesitm: json['atpnQesitm'] as String?,
      intrcQesitm: json['intrcQesitm'] as String?,
      seQesitm: json['seQesitm'] as String?,
      depositMethodQesitm: json['depositMethodQesitm'] as String?,
      openDe: json['openDe'] as String?,
      updateDe: json['updateDe'] as String?,
      itemImage: json['itemImage'] as String?,
      bizrno: json['bizrno'] as String?,
    );
  }
}


