import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/widgets/home_screen/bar_icon.dart';
import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/screens/contacts_bar.dart';
import 'package:ripple/screens/settings_tab.dart';
import 'package:ripple/screens/profile_tab.dart';
import 'package:ripple/screens/chat_tab.dart';
import 'package:ripple/generated/l10n.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
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
    final settings = context.watch<SettingsProvider>();
    final s = S.of(context);

    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: [
            const ContactsBar(),
            const ProfileTab(),
            const ChatTab(),
            const SettingsTab(),
          ],
        ),
        bottomNavigationBar: TabBar(
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          indicator: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            gradient: RadialGradient(
              colors: [settings.accentColor, Colors.transparent],
              stops: [0.5, 1.0],
            ),
          ),

          controller: _tabController,
          tabs: [
            Tab(
              child: BarIcon(title: s.bar_contacts, icon: Icon(Icons.people)),
            ),
            Tab(
              child: BarIcon(title: s.bar_profile, icon: Icon(Icons.person)),
            ),
            Tab(
              child: BarIcon(
                title: s.bar_chats,
                icon: Icon(Icons.wechat_outlined),
              ),
            ),
            Tab(
              child: BarIcon(title: s.bar_settings, icon: Icon(Icons.settings)),
            ),
          ],
        ),
      ),
    );
  }
}
