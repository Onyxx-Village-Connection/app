import 'package:flutter/material.dart';
import 'package:ovcapp/assets/ovcicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovcapp/profile_page.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';
import 'package:ovcapp/volunteer_pickup.dart';

class VolunteerBttmNavBar extends StatefulWidget {
  const VolunteerBttmNavBar({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;
  @override
  _VolunteerBttmNavBarState createState() => _VolunteerBttmNavBarState();
}

class _VolunteerBttmNavBarState extends State<VolunteerBttmNavBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    AppBar withoutMap(){
      return AppBar(
        leading: GestureDetector(
          onTap: () { Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );},
          child: Icon(
            OVCIcons.profileicon, size: 30.0, // add custom icons also
          ),
        ),
        title: Text('Onyxx Village Connection', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25, ),),
        centerTitle: true,
        elevation: 0.0,
      );
    }

    final tabs = [
      Pickups(),
      MaterialApp( //replace with deliveries page
        theme: CustomTheme.getLight() ? CustomTheme.getLightTheme() : CustomTheme.getDarkTheme(),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: withoutMap(),
            body: Container(
              color: Colors.white,
                child: Center(
                    child: Text('Deliveries'))
            ),
          ),
        ),
      ),
      VolunteerLog(volunteer: widget.volunteer,)
    ];
    return MaterialApp(
      theme: CustomTheme.getLight() ? CustomTheme.getLightTheme() : CustomTheme.getDarkTheme(),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: tabs[_currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            iconSize: 30.0,
            selectedLabelStyle: TextStyle(fontSize: 12.0),
            items: [
              BottomNavigationBarItem(
                icon: Icon(OVCIcons.pickupicon),//
                title: Text('Available Pickups', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w600, fontSize: 19)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.airport_shuttle_rounded),
                title: Text('Deliveries', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w600, fontSize: 19)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_rounded),
                title: Text('My Log', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w600, fontSize: 19) ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

