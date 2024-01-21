import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;

class HomeController extends GetxController {
  HomeController();
  final homePageController = PageController(initialPage: 0);
  var bgIndex = 0.obs;
  var showMenu = false.obs;
  var isLandscape = false.obs;
  var nowPage = 0.obs;
  String downloadUrl = 'https://www.subrecovery.top/app/new/app-release.apk';
  List menuList = [
    {"title": "首页", "index": 0},
    {"title": "资讯", "index": 1},
    {"title": "角色", "index": 2}
  ];
  List friendWebList = [
    {
      "icon": "bilibili",
      "url":
          "https://space.bilibili.com/387701682/channel/seriesdetail?sid=1845136&ctype=0"
    },
    {'icon': 'tap', 'url': 'https://www.taptap.cn/app/378027'},
    {'icon': 'hykb', 'url': 'https://www.3839.com/a/156008.htm'},
    {
      'icon': 'qq',
      'url':
          'http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=-pPGHln9yKNzS00OdFJRxZ69Q-rEX_nx&authKey=kLPWmtcFJCAPpgv18epf4MW9SxGPVGTqPKKWtbOt1C%2FTX%2ByIOEyjpYeMSGxe9KWZ&noverify=0&group_code=465805687'
    }
  ];

  @override
  void onReady() {
    super.onReady();
    html.document.title = '异次元通讯-次元复苏';
    bgIndex.value = Random().nextInt(3);
    checkLandScape();
    homePageController.addListener(() {
      if (homePageController.page!.round() != nowPage.value) {
        nowPage.value = homePageController.page!.round();
      }
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      checkLandScape();
    });
  }

  void checkLandScape() {
    if (1.sw > 1.sh) {
      isLandscape.value = true;
    } else {
      isLandscape.value = false;
    }
  }

  download() async {
    final dio = Dio();
    try {
      final response =
          await dio.get('https://www.subrecovery.top/app/new/upgrade.json');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.toString());
        final version = result['version'];
        // downloadUrl =
        //     'https://www.subrecovery.top/app/new/app-release-$version.apk';
        downloadUrl = '/app/new/app-release-$version.apk';
      }
    } catch (_) {}
    launchUrl(Uri.parse(downloadUrl));
  }
}
