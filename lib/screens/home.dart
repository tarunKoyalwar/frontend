import 'package:flutter/material.dart';
import 'package:httpxfrontend/screens/gallery.dart';
import 'package:httpxfrontend/screens/tabular.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [const GalleryView(), const TabularView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ImageIcon(AssetImage('images/httpx.png'), size: 80),
        centerTitle: true,
      ),
      body: Row(children: [
        NavigationRail(
          groupAlignment: -1.0,
          labelType: NavigationRailLabelType.all,
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(icon: Icon(Icons.grid_view_rounded), label: Text('Gallery')),
            NavigationRailDestination(icon: Icon(Icons.table_rows_rounded), label: Text('Tabular')),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: _pages[_selectedIndex],
        ),
      ]),
    );
  }
}
