import 'package:app_social/components/custom_card_product.dart';

import 'package:app_social/models/product.dart';
import 'package:app_social/page/user/product_description_page.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/provider/user_provider.dart';
import 'package:app_social/theme/app_colors.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late double height;
  late double width;
  late AuthencationProvider auth;
  late UserProvider userProvider;

  String name = '';
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthencationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(auth),
        )
      ],
      child: Builder(
        builder: (context) {
          userProvider = context.watch<UserProvider>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.kFirstMainColor,
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(left: 25, right: 20),
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: AppStyle.h4.copyWith(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: StreamBuilder(
                stream: userProvider.searchProduct(name),
                builder: (context, AsyncSnapshot<List<Product?>> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: .8,
                      children: snapshot.data!
                          .map(
                            (item) => InkWell(
                              onTap: () => userProvider.auth.navigationService
                                  .navigateToPage(
                                ProductDesCriptionPage(
                                  item: item,
                                  userProvider: userProvider,
                                ),
                              ),
                              child: CustomCardProduct(item: item!),
                            ),
                          )
                          .toList(),
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
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
