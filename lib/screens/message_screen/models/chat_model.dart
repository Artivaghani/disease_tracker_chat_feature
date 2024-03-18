
class ChatModel {
  String? senderId;
  String? msg;
  bool? isRead;
  String? timestamp;

  ChatModel({this.senderId, this.msg, this.isRead, this.timestamp});

  ChatModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    msg = json['msg'];
    isRead = json['isRead'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['msg'] = msg;
    data['isRead'] = isRead;
    data['timestamp'] = timestamp;
    return data;
  }
}
