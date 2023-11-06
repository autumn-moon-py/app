import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../controller/home_controller.dart';
import '../widget.dart';

// 剧情，图鉴攻略，Tap采访，情报姬采访
//https://www.taptap.cn/moment/15209477846337090
//https://www.taptap.cn/moment/15221781719681998
//https://www.taptap.cn/moment/453488406542943629

final postType = ['公告', '资讯'];
final posts = [
  {'type': '公告', 'post': 'first', 'title': '致新老玩家的一封信', 'time': '2023-10-20'},
  {
    'type': '资讯',
    'post': 'taptap_qbj',
    'title': '下架 3 年后，一位玩家把《异次元通讯》复活了',
    'time': '2023-09-20'
  },
  {
    'type': '资讯',
    'post': 'taptap',
    'title': '心爱的游戏下架，16岁少年用3年自学编程将它复活',
    'time': '2023-11-2'
  },
];

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int nowPage = 0;
  final homeController = Get.find<HomeController>();

  Widget _tab() {
    List<Widget> list = [];
    for (var type in postType) {
      if (list.length == postType.length) break;
      list.add(InkWell(
          onTap: () => setState(() {
                nowPage = postType.indexOf(type);
              }),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  color: nowPage == postType.indexOf(type) ? Colors.blue : null,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: Text(type,
                      style: textStyle(
                          homeController.isLandscape.value ? 10 : 20,
                          color: Colors.white))))));
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }

  Widget _infoPage() {
    List<Widget> list = [];
    final typePosts =
        posts.where((element) => element['type'] == postType[nowPage]);
    final ls = homeController.isLandscape.value;
    for (var post in typePosts) {
      if (list.length == typePosts.length) break;
      list.add(InkWell(
          onTap: () => context.go('/post?name=${post['post']}'),
          child: Row(children: [
            Container(
                margin: EdgeInsets.only(bottom: 3.h),
                child: Text(post['type']!,
                    style: textStyle(ls ? 12 : 22, color: Colors.blue))),
            sb(width: ls ? 5.w : 10.w),
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: ls ? 0.3.sw : 0.45.sw),
                child: Text(post['title']!,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle(ls ? 10 : 20))),
            Expanded(child: sb()),
            Text(post['time']!,
                style: textStyle(ls ? 10 : 20, color: Colors.grey))
          ])));
    }
    return SizedBox(width: ls ? 0.5.sw : 0.8.sw, child: Column(children: list));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(children: [
        const Background(),
        Container(color: Colors.black45),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_tab(), sb(height: 20.h), _infoPage()])
      ]);
    });
  }
}
