class Chats {
  final String cid;
  final List<String> members;
  final String idVideo;
  final bool isCheckVideoCall;
  final String idCall;

  Chats(
      {required this.cid,
      required this.members,
      required this.idVideo,
      required this.idCall,
      required this.isCheckVideoCall});

  factory Chats.fromJson(Map<String, dynamic> json) {
    return Chats(
      cid: json['cid'],
      members: List.from(json['members']),
      idVideo: json['idVideo'] ?? "",
      idCall: json['isCall'] ?? "",
      isCheckVideoCall: json['isCheckVideoCall'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cid': cid,
      'members': members,
      'idVideo': idVideo,
      'isCall': idCall,
      'isCheckVideoCall': isCheckVideoCall
    };
  }
}
