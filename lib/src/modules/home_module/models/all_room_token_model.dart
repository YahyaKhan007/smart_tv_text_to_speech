import 'dart:convert';

/// Top-level function to parse the entire response
AllRoomTokenModel allRoomTokenModelFromJson(String str) =>
    AllRoomTokenModel.fromJson(json.decode(str));

String allRoomTokenModelToJson(AllRoomTokenModel data) => json.encode(data.toJson());

class AllRoomTokenModel {
  final List<PatientData>? data;
  final String? errorMessage;
  final int? statusCode;
  final int? status;
  final dynamic totalRows;
  final dynamic filterRows;

  AllRoomTokenModel({
    this.data,
    this.errorMessage,
    this.statusCode,
    this.status,
    this.totalRows,
    this.filterRows,
  });

  factory AllRoomTokenModel.fromJson(Map<String, dynamic> json) => AllRoomTokenModel(
    data: json["Data"] == null
        ? []
        : List<PatientData>.from(json["Data"].map((x) => PatientData.fromJson(x))),
    errorMessage: json["ErrorMessage"],
    statusCode: json["StatusCode"],
    status: json["Status"],
    totalRows: json["TotalRows"],
    filterRows: json["FilterRows"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "ErrorMessage": errorMessage,
    "StatusCode": statusCode,
    "Status": status,
    "TotalRows": totalRows,
    "FilterRows": filterRows,
  };
}

class PatientData {
  final String? mrNo;
  final String? name;
  final String? cnicNumber;
  final String? age;
  final String? cellNo;
  final String? address;
  final String? picturePath;
  final int? tokenNumber;
  final String? gender;
  final bool? isAlreadyExists;
  final String? queueName;
  final String? prescribedBy;
  final int? status;
  final String? statusName;
  final String? userId;
  final String? roomId;
  final String? queueId;
  final String? storeId;
  final String? patientId;
  final String? visitNo;
  final int? tokenType;
  final bool? isPrintRequired;
  final String? roomPronunciation;
  final bool? isWaiting;

  PatientData({
    this.mrNo,
    this.name,
    this.cnicNumber,
    this.age,
    this.cellNo,
    this.address,
    this.picturePath,
    this.tokenNumber,
    this.gender,
    this.isAlreadyExists,
    this.queueName,
    this.prescribedBy,
    this.status,
    this.statusName,
    this.userId,
    this.roomId,
    this.queueId,
    this.storeId,
    this.patientId,
    this.visitNo,
    this.tokenType,
    this.isPrintRequired,
    this.roomPronunciation,
    this.isWaiting,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
    mrNo: json["MRNo"],
    name: json["Name"],
    cnicNumber: json["CNICNumber"],
    age: json["Age"],
    cellNo: json["CellNo"],
    address: json["Address"],
    picturePath: json["PicturePath"],
    tokenNumber: json["TokenNumber"],
    gender: json["Gender"],
    isAlreadyExists: json["IsAlreadyExists"],
    queueName: json["QueueName"],
    prescribedBy: json["PrescribedBy"],
    status: json["Status"],
    statusName: json["StatusName"],
    userId: json["UserId"],
    roomId: json["RoomId"],
    queueId: json["QueueId"],
    storeId: json["StoreId"],
    patientId: json["PatientId"],
    visitNo: json["VisitNo"],
    tokenType: json["TokenType"],
    isPrintRequired: json["IsPrintRequired"],
    roomPronunciation: json["RoomPronunciation"],
    isWaiting: json["IsWaiting"],
  );

  Map<String, dynamic> toJson() => {
    "MRNo": mrNo,
    "Name": name,
    "CNICNumber": cnicNumber,
    "Age": age,
    "CellNo": cellNo,
    "Address": address,
    "PicturePath": picturePath,
    "TokenNumber": tokenNumber,
    "Gender": gender,
    "IsAlreadyExists": isAlreadyExists,
    "QueueName": queueName,
    "PrescribedBy": prescribedBy,
    "Status": status,
    "StatusName": statusName,
    "UserId": userId,
    "RoomId": roomId,
    "QueueId": queueId,
    "StoreId": storeId,
    "PatientId": patientId,
    "VisitNo": visitNo,
    "TokenType": tokenType,
    "IsPrintRequired": isPrintRequired,
    "RoomPronunciation": roomPronunciation,
    "IsWaiting": isWaiting,
  };
}
