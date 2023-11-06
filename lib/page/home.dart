import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/home_controller.dart';
import '../widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();

  Widget _bg() {
    Widget bg(String path) {
      return Image.asset("assets/bg/$path.webp",
          width: 1.sw, height: 1.sh, fit: BoxFit.cover);
    }

    if (homeController.isLandscape.value) return bg("S3-04");
    switch (homeController.bgIndex.value) {
      case 0:
        return bg("start_bg");
      case 1:
        return bg("S1-01-n");
      case 2:
        return bg("S1-05");
      default:
        return sb();
    }
  }

  Widget _gameInfo() {
    final ls = homeController.isLandscape.value;

    return Column(children: [
      Row(
          mainAxisAlignment:
              ls ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [logo(ls ? 80.h : 60.h, 1), logo(ls ? 40.h : 30.h, 3)]),
      sb(height: ls ? 0 : 10.h),
      SizedBox(
          width: ls ? 0.3.sw : 0.7.sw,
          child: Text(
              '这是一款文字对话互动游戏，模拟主角实时发送信息，玩家将通过选项决定主角的命运。你需要时刻关注消息，主角随时需要帮助。另外，主角需要休息和活动时间，请耐心等待上线。',
              style: textStyle(ls ? 5 : 15, color: Colors.white, bold: true)))
    ]);
  }

  Widget _friendsWebs() {
    List<Widget> list = [];
    final fw = homeController.friendWebList;
    for (var menu in fw) {
      final icon = menu["icon"];
      list.add(InkWell(
          onTap: () => launchUrl(Uri.parse(menu["url"])),
          child: Container(
              padding: EdgeInsets.only(top: icon == 'tap' ? 10.h : 0),
              child: Image.asset("assets/friend_web/$icon.webp",
                  height: icon == 'tap' ? 8.sp : 10.sp))));
      if (list.length < fw.length * 2 - 1) list.add(sb(width: 13.5.w));
    }
    return Row(children: list);
  }

  Widget _qrCode() {
    return Row(children: [
      Text('扫\n码\n下\n载\n游\n戏', style: textStyle(5, color: Colors.white)),
      sb(width: 2.w),
      Image.asset('assets/other/qr_code.webp', width: 40.sp),
      sb(width: 5.w)
    ]);
  }

  Widget _bottom() {
    List<Color> colors() {
      switch (homeController.bgIndex.value) {
        case 0:
          return [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.9)
          ];
        case 1:
          return [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(1)
          ];
        case 2:
          return [Colors.transparent, Colors.black.withOpacity(0.9)];
        case 3:
          return [Colors.transparent, Colors.black.withOpacity(0.9)];
        default:
          return [Colors.transparent, Colors.black.withOpacity(0.8)];
      }
    }

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors())),
        child: homeController.isLandscape.value
            ? Row(children: [
                sb(width: 20.w),
                _gameInfo(),
                Expanded(child: sb()),
                Column(children: [
                  Row(children: [
                    _qrCode(),
                    Column(children: [
                      downloadWebButton(
                          callback: () {
                            homeController.download();
                          },
                          title: 'Android\n下载',
                          icon: Icons.android,
                          color: const Color.fromRGBO(143, 195, 31, 1)),
                      sb(height: 10.h),
                      downloadWebButton(
                          callback: () {},
                          title: 'App Store\n暂无',
                          icon: Icons.apple,
                          color: Colors.black)
                    ])
                  ]),
                  sb(height: 20.h),
                  _friendsWebs(),
                  sb(height: 40.h),
                ]),
                sb(width: 20.w)
              ])
            : Column(children: [
                sb(height: 150.h),
                _gameInfo(),
                sb(height: 30.h),
                downloadButton(
                    callback: () {
                      homeController.download();
                    },
                    name: '下载游戏'),
                sb(height: 30.h)
              ]));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(children: [
        _bg(),
        Container(
            color: homeController.bgIndex.value == 2
                ? Colors.black26
                : Colors.transparent,
            height: 1.sh,
            child: Column(children: [Expanded(child: sb()), _bottom()])),
        const Center(child: VideoScreen()),
        homeController.isLandscape.value
            ? Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 20.h),
                child: const Arrow())
            : sb()
      ]);
    });
  }
}
