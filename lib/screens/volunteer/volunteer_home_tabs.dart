import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './add_log_hours.dart';
import '../../widgets/auth/styleConstants.dart';
import './available_pickups.dart';
import './upcoming_deliveries.dart';
import './volunteer_log.dart';
import '../authenticate/user_profile_info.dart';
import '../../widgets/auth/helperFns.dart';
import '../../assets/ovcicons.dart';
import '../admin/AdminScreen.dart';

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
        'tab': AvailablePickupsScreen(),
        'label': 'Available Pickups',
      },
      {
        'tab': UpcomingDeliveriesScreen(),
        'label': 'My Deliveries',
      },
      {
        'tab': VolunteerLogScreen(),
        'label': 'My Log',
      },
      {
        'tab': AdminScreen(),
        'label': 'Admin',
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
    return FutureBuilder(
        future: isAdmin(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            bool admin = snapshot.data!;
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
                            builder: (context) =>
                                UserProfileInfo(role: 'Volunteer')),
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
                  if (admin)
                    BottomNavigationBarItem(
                      activeIcon: Icon(Icons.bar_chart),
                      icon: Icon(Icons.bar_chart_outlined),
                      label: '${_tabs[3]['label']}',
                    ),
                ],
              ),
              floatingActionButton: (_tabs[_selectedIndex]['label'] == 'My Log')
                  ? FloatingActionButton(
                      child: const Icon(Icons.add),
                      tooltip: 'Log new volunteer hours',
                      backgroundColor: widgetColor,
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => AddLogHoursScreen());
                        Navigator.push(context, route);
                      },
                    )
                  : null,
            );
          } else {
            return Text('');
          }
        });
  }
}
