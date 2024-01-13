import 'package:flutter/material.dart';
import 'package:harvest_delivery/farmerSide/views/home_screen.dart';
import 'package:harvest_delivery/farmerSide/views/item_screen.dart';
import 'package:harvest_delivery/farmerSide/views/order_screen.dart';
import 'package:harvest_delivery/farmerSide/views/settings_screen.dart';


class FarmerMainPage extends StatefulWidget {
  const FarmerMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
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
