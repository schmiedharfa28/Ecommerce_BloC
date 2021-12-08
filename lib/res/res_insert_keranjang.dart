// To parse this JSON data, do
//
//     final resInsertKeranjang = resInsertKeranjangFromJson(jsonString);

import 'dart:convert';

ResInsertKeranjang resInsertKeranjangFromJson(String str) => ResInsertKeranjang.fromJson(json.decode(str));

String resInsertKeranjangToJson(ResInsertKeranjang data) => json.encode(data.toJson());

class ResInsertKeranjang {
    ResInsertKeranjang({
        this.status,
        this.message,
    });

    int? status;
    String? message;

    factory ResInsertKeranjang.fromJson(Map<String, dynamic> json) => ResInsertKeranjang(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
    };
}
