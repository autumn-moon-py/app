import 'package:app_new/page/home.dart';
import 'package:app_new/page/info.dart';
import 'package:app_new/page/post.dart';
import 'package:app_new/page/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'binding/binding.dart';
import 'controller/home_controller.dart';
import 'page/menu.dart';
import 'widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const MainPage()),
  GoRoute(
      path: '/post',
      builder: (context, state) => PostPage(
            name: state.uri.queryParameters['name']!,
          )),
  GoRoute(path: '/info', builder: (context, state) => const InfoPage()),
  GoRoute(path: '/role', builder: (context, state) => const RolePage()),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ScreenUtilInit(
        designSize: const Size(500, 888),
        builder: (context, child) => GetMaterialApp(
            initialBinding: MyBingding(),
            debugShowCheckedModeBanner: false,
            title: '异次元通讯-次元复苏',
            themeMode: ThemeMode.dark,
            home: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: '异次元通讯-次元复苏',
                themeMode: ThemeMode.dark,
                routerConfig: router)));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      PageView(
          scrollDirection: Axis.vertical,
          controller: homeController.homePageController,
          children: const [HomePage(), InfoPage(), RolePage()]),
      Obx(() => homeController.showMenu.value ? const MenuPage() : sb()),
      const Top()
    ]));
  }
}
