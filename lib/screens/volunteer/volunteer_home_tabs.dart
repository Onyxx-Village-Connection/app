import 'package:flutter/material.dart';

import '../../volunteerlog/volunteerlog.dart';
import '../../volunteer_pickup.dart';
import '../../volunteerlog/volunteer/volunteer.dart';
import '../authenticate/user_profile_info.dart';
import '../../assets/ovcicons.dart';

class VolunteerHomeTabBarScreen extends StatefulWidget {
  const VolunteerHomeTabBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  _VolunteerHomeTabBarScreenState createState() =>
      _VolunteerHomeTabBarScreenState();
}

class _VolunteerHomeTabBarScreenState extends State<VolunteerHomeTabBarScreen> {
  int _selectedIndex = 0;
  List<Map<String, Object>> _tabs = [];

  @override
  void initState() {
    _tabs = [
      {
        'tab': Pickups(),
        'label': 'Available Pickups',
      },
      {
        'tab': Delivery(),
        'label': 'Deliveries',
      },
      {
        'tab': VolunteerLog(volunteer: Volunteer('NAME', 'EMAIL', 'PHONE')),
        'label': 'My Log',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                    builder: (context) => UserProfileInfo(role: 'Volunteer')),
              );
            },
          ),
        ],
      ),
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
    );
  }
}
