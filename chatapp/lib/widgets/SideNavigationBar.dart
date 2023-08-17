import 'dart:math';

import 'package:chatapp/services/contactfetch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:side_navigation/side_navigation.dart';

class SideNavigationBarComponent extends StatefulWidget {
  const SideNavigationBarComponent({super.key});
  State<SideNavigationBarComponent> createState() {
    return _SideNavigationBarState();
  }
}

class _SideNavigationBarState extends State<SideNavigationBarComponent> {
  List<Widget> views = const [
    Center(
      child: Text('Dashboard'),
    ),
    Center(
      child: Text('Settings'),
    ),
    Center(
      child: ContactScreen(),
    ),
    Center(
      child: Text('Profile'),
    ),
    Center(
      child: Text('Dashboard'),
    ),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          SideNavigationBar(
            selectedIndex: selectedIndex,
            initiallyExpanded: false,
            theme: SideNavigationBarTheme(
              backgroundColor: Colors.pinkAccent[100],
              togglerTheme: SideNavigationBarTogglerTheme.standard(),
              dividerTheme: const SideNavigationBarDividerTheme(
                  showMainDivider: true,
                  showFooterDivider: true,
                  showHeaderDivider: true,
                  mainDividerThickness: 2),
              itemTheme: SideNavigationBarItemTheme(
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.black,
                iconSize: 28,
              ),
            ),
            header: const SideNavigationBarHeader(
                image: CircleAvatar(
                  child: Icon(Icons.account_balance),
                  radius: 40,
                ),
                title: Text('name user'),
                subtitle: Text('mail/description')),
            footer: const SideNavigationBarFooter(
                label: Text('done by we are coders')),
            toggler: SideBarToggler(
                expandIcon: FontAwesomeIcons.sliders,
                shrinkIcon: FontAwesomeIcons.sliders,
                onToggle: () {
                  print('Toggle');
                }),
            items: const [
              SideNavigationBarItem(
                icon: Icons.dashboard,
                label: 'Dashboard',
              ),
              SideNavigationBarItem(
                icon: Icons.settings,
                label: 'Settings',
              ),
              SideNavigationBarItem(
                icon: Icons.contacts,
                label: 'Contacts',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'Profile',
              ),
              SideNavigationBarItem(
                icon: Icons.dashboard,
                label: 'Dashboard',
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}
