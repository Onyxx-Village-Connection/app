import 'package:flutter/material.dart';
import 'package:ovcapp/widgets/auth/styleConstants.dart';
import './client_resources_screen.dart';
import './client_wishlist_screen.dart';
import './new_wishlist_item_screen.dart';
import './client_deliveries_screen.dart';
import './client_profile_screen.dart';
import '../../assets/ovcicons.dart';

class ClientHomeTabBarScreen extends StatefulWidget {
  const ClientHomeTabBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ClientHomeTabBarScreenState createState() => _ClientHomeTabBarScreenState();
}

class _ClientHomeTabBarScreenState extends State<ClientHomeTabBarScreen> {
  int _selectedIndex = 0;
  List<Map<String, Object>> _tabs = [];

  @override
  void initState() {
    _tabs = [
      {
        'tab': ClientDeliveriesScreen(),
        'label': 'Deliveries',
      },
      {
        'tab': ClientResourcesScreen(),
        'label': 'Resources',
      },
      {
        'tab': ClientWishlistScreen(),
        'label': 'Wishlist',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// actions: (_tabs[_selectedIndex]['label'] == 'Wishlist')
  //     ? <Widget>[
  //         IconButton(
  //           icon: const Icon(Icons.add),
  //           tooltip: 'Add a new wishlist item',
  //           onPressed: () async {
  //             Route route = MaterialPageRoute(
  //                 builder: (context) => NewWishlistItemScreen());
  //             var wishlistItem = await Navigator.push(context, route);
  //           },
  //         ),
  //       ]
  //     : []),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(_tabs[_selectedIndex]['label'] as String),
          actions: <Widget>[
            IconButton(
              icon: const Icon(OVCIcons.profileicon),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientProfileScreen()),
                );
              },
            ),
          ]),
      body: Center(
        child: _tabs[_selectedIndex]['tab'] as Widget,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Color(0xFFE0CB8F),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFFb68fe0),
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        selectedLabelStyle: TextStyle(fontSize: 12.0),
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.airport_shuttle),
            icon: Icon(Icons.airport_shuttle_outlined),
            backgroundColor: Color(0xFFE0CB8F),
            label: '${_tabs[0]['label']}',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.article),
            icon: Icon(Icons.article_outlined),
            backgroundColor: Color(0xFFE0CB8F),
            label: '${_tabs[1]['label']}',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.volunteer_activism),
            icon: Icon(Icons.volunteer_activism_outlined),
            label: '${_tabs[2]['label']}',
          ),
        ],
      ),
      floatingActionButton: (_tabs[_selectedIndex]['label'] == 'Wishlist')
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              tooltip: 'Add a new wishlist item',
              backgroundColor: widgetColor,
              onPressed: () async {
                Route route = MaterialPageRoute(
                    builder: (context) => NewWishlistItemScreen());
                await Navigator.push(context, route);
              },
            )
          : null,
    );
  }
}
