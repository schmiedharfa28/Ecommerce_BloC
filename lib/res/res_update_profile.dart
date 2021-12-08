// To parse this JSON data, do
//
//     final resUpdateProfile = resUpdateProfileFromJson(jsonString);

import 'dart:convert';

ResUpdateProfile resUpdateProfileFromJson(String str) =>
    ResUpdateProfile.fromJson(json.decode(str));

String resUpdateProfileToJson(ResUpdateProfile data) =>
    json.encode(data.toJson());

class ResUpdateProfile {
  ResUpdateProfile({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  int? status;
  String? data;

  factory ResUpdateProfile.fromJson(Map<String, dynamic> json) =>
      ResUpdateProfile(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "data": data == null ? null : data,
      };
}
