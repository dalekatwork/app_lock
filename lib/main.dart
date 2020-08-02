import 'dart:async';
import 'dart:convert';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:app_lock/entry.dart';
import 'package:app_lock/createTimerForm/steppers.dart';
import 'package:app_lock/page_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Locker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'App Locker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Entry> entry = <Entry>[];
  List<Application> apps = <Application>[];
  bool isListLoading = false;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  Future<void> loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void _createNewTimer() {
    Navigator.of(context)
        // ignore: always_specify_types
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const CreateTimerForm();
      // ignore: always_specify_types
    })).then((obj) {
      if (obj != null) {
        addItem(Entry(label: obj.label as String, timer: obj.timer as String));
      }
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
      body: isListLoading
          ? const Center(child: CircularProgressIndicator())
          : PageList(entry: entry),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTimer,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void addItem(Entry item) {
    // Insert an item into the top of our list, on index zero
    entry.insert(0, item);
    saveData();
  }

  Future<void> loadData() async {
    setState(() {
      isListLoading = true;
    });
    List<Application> apps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true);

    final List<String> listString = sharedPreferences.getStringList('entries');
    if (listString != null) {
      entry = listString
          .map((String item) =>
              Entry.fromMap(json.decode(item) as Map<String, dynamic>))
          .toList();

      setState(() {
        entry = entry;
        apps = apps;
        isListLoading = false;
      });
    }
  }

  void saveData() {
    final List<String> stringList =
        entry.map((Entry item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('entries', stringList);
    loadData();
  }
}
