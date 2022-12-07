import 'dart:async';
import 'dart:ui';
import 'package:app_social/models/api.dart';
import 'package:app_social/models/chats.dart';
import 'package:app_social/models/debouncer.dart';
import 'package:app_social/models/user_app.dart';
import 'package:app_social/page/home/message_page.dart';
import 'package:app_social/provider/chat_provider.dart';
import 'package:app_social/components/custom_button_circle.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/theme/app_assets.dart';

import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthencationProvider auth;
  late double height;
  late double width;
  late ChatProvider chatProvider;
  Debouncer debouncer = Debouncer();
  String field = '';
  bool isOn = false;
  Timer? debounce;
  @override
  Widget build(BuildContext context) {
    auth = Provider.of(context);
    chatProvider = Provider.of(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            child: Image.asset(
              AppAssets.background,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.28),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border.all(color: Colors.white),
            ),
            margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButtonCircle(
                        func: () {},
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(auth.user.photoURL),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        auth.user.displayname,
                        style: AppStyle.h3,
                      ),
                      CustomButtonCircle(
                        func: () async => await auth.logout(),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.logout),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
                  child: Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.menu,
                          )),
                      Expanded(
                        flex: 9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.only(left: 25, right: 20),
                          margin: const EdgeInsets.only(
                            left: 25,
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                field = value;
                              });
                            },
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.search_rounded),
                              hintText: "Search...",
                              border: InputBorder.none,
                              hintStyle: AppStyle.h4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Flexible(
                  child: StreamBuilder(
                    stream: chatProvider.getListUser(field),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          margin: const EdgeInsets.only(top: 12),
                          height: height,
                          width: width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length < 5
                                ? snapshot.data!.length
                                : 5,
                            itemBuilder: (context, index) {
                              UserApp user = snapshot.data![index];
                              return user.uid != auth.user.uid
                                  ? InkWell(
                                      onTap: () async {
                                        Chats chats = await chatProvider
                                            .addChat(auth.user.uid, user.uid);

                                        if (chats.cid.isNotEmpty) {
                                          auth.navigationService
                                              .navigateToPage(MessagePage(
                                            idCall: chats.idCall,
                                            idVideo: chats.idVideo,
                                            isCheckVideoCall:
                                                chats.isCheckVideoCall,
                                            cid: chats.cid,
                                            displayName: user.displayname,
                                            photoURL: user.photoURL,
                                            yid: user.uid,
                                            email: user.email,
                                          ));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        height: 100,
                                        width: width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                user.photoURL.isNotEmpty
                                                    ? Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  user
                                                                      .photoURL),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      )
                                                    : const SizedBox(
                                                        height: 60,
                                                        width: 60,
                                                      ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      user.displayname,
                                                      style: AppStyle.h3,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Hay noi chuyen vs minh nao !!',
                                                      style: AppStyle.h4
                                                          .copyWith(
                                                              color:
                                                                  Colors.grey),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                const Icon(
                                                    Icons.message_outlined),
                                              ],
                                            ),
                                            Container(
                                              height: 2,
                                              color: Colors.grey[200],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
