import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'item_screen.dart';
import 'order_screen.dart';
import 'settings_screen.dart';

class FarmerMainPage extends StatefulWidget {
  const FarmerMainPage({Key? key}) : super(key: key);


  @override
  State<FarmerMainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FarmerMainPage> {
  int _selectedIndex =
      0; // Index of the currently selected bottom navigation item

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ItemScreen(),
    OrderScreen(), // Assuming this is the fourth screen
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 159, 33),

      ),
      body: Center(
        child: _widgetOptions
            .elementAt(_selectedIndex), // Display the selected screen
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all_outlined),
            label: 'Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
