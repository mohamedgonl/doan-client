import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:giapha/core/values/app_constants.dart';
import 'package:giapha/core/values/app_routes.dart';
import 'package:giapha/di/di.dart';
import 'package:giapha/features/access/presentation/pages/login_page.dart';
import 'package:giapha/features/access/presentation/pages/register_page.dart';
import 'package:lichviet_flutter_base/lichviet_flutter_base_import.dart';

// import 'package:giapha/features/chia_se/presentation/pages/chia_se_screen.dart';

import 'package:giapha/shared/themes/theme_data.dart';
import 'package:lichviet_flutter_base/core/core.dart';


// // test server
var configProduct = ApiConfig(env: 'env', baseUrl: 'https://api.lichviet.org/');
// // test server
// var configDev =
//     ApiConfig(env: 'env', baseUrl: 'http://test.api.lichviet.org/api/ft/');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     name: 'LichVietFree', options: DefaultFirebaseOptions.currentPlatform);
  await LichVietFlutterBase().setUpBase();
  await setupDiGiaPha();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 736),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ((context, child) {
        return MaterialApp(
          title: "GiaPha",
          theme: ThemeDataShared.themeMain,
          builder: EasyLoading.init(),
          initialRoute: AppRoutes.loginScreen,
          navigatorKey: AppConstants.navigationKey,
          routes: {
            AppRoutes.loginScreen: (context) =>  loginBuilder(context),
            AppRoutes.registerScreen: (context) =>  registerBuilder(context),
          },
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
      // return cayGiaPhaBuilder(context, GiaPha(id: 'id', tenGiaPha: 'tenGiaPha', tenNhanh: 'tenNhanh', diaChi: 'diaChi', moTa: 'moTa', idNguoiTao: 'idNguoiTao', thoiGianTao: new DateTime.now(), tenNguoiTao: 'tenNguoiTao', soDoi: 'soDoi', soThanhVien: 'soThanhVien'));
      return const LoginPage();
    })));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home Page',
            ),
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
