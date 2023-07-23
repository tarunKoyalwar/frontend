import 'package:flutter/material.dart';
import 'package:httpxfrontend/screens/gallery.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ImageIcon(AssetImage('images/httpx.png'), size: 80),
        // title: Image.asset(
        //   'images/httpx.png',
        //   fit: BoxFit.scaleDown,
        // ),
        // title: const Text('Httpx Gallery'),
        centerTitle: true,
        // leading: const Padding(
        //   padding: EdgeInsets.fromLTRB(10, 14, 0, 14),
        //   child: Text(
        //     'Httpx',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //   ),
        // ),
      ),
      body: Row(children: [
        NavigationRail(
          groupAlignment: -1.0,
          labelType: NavigationRailLabelType.all,
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(icon: Icon(Icons.grid_view_rounded), label: Text('Gallery')),
            NavigationRailDestination(icon: Icon(Icons.table_rows_rounded), label: Text('Tabular')),
          ],
          selectedIndex: 0,
        ),
        const VerticalDivider(thickness: 1, width: 1),
        const Expanded(
          child: GalleryView(),
        ),
      ]),
    );
  }
}

class HomeScreenAlt extends StatelessWidget {
  const HomeScreenAlt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage('images/httpx.png'),
              size: 60,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("is fast and multipurpose toolkit"),
            )
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(children: [
        AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {},
            ),
          ],
          titleSpacing: 0,
        ),
        const Divider(thickness: 1, height: 1),
        const Expanded(child: Center(child: Text('Hello, world!'))),
      ]),
    );
  }
}
