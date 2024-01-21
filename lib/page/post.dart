import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/home_controller.dart';
import '../widget.dart';
import 'menu.dart';

class PostPage extends StatefulWidget {
  final String name;
  const PostPage({super.key, required this.name});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with WidgetsBindingObserver {
  final homeController = Get.find<HomeController>();
  String data = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.nowPage.value = homeController.menuList.length;
      readPost(widget.name);
    });
  }

  void readPost(String name) async {
    final file = await rootBundle.loadString('assets/posts/$name.md');
    data = file;
    setState(() {});
  }

  Widget _postWidget() {
    final ls = homeController.isLandscape.value;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: ls ? 60.h : 40.h),
              width: 1.sw,
              padding: EdgeInsets.symmetric(
                  horizontal: ls ? 0.2.sw : 20.w, vertical: 10.h),
              child: MarkdownText(data,
                  style: const TextStyle(color: Colors.white, fontSize: 25))))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          context.go('/');
          return Future.value(true);
        },
        child: Scaffold(
            body: Stack(children: [
          const Background(),
          Container(color: Colors.black45),
          _postWidget(),
          Obx(() => homeController.showMenu.value ? const MenuPage() : sb()),
          const Top()
        ])));
  }
}

class MarkdownText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  const MarkdownText(this.data, {super.key, this.style});

  TextSpan _parse(String text) {
    final span = <InlineSpan>[];
    final regex = RegExp(
        r'!\[(.*?)\]\((.*?)\)|\[(.*?)\]\((.*?)\)|#+(?: (.*))?|(.*?)(?=\[|\!|\#|$)');
    final matches = regex.allMatches(text);
    var currentIndex = 0;
    for (final match in matches) {
      if (match.start > currentIndex) {
        span.add(TextSpan(text: text.substring(currentIndex, match.start)));
      }
      // Image
      final imageAlt = match.group(1);
      final imageUrl = match.group(2);
      // Link
      final linkText = match.group(3);
      final url = match.group(4);
      // Heading
      final heading = match.group(5);
      if (imageUrl != null && imageAlt != null) {
        span.add(WidgetSpan(child: Image.network(imageUrl)));
      } else if (url != null && linkText != null) {
        span.add(TextSpan(
            style: const TextStyle(color: Colors.blue),
            text: linkText,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(Uri.parse(url));
              }));
      } else if (heading != null) {
        span.add(TextSpan(
            text: heading,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)));
      } else {
        final normalText = match.group(6);
        if (normalText != null) {
          span.add(TextSpan(text: normalText));
        }
      }
      currentIndex = match.end;
    }
    if (currentIndex < text.length) {
      span.add(TextSpan(text: text.substring(currentIndex)));
    }
    return TextSpan(children: span);
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(_parse(data), style: style);
  }
}
