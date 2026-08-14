import 'package:flutter/material.dart';
import 'package:messager/screens/chat_tab.dart';

import 'package:messager/widgets/bar_icon.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: const [
            Center(child: Text("Contacts")),
            Center(child: Text("Profile")),
            ChatTab(),
            Center(child: Text("Settings")),
          ],
        ),
        bottomNavigationBar: TabBar(
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          indicator: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            gradient: RadialGradient(
              colors: [Color(0xFF7442C8), Colors.transparent],
              stops: [0.5, 1.0],
            ),
          ),
          controller: _tabController,
          tabs: const [
            Tab(
              child: BarIcon(
                title: "Contacts",
                icon: Icon(Icons.people),
              ),
            ),
            Tab(
              child: BarIcon(
                title: "Profile",
                icon: Icon(Icons.person),
              ),
            ),
            Tab(
              child: BarIcon(
                title: "Chats",
                icon: Icon(Icons.wechat_outlined),
              ),
            ),
            Tab(
              child: BarIcon(
                title: "Settings",
                icon: Icon(Icons.settings),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
