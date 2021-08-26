import 'package:flutter/material.dart';
import 'package:ovcapp/assets/ovcicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';

class VolunteerBttmNavBar extends StatefulWidget {
  const VolunteerBttmNavBar({Key? key}) : super(key: key);
  @override
  _VolunteerBttmNavBarState createState() => _VolunteerBttmNavBarState();
}

class _VolunteerBttmNavBarState extends State<VolunteerBttmNavBar> {
  @override
  Widget build(BuildContext context) {
    AppBar appbar(){
      return AppBar(
        leading: GestureDetector(
          onTap: () {},//profile should be here
          child: Icon(
            OVCIcons.profileicon, size: 30.0,
          ),
        ),
        title: Text('Onyxx Village Connection', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25, ),),
        centerTitle: true,
        elevation: 0.0,
      );
    }
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        inactiveColor: CustomTheme.getLight() ? Colors.black : Color(0xFFE0CB8F),
        activeColor: Colors.white,
        backgroundColor: CustomTheme.getLight() ? Color(0xFFE0CB8F) : Colors.black,
        iconSize: 28.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(OVCIcons.pickupicon),//
            title: Text('Available Pickups', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w600, fontSize: 17)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airport_shuttle_rounded),
            title: Text('Deliveries', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w600, fontSize: 17)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            title: Text('My Log', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w600, fontSize: 17) ),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: MaterialApp( //replace with available pickups page
                  theme: CustomTheme.getLight() ? CustomTheme.getLightTheme() : CustomTheme.getDarkTheme(),
                  debugShowCheckedModeBanner: false,
                  home: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: appbar(),
                      body: Container(
                          child: Center(
                              child: Text('Available Pickups'))
                      ),
                    ),
                  ),
                ),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold( //replace with deliveries page
                child: MaterialApp(
                  theme: CustomTheme.getLight() ? CustomTheme.getLightTheme() : CustomTheme.getDarkTheme(),
                  debugShowCheckedModeBanner: false,
                  home: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: appbar(),
                      body: Container(
                          child: Center(
                              child: Text('Deliveries'))
                      ),
                    ),
                  ),
                ),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: VolunteerLog(),
              );
            });
          default: return CupertinoTabView(builder: (context) {
            return CupertinoPageScaffold(
              child: VolunteerLog(),
            );
          });
        }
      },
    );
  }
}

