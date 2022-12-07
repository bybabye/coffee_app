import 'package:equatable/equatable.dart';

enum Type {
  text,
  video,
  image,
}

class Message extends Equatable {
  final String mID;
  final String senderID;
  final String content;
  final Type type;
  final DateTime sentTime;

  const Message({
    required this.mID,
    required this.senderID,
    required this.content,
    required this.type,
    required this.sentTime,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    Type typeSend = Type.text;
    switch (json['type']) {
      case 'text':
        typeSend = Type.text;
        break;
      case 'video':
        typeSend = Type.video;
        break;
      case 'image':
        typeSend = Type.image;
        break;
      default:
    }

    return Message(
      mID: json['mID'],
      senderID: json['senderID'],
      content: json['content'],
      type: typeSend,
      sentTime: json['sentTime'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    String typeSend;
    switch (type) {
      case Type.text:
        typeSend = 'text';
        break;
      case Type.video:
        typeSend = 'video';
        break;
      case Type.image:
        typeSend = 'image';
        break;
    }
    return {
      'mID': mID,
      'senderID': senderID,
      'sentTime': sentTime,
      'type': typeSend,
      'content': content,
    };
  }

  @override
  List<Object?> get props => [mID, senderID, sentTime, type, content];
}
