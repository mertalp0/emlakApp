import 'package:emlak_app/sabitler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ekle.dart';
import 'ilanlar.dart';
import 'müsteriler.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp((const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Sabitler.primarySwatch),
      home: Scaffold(
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
        drawer: Drawer(
          backgroundColor: Sabitler.anaRenkshade50,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Sabitler.anaRenk,
                ),
                child: Center(
                  child: Text('AYDIN EMLAK', style: Sabitler.baslikFont),
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.people, color: Sabitler.iconRengi2),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Tüm Müşteriler',
                      style: Sabitler.yaziFont1,
                    ),
                  ],
                ),
                onTap: () {
                  // Sayfa 1'e gitmek için gerekli işlemler yapılır
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.house, color: Sabitler.iconRengi2),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Tüm Evler',
                      style:Sabitler.yaziFont1,
                    ),
                  ],
                ),
                onTap: () {
                  // Sayfa 2'ye gitmek için gerekli işlemler yapılır
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.notifications, color: Sabitler.iconRengi2),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Bildirimler',
                      style: Sabitler.yaziFont1,
                    ),
                  ],
                ),
                onTap: () {
                  // Sayfa 2'ye gitmek için gerekli işlemler yapılır
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.info, color: Sabitler.iconRengi2),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Hakkında',
                      style: Sabitler.yaziFont1,
                    ),
                  ],
                ),
                onTap: () {
                  // Sayfa 2'ye gitmek için gerekli işlemler yapılır
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.help, color: Sabitler.iconRengi2),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Yardım',
                      style: Sabitler.yaziFont1,
                    ),
                  ],
                ),
                onTap: () {
                  // Sayfa 1'e gitmek için gerekli işlemler yapılır
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Sabitler.iconRengi2,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Ayarlar',
                      style: Sabitler.yaziFont1,
                    ),
                  ],
                ),
                onTap: () {
                  // Sayfa 2'ye gitmek için gerekli işlemler yapılır
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Sabitler.iconRengi2,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Çıkış',
                      style: Sabitler.yaziFont1,
                    ),
                  ],
                ),
                onTap: () {
                  // Sayfa 2'ye gitmek için gerekli işlemler yapılır
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'AYDIN EMLAK',
            style: Sabitler.baslikFont2,
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Sabitler.anaRenk),
          child: BottomNavigationBar(
            selectedItemColor: Sabitler.selectedItemColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Müşteriler',
              ),

             
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  size: 27,
                ),
                label: 'Ekle',
              ),
               BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Evlerim',
              ),

              //New
            ],
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Musteriler(),
    Ekleme(),
    Ilanlar(),
  ];
}
