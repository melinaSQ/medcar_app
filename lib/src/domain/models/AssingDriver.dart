// ignore_for_file: file_names

import 'dart:convert';

AssingDriver assingDriverFromJson(String str) => AssingDriver.fromJson(json.decode(str));

String assingDriverToJson(AssingDriver data) => json.encode(data.toJson());

class AssingDriver {
    String message;

    AssingDriver({
        required this.message,
    });

    factory AssingDriver.fromJson(Map<String, dynamic> json) => AssingDriver(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}