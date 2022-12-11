import 'dart:io';
import 'package:app_social/components/card_item.dart';
import 'package:app_social/components/card_video.dart';
import 'package:app_social/models/message.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/provider/chat_provider.dart';
import 'package:app_social/service/storage_service.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({
    super.key,
    required this.cid,
    required this.displayName,
    required this.photoURL,
    required this.yid,
    required this.email,
    required this.idCall,
    required this.idVideo,
    required this.isCheckVideoCall,
  });
  final String cid;
  final String displayName;
  final String photoURL;
  final String yid;
  final String email;
  final String idVideo;
  final String idCall;
  final bool isCheckVideoCall;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late AuthencationProvider auth;

  late ChatProvider chatProvider;
  late TextEditingController controller;
  final GlobalKey<AnimatedListState> key = GlobalKey();
  StorageService ss = StorageService();
  bool isMeetingActive = false;
  File? isfile;

  final Tween<Offset> offset =
      Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
  late Stream<List<Message>> stream;
  List<Message> currentMessageList = [];
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    chatProvider = Provider.of(context, listen: false);
    stream = chatProvider.getMessage(widget.cid);

    stream.listen((newMessages) {
      final List<Message> messageList = newMessages;
      if (key.currentState != null &&
          key.currentState!.widget.initialItemCount < messageList.length) {
        List<Message> updateList =
            messageList.where((e) => !currentMessageList.contains(e)).toList();

        for (var update in updateList) {
          final int updateIndex = messageList.indexOf(update);
          key.currentState!.insertItem(updateIndex);
        }
      }
      currentMessageList = messageList;
    });
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path ?? "");
      setState(() {
        isfile = file;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF131B26),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B7C92),
        title: Text(
          widget.displayName,
          style: AppStyle.h3,
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                isMeetingActive = true;
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12, left: 12),
              child: Icon(
                Icons.video_camera_back,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.phone,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: stream,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 100.h,
              width: 100.w,
              child: Column(
                children: [
                  Expanded(
                    flex: 11,
                    child: AnimatedList(
                      shrinkWrap: true,
                      key: key,
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      initialItemCount: snapshot.data!.length,
                      itemBuilder: ((context, index, animation) {
                        final message = snapshot.data![index];
                        bool isCheck = auth.user.uid == message.senderID;
                        return SlideTransition(
                          position: animation.drive(offset),
                          child: message.type.name == 'video'
                              ? CardVideo(
                                  url: message.content,
                                  isCheck: isCheck,
                                  photoURL: widget.photoURL,
                                )
                              : CardItem(
                                  content: message.content,
                                  isCheck: isCheck,
                                  photoURL: widget.photoURL,
                                  type: message.type.name,
                                ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF354657),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding:
                                  const EdgeInsets.only(left: 25, right: 20),
                              margin: const EdgeInsets.only(
                                left: 25,
                              ),
                              child: TextField(
                                style:
                                    AppStyle.h4.copyWith(color: Colors.white),
                                controller: controller,
                                decoration: InputDecoration(
                                  icon: InkWell(
                                    onTap: () async {
                                      await pickFile();
                                      String? mimeStr =
                                          lookupMimeType(isfile!.path);
                                      var fileType = mimeStr!.split('/');

                                      String mid =
                                          await chatProvider.sendMessage(
                                        widget.cid,
                                        '',
                                        auth.user.uid,
                                        fileType[0] == 'video'
                                            ? Type.video
                                            : Type.image,
                                      );

                                      String url = await ss.uploadFileToStorage(
                                          name: widget.displayName,
                                          file: isfile!,
                                          id: auth.user.uid);
                                      await chatProvider.uploadFile(
                                          mid: mid, cid: widget.cid, url: url);
                                    },
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: "Write message here...",
                                  hintStyle:
                                      AppStyle.h4.copyWith(color: Colors.white),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () async {
                                if (controller.text.isNotEmpty) {
                                  await chatProvider.sendMessage(
                                      widget.cid,
                                      controller.text,
                                      auth.user.uid,
                                      Type.text);

                                  controller.text = '';
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('error'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
