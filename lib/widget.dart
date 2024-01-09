import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'controller/home_controller.dart';

class VideoScreen extends StatefulWidget {
  final double? size;
  const VideoScreen({super.key, this.size});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/other/vcr.webm')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _closeVideo() {
    _controller.seekTo(Duration.zero);
    _controller.pause();
    Get.back();
  }

  void _showVideo() {
    _controller.play();
    Get.dialog(Material(
        color: Colors.black.withOpacity(0),
        child: Stack(children: [
          Center(
              child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller))),
          SizedBox(
              width: 1.sw,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          _closeVideo();
                        },
                        child: Icon(Icons.close,
                            color: Colors.white, size: 30.sp)),
                  ]))
        ])));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            _showVideo();
          },
          child: Icon(Icons.play_circle_outline,
              color: Colors.white,
              size: homeController.isLandscape.value ? 50.sp : 150.sp));
    });
  }
}

Widget logo(double height, int index) {
  return Image.asset('assets/logo/logo$index.webp', height: height);
}

Widget sb({double? width, double? height}) {
  return SizedBox(width: width, height: height);
}

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  final homeController = Get.find<HomeController>();

  void _showMenu() {
    homeController.showMenu.value = !homeController.showMenu.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
        onTap: () {
          _showMenu();
        },
        child: Icon(homeController.showMenu.value ? Icons.close : Icons.menu,
            color: Colors.white, size: 40.sp)));
  }
}

Widget downloadButton(
    {required Function callback,
    required String name,
    double? size,
    EdgeInsets? padding}) {
  return InkWell(
      onTap: () {
        callback.call();
      },
      child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(35, 167, 251, 1),
                Color.fromRGBO(246, 62, 136, 1)
              ])),
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 40.w),
          child:
              Text(name, style: textStyle(color: Colors.white, size ?? 20))));
}

Widget downloadWebButton({
  required Function callback,
  required String title,
  required IconData icon,
  required Color color,
  double? fontsize,
  double? size,
}) {
  return InkWell(
      onTap: () {
        callback.call();
      },
      child: Container(
          width: 55.w,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(children: [
            sb(width: 5.w),
            Icon(icon, color: Colors.white, size: size ?? 10.sp),
            sb(width: 5.w),
            Text(title,
                style:
                    textStyle(color: Colors.white, bold: true, fontsize ?? 5))
          ])));
}

class Top extends StatefulWidget {
  const Top({super.key});

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  final homeController = Get.find<HomeController>();

  Widget _menuList() {
    return Obx(() {
      List menuList = homeController.menuList;
      final index = homeController.nowPage.value;
      List<Widget> list = [];
      for (var menu in menuList) {
        list.add(InkWell(
            onTap: () async {
              Future.delayed(const Duration(milliseconds: 300), () {
                homeController.homePageController.jumpToPage(menu["index"]);
                homeController.showMenu.value = false;
                homeController.nowPage.value = menu["index"];
              });
              context.go('/');
            },
            child: Text(menu["title"],
                style: textStyle(
                    color: index == menu["index"]
                        ? const Color.fromRGBO(227, 72, 146, 1)
                        : Colors.white,
                    bold: true,
                    8))));
        list.add(sb(width: 20.w));
      }
      return Row(children: list);
    });
  }

  Widget _top() {
    final ls = homeController.isLandscape.value;

    return Container(
        padding: ls ? null : EdgeInsets.only(top: 5.h),
        decoration: ls
            ? BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(1), Colors.transparent]))
            : BoxDecoration(
                color: homeController.bgIndex.value == 0
                    ? Colors.transparent
                    : Colors.black54),
        child: ls
            ? Column(mainAxisSize: MainAxisSize.min, children: [
                sb(height: 10.h),
                Row(children: [
                  sb(width: 40.w),
                  logo(60.h, 1),
                  Expanded(child: sb()),
                  _menuList(),
                  sb(width: 20.w)
                ]),
                sb(height: 10.h)
              ])
            : Row(children: [
                sb(width: 10.w),
                logo(40.h, 1),
                Expanded(child: sb()),
                const MenuButton(),
                sb(width: 10.w)
              ]));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _top());
  }
}

class Background extends StatefulWidget {
  const Background({super.key});

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLandscape = homeController.isLandscape.value;
      return !isLandscape
          ? Image.asset('assets/bg/start_bg.webp',
              width: 1.sw, height: 1.sh, fit: BoxFit.cover)
          : Image.asset('assets/bg/menu_bg.webp',
              width: 1.sw, fit: BoxFit.cover);
    });
  }
}

class Arrow extends StatefulWidget {
  const Arrow({super.key});

  @override
  State<Arrow> createState() => _ArrowState();
}

class _ArrowState extends State<Arrow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          homeController.homePageController.nextPage(
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        child: Transform.translate(
            offset: Offset(0, 10 * _animation.value),
            child:
                Icon(Icons.arrow_downward, color: Colors.white, size: 10.sp)));
  }
}

TextStyle textStyle(double fontsize, {Color? color, bool bold = false}) {
  return TextStyle(
      color: color ?? Colors.white,
      fontSize: fontsize.sp,
      fontWeight: bold ? null : FontWeight.bold);
}
