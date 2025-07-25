import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tools/common.dart';
import 'package:flutter_tools/tools_models.dart';
import 'package:flutter_tools/ui/splash_screens.dart';
import 'package:get/get.dart';
import 'package:riderman/views/companies_page.dart';
import 'package:riderman/views/main_page.dart';
import 'package:riderman/views/welcome_page.dart';

import '../controllers/auth_controller.dart';
import '../shared/config.dart';
import '../shared/constants.dart';
import 'controllers/main_controller.dart';
import 'data/db_manager.dart';

// todo: make sure if logged in user is a rider and id card expires,
/// action are only in view mode, and set new Id card is the only action that can be performed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: <SystemUiOverlay>[SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await initStorage();
  // await storage.erase();
//   await DBManager.initiate();
  // await DBManager.dbHelper.deleteCurrentDatabase();
  await DBManager.initiate();
  runApp(MyApp());
}

/// NOTE: when company is not active, they can view available data,
/// and riders can make payment to them, but owners can not withdraw until
/// issue is sorted out. This is to allow business to keep running.

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController());
  final mainController = Get.put(MainController());

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // if (currentUser.isRider &&
    //     currentUser.isIdCardInvalid) {
    //   Get.to(() => IdentificationPage(property: item));
    //   return;
    // }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: isInDakTheme ? Themes.darkTheme : Themes.lightTheme,
      // darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      getPages: routes,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SimpleLogoTextSplashscreen(
          //appName: Constants.APP_NAME,
          // splashDuration: 16,
          backgroundColor: kPurpleColor,
          logoSize: 240,
          imageUrl: 'assets/images/logo-for-splash.png',
          loadingWidgetType: LoadingWidgetType.wave,
          loadingColor: Colors.white,
          // nextPage: VerificationPage(nextPage: '', phoneNumber: '233265336549'),
          nextPage: isUserOnboarded
              ? isCompanySet
                  ? MainPage()
                  : CompaniesPage()
              : WelcomePage(),
          // nextPage: MyHomePage(title: 'MyHomePage'),
          // toRunWhilstLoading: () => print('INSIDE YES DONE'),
          // toRunWhilstLoading: () async => await Future.delayed(
          //         const Duration(seconds: 10), () => print('INSIDE YES DONE'))
          //     .whenComplete(() => print('YES DONE======')),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
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
