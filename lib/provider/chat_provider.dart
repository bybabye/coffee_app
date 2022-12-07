import 'package:app_social/models/api.dart';
import 'package:app_social/models/chats.dart';
import 'package:app_social/models/message.dart';
import 'package:app_social/models/user_app.dart';
import 'package:app_social/query/database_query.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
  late DatabaseQuery dq;
  ChatProvider() {
    dq = DatabaseQuery();
  }

  Stream<List<UserApp>> getListUser(
    String name,
  ) {
    // lấy danh sách user từ data
    final data = dq.queryForName('users', 'displayName', name);

    return data.map((snapshot) => snapshot.docs.map((e) {
          return UserApp.fromJson(e.data());
        }).toList());
  }

  Future<Chats> addChat(
    String uid,
    String yid,
  ) async {
    //yid => id cua nguoi ban dang chat
    final data = await dq.getChatQuery('chats', uid); // get chat contains uid
    String id = const Uuid().v1(); //  value id room
    bool isCheckIDRoom = false; // check

    Chats chat = Chats(
      cid: id,
      members: [uid, yid],
      idVideo: '',
      idCall: '',
      isCheckVideoCall: false,
    );

    if (data.docs.isEmpty) {
      // no data -> tao room

      await dq.putQuery(chat.toJson(), 'chats', id);
      return chat;
    }
    for (var e in data.docs) {
      // check id member
      // check
      if (e['members'].contains(yid)) {
        id = e['cid'];
        isCheckIDRoom = true;
        chat = Chats.fromJson(e.data());
        break;
      }
    }

    if (!isCheckIDRoom) {
      await dq.putQuery(chat.toJson(), 'chats', id);
    }

    return chat;
  }

  Future<void> sendMessage(
      String cid, String content, String senderID, Type type) async {
    String mid = const Uuid().v1();

    Message message = Message(
      mID: mid,
      senderID: senderID,
      content: content,
      type: type,
      sentTime: DateTime.now(),
    );

    await dq.sendMessQuery('chats', cid, 'messages', mid, message.toJson());
  }

  Stream<List<Message>> getMessage(
    String cid,
  ) {
    // lấy danh sách user từ data
    final data = dq.getMessageQuery('chats', 'messages', cid);

    return data.map((snapshot) => snapshot.docs.map((e) {
          return Message.fromJson(e.data());
        }).toList());
  }

  Future<void> updateRoomId(String cid, String roomId) async {
    try {
      await dq.updateQuery('chats', cid, {'idVideo': roomId});
    } catch (e) {
      print(e);
    }
  }
}
