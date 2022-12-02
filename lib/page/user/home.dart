import 'package:app_social/components/category.dart';
import 'package:app_social/components/custom_appbar.dart';
import 'package:app_social/components/custom_card_product.dart';
import 'package:app_social/page/user/product_description_page.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/provider/user_provider.dart';
import 'package:app_social/theme/app_assets.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double height;
  late double width;
  late AuthencationProvider auth;
  late UserProvider userProvider;

  List<String> images = [
    AppAssets.image,
    AppAssets.image,
    AppAssets.image,
    AppAssets.image,
    AppAssets.image,
    AppAssets.image,
  ];
  List<Widget> categories = [
    CategoryComponent(func: () => {}, name: 'ice', path: AppAssets.ice),
    CategoryComponent(func: () => {}, name: 'hot', path: AppAssets.hot),
    CategoryComponent(func: () => {}, name: 'tea', path: AppAssets.tea),
    CategoryComponent(func: () => {}, name: 'frappe', path: AppAssets.frappe),
  ];
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
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: CustomAppBar(
                  displayname: auth.user.displayname, url: auth.user.photoURL),
            ),
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: .7,
                          aspectRatio: 1.7,
                          enlargeCenterPage: true,
                        ),
                        items: images
                            .map(
                              (item) => Container(
                                margin: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  child: Image.asset(item),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                        child: Text(
                          'Categories',
                          style: AppStyle.h2,
                        ),
                      ),
                      Row(children: [
                        for (int i = 0; i < categories.length; i++)
                          Expanded(child: categories[i])
                      ]),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                        child: Text(
                          'Coffee',
                          style: AppStyle.h2,
                        ),
                      ),
                      StreamBuilder(
                        stream: userProvider.getProduct(),
                        builder: (context, AsyncSnapshot<List> snapshot) {
                          if (snapshot.hasData) {
                            return GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              padding: const EdgeInsets.all(20),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: .8,
                              children: snapshot.data!
                                  .map(
                                    (item) => InkWell(
                                      onTap: () => userProvider
                                          .auth.navigationService
                                          .navigateToPage(
                                        ProductDesCriptionPage(
                                          item: item,
                                          userProvider: userProvider,
                                        ),
                                      ),
                                      child: CustomCardProduct(item: item),
                                    ),
                                  )
                                  .toList(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center();
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget categorie(Function() func, String name, String path) {
    return Expanded(
      child: InkWell(
        onTap: func,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                path,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: AppStyle.h4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
