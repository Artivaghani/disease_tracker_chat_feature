class MessageModel {
  String? pId;
  String? dId;
  String? timestamp;
  String? lastMsg;
  String? pName;
  String? pProfile;
  String? dName;
  String? dProfile;
  bool? isBlock;

  MessageModel(
      {this.pId,
      this.dId,
      this.timestamp,
      this.lastMsg,
      this.pName,
      this.pProfile,
      this.dName,
      this.dProfile,
      this.isBlock});

  MessageModel.fromJson(Map<String, dynamic> json) {
    pId = json['pId'];
    dId = json['dId'];
    timestamp = json['timestamp'];
    lastMsg = json['lastMsg'];
    pName = json['pName'];
    pProfile = json['pProfile'];
    dName = json['dName'];
    dProfile = json['dProfile'];
    isBlock = json['isBlock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pId'] = pId;
    data['dId'] = dId;
    data['timestamp'] = timestamp;
    data['lastMsg'] = lastMsg;
    data['pName'] = pName;
    data['pProfile'] = pProfile;
    data['dName'] = dName;
    data['dProfile'] = dProfile;
    data['isBlock'] = isBlock;
    return data;
  }
}
