import 'package:animate_do/animate_do.dart';
import 'package:app_new/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/home_controller.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final homeController = Get.find<HomeController>();

  Widget _menuList() {
    List<Widget> list = [];
    List menuList = homeController.menuList;
    for (var menu in menuList) {
      list.add(InkWell(
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              homeController.homePageController.jumpToPage(menu["index"]);
              homeController.showMenu.value = false;
            });
            context.go('/');
          },
          child:
              Text(menu["title"], style: textStyle(color: Colors.white, 30))));
      list.add(sb(height: 50.h));
    }
    return InkWell(
        onTap: () =>
            homeController.showMenu.value = !homeController.showMenu.value,
        child: SizedBox(
            width: 1.sw,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: list)));
  }

  Widget _friendsWebs() {
    List<Widget> list = [];
    list.add(sb(width: 25.w));
    final friendWebList = homeController.friendWebList;
    for (var menu in friendWebList) {
      final icon = menu["icon"];
      final url = menu["url"];
      list.add(InkWell(
          onTap: () {
            final uri = Uri.parse(url);
            launchUrl(uri);
          },
          child: Image.asset('assets/friend_web/$icon.webp',
              height: icon == 'tap' ? 26.sp : 30.sp)));
      list.add(sb(width: 50.w));
    }
    return Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center, children: list)));
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        duration: const Duration(milliseconds: 300),
        child: Stack(children: [
          Container(color: Colors.black54),
          _menuList(),
          _friendsWebs()
        ]));
  }
}
