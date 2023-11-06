import 'package:animate_do/animate_do.dart';
import 'package:app_new/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../controller/home_controller.dart';

List roleList = [
  {
    'name': 'Miko',
    'say': '走在未知的道路上，不许停也不能回头！',
    'size': 1.sw,
    'size_l': 0.5.sh,
    'margin': EdgeInsets.fromLTRB(220.w, 80.h, 0, 0),
    'margin_l': EdgeInsets.fromLTRB(100.w, 140.h, 0, 0),
    'info':
        '女高中生，坚强独立，傲娇任性，嘴上说着不喜欢跟人打交道，但其实内心还是非常希望得到陪伴。拍照不喜欢露脸。朋友很少但是对待朋友非常认真。'
  },
  {
    'name': 'Iris',
    'say': '成年人的世界里，没有容易二字。',
    'voice': '微软晓甄',
    'size': 1.sw,
    'size_l': 0.65.sh,
    'margin': EdgeInsets.fromLTRB(160.w, 80.h, 0, 0),
    'margin_l': EdgeInsets.fromLTRB(80.w, 350.h, 0, 0),
    'info':
        '智商情商高、头脑冷静，上学的时候就一直在外面各种打工实习，社会经验丰富。在罗莎曼德餐厅因Lolita与Miko成为好朋友，Iris一直把Miko当作妹妹般看待。'
  },
  {
    'name': 'Lily',
    'say': '每个人都有自己属于的地方，而我属于这片街区。',
    'size': 0.7.sw,
    'size_l': 0.4.sh,
    'voice': '微软晓甄，音调5，语速-5',
    'margin': EdgeInsets.fromLTRB(160.w, 280.h, 0, 0),
    'margin_l': EdgeInsets.fromLTRB(100.w, 530.h, 0, 0),
    'info':
        '为人仗义、头脑冷静、说话不多。辍学混社会，社会青少年组织“群青组”的大姐头。Lily行动力强，做事有规划，社会人脉广泛，属于非常可靠的行动派，擅长用街头的方式解决问题，生存能力强。'
  }
];

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  final _pageController = PageController(initialPage: 0);
  final homeController = Get.find<HomeController>();
  final player = AudioPlayer();
  bool play = false;
  var nowPage = 0.obs;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page!.round() != nowPage.value) {
        nowPage.value = _pageController.page!.round();
        setState(() {});
      }
    });
    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        play = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
    _pageController.dispose();
  }

  Widget _voiceButton(String name) {
    final ls = homeController.isLandscape.value;

    return InkWell(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: ls ? 10.w : 30.w, vertical: 5.h),
          decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(246, 62, 136, 1)),
              borderRadius: BorderRadius.circular(20.r)),
          child: Icon(!play ? Icons.keyboard_voice : Icons.pause,
              color: Colors.white, size: ls ? 10.sp : 30.sp),
        ),
        onTap: () async {
          if (player.playing) {
            player.pause();
            play = false;
            player.seek(const Duration());
            setState(() {});
            return;
          }
          await player.setAsset('assets/role/${name}_say.ogg');
          play = true;
          setState(() {});
          player.play();
        });
  }

  Widget _roleAvatars() {
    final ls = homeController.isLandscape.value;
    List<Widget> list = [];
    for (var role in roleList) {
      final name = role['name'];
      final imagePath = 'assets/role/${name}_avatar.webp';
      final choose = nowPage.value == roleList.indexOf(role);
      list.add(InkWell(
          onTap: () {
            _pageController.animateToPage(roleList.indexOf(role),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          },
          child: ClipOval(
              child: Image.asset(imagePath,
                  width: ls ? 30.sp : 80.sp,
                  color: choose ? null : Colors.grey,
                  colorBlendMode: choose ? null : BlendMode.saturation))));
      if (roleList.indexOf(role) != roleList.length - 1) {
        ls ? list.add(sb(height: 60.h)) : list.add(sb(width: 60.w));
      }
    }
    const ma = MainAxisAlignment.center;
    return ls
        ? Column(mainAxisAlignment: ma, children: list)
        : Row(mainAxisAlignment: ma, children: list);
  }

  Widget _pageItem(Map role) {
    return Obx(() {
      final ls = homeController.isLandscape.value;
      final name = role['name'];
      final imagePath = 'assets/role/$name.webp';
      final info = role['info'];
      final size = role['size'];
      final margin = role['margin'];
      final sizeL = role['size_l'];
      final marginL = role['margin_l'];
      return Stack(children: [
        OverflowBox(
            maxWidth: ls ? 1.sw : 3.sw,
            maxHeight: ls ? 2.5.sh : 3.sh,
            child: ls
                ? Row(children: [
                    sb(width: 20.w),
                    _roleAvatars(),
                    FadeInRight(
                        delay: const Duration(milliseconds: 300),
                        child: Container(
                            margin: marginL,
                            child: Image.asset(imagePath,
                                width: sizeL, fit: BoxFit.fitHeight)))
                  ])
                : Container(
                    margin: margin,
                    child: Image.asset(imagePath,
                        width: size, fit: BoxFit.fitHeight))),
        Align(
            alignment: ls ? Alignment.centerRight : Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(right: ls ? 20.w : 0),
                width: ls ? 150.w : null,
                height: ls ? null : 400.h,
                decoration: ls
                    ? null
                    : BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7)
                          ])),
                padding: ls ? null : EdgeInsets.fromLTRB(40.w, 0, 40.w, 0),
                child: Column(
                    mainAxisAlignment:
                        ls ? MainAxisAlignment.center : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: textStyle(ls ? 15 : 60)),
                      sb(height: 5.h),
                      _voiceButton(name),
                      sb(height: 10.h),
                      Text(info, style: textStyle(ls ? 8 : 20)),
                      sb(height: ls ? 0 : 20.h),
                      ls ? sb() : _roleAvatars(),
                      sb(height: ls ? 0 : 50.h)
                    ])))
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Background(),
      Container(color: Colors.black45),
      PageView.builder(
          itemCount: roleList.length,
          controller: _pageController,
          itemBuilder: (_, index) {
            return _pageItem(roleList[index]);
          })
    ]);
  }
}
