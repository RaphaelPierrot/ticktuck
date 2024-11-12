import 'package:flutter/material.dart';
import 'package:tiktuck/data/colors.dart';
import 'package:tiktuck/screen/add_video_screen.dart';
import 'package:tiktuck/screen/discover_screen.dart';
import 'package:tiktuck/screen/for_you_page.dart';
import 'package:tiktuck/screen/inbox_screen.dart';
import 'package:tiktuck/screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectindex = 0;
  static final List<Widget> _widgetOption = <Widget>[
    const FYpage(),
    const DiscoverScreeen(),
    const AddVideoScreen(),
    const InboxScreen(),
     const ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectindex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        
        items:  <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Discover",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("img/icons.png", height: 60
            ,),
            label: "",
          ),

          
          const BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline_sharp),
            label: "Inbox",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "profile",
          ),
        ],
        currentIndex: _selectindex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: _selectindex==0 ||_selectindex==1?backgroundColor:tipo,
        selectedItemColor: _selectindex==0 ||_selectindex==1?tipo:backgroundColor,
        unselectedItemColor: unselectedColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        
        onTap: _onItemTapped,
        elevation: 0,
        
      ),
      body: _widgetOption[_selectindex]
    );
  }
}