import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuri_app/pages/home-page.dart';
import 'package:kuri_app/pages/settings.dart';

void main() async {

  Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuri App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  List pages = [HomePage(), SettingsPage()];

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kuri",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Good Morning, Zedan",
              style: TextStyle(fontSize: 15,),
            ),
          ],
        ),
        leading: Icon(Icons.dehaze, size: 25,),
      ),

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: navigateBottomBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Hello",
            activeIcon: Icon(Icons.home, color: Colors.green),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            activeIcon: Icon(Icons.settings, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
