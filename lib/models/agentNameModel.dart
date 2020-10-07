import 'dart:convert';

AgentNameModel agentNameModelFromJson(String str) =>
    AgentNameModel.fromJson(json.decode(str));

String agentNameModelToJson(AgentNameModel data) => json.encode(data.toJson());

class AgentNameModel {
  String CustomerName;

  AgentNameModel({
    this.CustomerName,
  });

  factory AgentNameModel.fromJson(Map<String, dynamic> json) {
    return AgentNameModel(
      CustomerName: json['CustomerName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "CustomerName": CustomerName == null ? null : CustomerName,
      };
}
