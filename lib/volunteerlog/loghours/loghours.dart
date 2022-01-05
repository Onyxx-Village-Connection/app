import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogHours extends StatefulWidget {
  LogHours({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;
  @override
  _LogHoursState createState() => _LogHoursState();
  static int getTotal() {
    return _LogHoursState._total;
  }

  static setTotal(int newTotal) {
    _LogHoursState._total = newTotal;
    _LogHoursState._starter = 0;
  }

  static int counterr = 0;
  static resetCounterr() {
    counterr = 0;
  }
}

String convert = "";
int numberOfEntries = 0;
String? use = FirebaseAuth.instance.currentUser!.email;

indexAsAString(int define) {
  String finalString = "";
  if (define > 10) {
    finalString = '0' + define.toString();
  } else {
    finalString = define.toString();
  }
  return finalString;
}

String getPST(String date) {
  String mutable = date;
  String time = mutable.substring(11, 16);
  String returning = "";
  if (time.substring(0, 2) == "00") {
    returning = "12";
  }
  if (time.substring(0, 2) == "13") {
    returning = "1";
  }
  if (time.substring(0, 2) == "14") {
    returning = "2";
  }
  if (time.substring(0, 2) == "15") {
    returning = "3";
  }
  if (time.substring(0, 2) == "16") {
    returning = "4";
  }
  if (time.substring(0, 2) == "17") {
    returning = "5";
  }
  if (time.substring(0, 2) == "18") {
    returning = "6";
  }
  if (time.substring(0, 2) == "19") {
    returning = "7";
  }
  if (time.substring(0, 2) == "20") {
    returning = "8";
  }
  if (time.substring(0, 2) == "21") {
    returning = "9";
  }
  if (time.substring(0, 2) == "22") {
    returning = "10";
  }
  if (time.substring(0, 2) == "23") {
    returning = "11";
  }
  if (int.parse(time.substring(0, 2)) > 11) {
    if (int.parse(time.substring(0, 2)) == 12) {
      returning += time.substring(0, 2);
    }
    returning += time.substring(2) + "pm";
  }
  if (int.parse(time.substring(0, 2)) <= 11) {
    if (int.parse(time.substring(0, 2)) == 00) {
      returning += time.substring(2) + "am";
    } else {
      returning += time + "am";
    }
  }
  if (returning.substring(0, 1) == '0') {
    returning = returning.substring(1);
  }

  return returning;
}

class _LogHoursState extends State<LogHours>
    with SingleTickerProviderStateMixin {
  static int _counter = 0;
  static int _starter = 0;
  static int _total = _counter + _starter;
  static CollectionReference hours =
      FirebaseFirestore.instance.collection("Volunteer Hours");
  static CollectionReference entries =
      FirebaseFirestore.instance.collection("Log Entries");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convert = use.toString() + keepTrack.length.toString();
    //_total = widget.volunteer.totalVolunteerHours(widget.volunteer);
    if (counting == 0) {
      counting++;
    }
  }

  String hourOrHours() {
    String returning = "";
    if (_total == 1) {
      returning = "hour";
    }
    if (_total != 1) {
      returning = "hours";
    }
    return returning;
  }

  static setTotal(int newTotal) {
    _total = newTotal;
  }

  _incrementStarter() {
    setState(() {
      _starter++;
    });
  }

  _decrementStarter() {
    setState(() {
      if (_starter > 0) {
        _starter--;
      }
    });
  }

  _incrementTotal() async {
    DateTime now = new DateTime.now();
    AllHoursList slayy = new AllHoursList(
        index: counter,
        date: now.toLocal().toString(),
        volunteer: widget.volunteer,
        one: _starter);
    //keepTrack.add(nuObj);
    await hours.doc(FirebaseAuth.instance.currentUser!.email).set({
      'user': widget.volunteer.getName(),
      'hoursEntered': _starter,
      'totalHours': _total + _starter,
      'editedHours': 0
    }).then((value) => print("Hours added"));
    await entries.add({
      'user': widget.volunteer.getName(),
      'hoursEntered': _starter,
      'totalHours': _total + _starter,
      'editedHours': 0,
      'date': now.toLocal().toString()
    });
    setState(() {
      _total += _starter;
      if (_starter != 0) {
        DateTime now = new DateTime.now();
        Log today = new Log(now.toString(), _starter, widget.volunteer);
        print(widget.volunteer.getName() +
            " logged " +
            _starter.toString() +
            " " +
            "hours" +
            " volunteering on " +
            today.getFormalDate() +
            " @ " +
            Log.getPST(today));
        print(hours.toString());
      }
      _starter = 0;
    });
    //keepTrack.remove(nuObj);
  }

  int itemCount() {
    int returning = 0;
    if (widget.volunteer.getVolunteerLog(widget.volunteer).length > 3) {
      returning = widget.volunteer.getVolunteerLog(widget.volunteer).length;
    }
    if (widget.volunteer.getVolunteerLog(widget.volunteer).length <= 3) {
      returning = 3;
    }
    return returning;
  }

  body(BuildContext context, Volunteer volunteer) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
          child: Text('Log the amount of hours in which you spent',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  fontFamily: "BarlowSemiCondensed")),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
          child: Text(
            'volunteering:',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 23,
                fontFamily: "BarlowSemiCondensed"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Color(0xFFE0CB8F),
              onPressed: _decrementStarter,
              tooltip: 'Decrement',
              child: Icon(
                Icons.arrow_drop_down,
                size: 40,
              ), //Icons.
            ),
            Text('  ',
                style:
                    TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 60)),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: CustomTheme.getLight() ? Colors.black : Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Text('  $_starter  ',
                  style: TextStyle(
                      fontFamily: "BarlowSemiCondensed", fontSize: 70)),
            ),
            Text('  ',
                style:
                    TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 60)),
            FloatingActionButton(
              backgroundColor: Color(0xFFE0CB8F),
              onPressed: _incrementStarter,
              tooltip: 'Increment',
              child: Icon(
                Icons.arrow_drop_up,
                size: 40,
              ),
            ),
          ],
        ),
        Container(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: TextButton(
                onPressed: _incrementTotal,
                child: Text(
                  "Enter",
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: "BarlowSemiCondensed",
                      color: Color(0xFFE0CB8F)),
                ))),
        ListView.builder(
            itemCount: volunteer.getThreeLogEntries(volunteer).length,
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                child: Card(
                  shadowColor: Colors.white,
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      volunteer
                              .getThreeLogEntries(volunteer)
                              .elementAt(index)
                              .toString() +
                          " @ " +
                          getPST(volunteer
                              .getThreeLogEntries(volunteer)
                              .elementAt(index)
                              .date),
                      style: TextStyle(
                          fontSize: 20, fontFamily: "BarlowSemiCondensed"),
                    ),
                    tileColor:
                        CustomTheme.getLight() ? Colors.white : Colors.black,
                    leading: Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Color(0xFFE0CB8F),
                      size: 32,
                    ),
                  ),
                ),
              );
            }),
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(85.0, 0.0, 0.0, 0.0),
              child: Text('Total: $_total ' + "hours" + ".",
                  style: TextStyle(
                      fontFamily: "BarlowSemiCondensed", fontSize: 21)),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllEntries(
                                  volunteer: widget.volunteer,
                                )),
                      );
                    },
                    child: Text(
                      "View all entries",
                      style: TextStyle(
                          fontSize: 21,
                          fontFamily: "BarlowSemiCondensed",
                          color: Color(0xFFE0CB8F)),
                    ))),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
        appBar: AppBar(
          backgroundColor:
              CustomTheme.getLight() ? Color(0xFFE0CB8F) : Colors.black,
          title: const Text('Log Hours',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "BigShouldersDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 25)),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          children: [whichTwo(context)],
        ));
  }

  final _firestore = FirebaseFirestore.instance;

  whichTwo(
    BuildContext context,
  ) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore.collection('Volunteer Hours').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Color(0xFFE0CB8F),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),
          );
        }
        final orders = snapshot.data!.docs.reversed;

        for (var order in orders) {
          if (order.id == widget.volunteer.name && LogHours.counterr == 0) {
            VolunteerLog.totalHrs = order.get('totalHours');
            LogHours.setTotal(order.get('totalHours'));
            widget.volunteer.addIntHours(order.get('totalHours'));
            LogHours.counterr++;
          }
        }
        return body(context, widget.volunteer);
      },
    );
  }
}

int counting = 0;

class Log {
  String date = "";
  int hours = 0;
  Volunteer volunteer = new Volunteer("name", "email", "phone");
  static List<Log> logs = <Log>[];
  static List<Log> threeEntries = <Log>[];
  Log(String date, int hours, Volunteer volunteer) {
    this.date = date;
    this.hours = hours;
    this.volunteer = volunteer;
    int counter = 0;
    for (int i = 0; i < logs.length; i++) {
      if (date == logs[i].getDate()) {
        counter++;
      }
    }
    if (counter == 0) {
      logs.add(this);
      volunteer.addHours(this);
    }
    if (volunteer.getThreeLogEntries(volunteer).length >= 2) {
      volunteer.getThreeLogEntries(volunteer).removeAt(0);
      volunteer.addEntries(this);
    }
    if (volunteer.getThreeLogEntries(volunteer).length < 2) {
      volunteer.addEntries(this);
    }
  }

  String getDate() {
    return date;
  }

  static String getPST(Log log) {
    String mutable = log.getDate();
    String time = mutable.substring(11, 16);
    String returning = "";
    if (time.substring(0, 2) == "00") {
      returning = "12";
    }
    if (time.substring(0, 2) == "13") {
      returning = "1";
    }
    if (time.substring(0, 2) == "14") {
      returning = "2";
    }
    if (time.substring(0, 2) == "15") {
      returning = "3";
    }
    if (time.substring(0, 2) == "16") {
      returning = "4";
    }
    if (time.substring(0, 2) == "17") {
      returning = "5";
    }
    if (time.substring(0, 2) == "18") {
      returning = "6";
    }
    if (time.substring(0, 2) == "19") {
      returning = "7";
    }
    if (time.substring(0, 2) == "20") {
      returning = "8";
    }
    if (time.substring(0, 2) == "21") {
      returning = "9";
    }
    if (time.substring(0, 2) == "22") {
      returning = "10";
    }
    if (time.substring(0, 2) == "23") {
      returning = "11";
    }
    if (int.parse(time.substring(0, 2)) > 11) {
      if (int.parse(time.substring(0, 2)) == 12) {
        returning += time.substring(0, 2);
      }
      returning += time.substring(2) + "pm";
    }
    if (int.parse(time.substring(0, 2)) <= 11) {
      if (int.parse(time.substring(0, 2)) == 00) {
        returning += time.substring(2) + "am";
      } else {
        returning += time + "am";
      }
    }
    if (returning.substring(0, 1) == '0') {
      returning = returning.substring(1);
    }

    return returning;
  }

  String getFormalDate() {
    String mutable = getDate().substring(0, 10);
    String year = mutable.substring(0, 4);
    String month = mutable.substring(5, 7);
    String day = mutable.substring(8);
    String date = month + "-" + day + "-" + year;
    return date;
  }

  setHours(int newHours) {
    hours = newHours;
  }

  String hourOrHours() {
    String returning = "";
    if (hours == 1) {
      returning = " hour";
    }
    if (hours != 1) {
      returning = " hours";
    }
    return returning;
  }

  int getHours() {
    return hours;
  }

  String toString() {
    String returning = "";
    String mutable = getDate().substring(0, 10);
    String year = mutable.substring(0, 4);
    String month = mutable.substring(5, 7);
    String day = mutable.substring(8);
    String date = month + "-" + day + "-" + year;
    if (logs.length == 0 || getHours() == 0) {
      returning = "No hours logged.";
    }
    if (logs.length >= 1 && getHours() != 0) {
      returning =
          "You logged " + getHours().toString() + hourOrHours() + ' on ' + date;
    }
    return returning;
  }
}

class AllEntries extends StatefulWidget {
  const AllEntries({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;

  @override
  _AllEntriesState createState() => _AllEntriesState();
}

class _AllEntriesState extends State<AllEntries> {
  String hourOrHours() {
    String returning = "";
    if (_LogHoursState._total == 1) {
      returning = "hour";
    }
    if (_LogHoursState._total != 1) {
      returning = "hours";
    }
    return returning;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFE0CB8F),
        title: const Text('Log Entries',
            style: TextStyle(
                color: Colors.black,
                fontFamily: "BigShouldersDisplay",
                fontWeight: FontWeight.w500,
                fontSize: 25)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                child: Text(
                  "Total: ",
                  style: TextStyle(
                      fontFamily: "BarlowSemiCondensed",
                      fontSize: 25,
                      color: Color(0xFFE0CB8F)), //
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                child: Text(
                  _LogHoursState._total.toString() + hourOrHours(),
                  style: TextStyle(
                      fontFamily: "BarlowSemiCondensed",
                      fontSize: 25), //, color: Color(0xFFE0CB8F)
                ),
              ),
            ],
          ),
          AllHoursStream(
            volunteer: widget.volunteer,
          ),
        ],
      ),
    );
    /*Scaffold(
      backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFE0CB8F),
        title: const Text('Log Entries', style: TextStyle(color: Colors.black, fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                  child: Text(
                    "Total: ",
                    style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 25, color: Color(0xFFE0CB8F)),//
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                  child: Text(
                    _LogHoursState._total.toString() + hourOrHours(),
                    style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 25),//, color: Color(0xFFE0CB8F)
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.volunteer.getVolunteerLog(widget.volunteer).length,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        shadowColor: Color(0xFFE0CB8F),
                        child: ListTile(
                          onTap: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditHoursEntry(log: widget.volunteer.getVolunteerLog(widget.volunteer).elementAt(index), volunteer: widget.volunteer,)),);},
                          title: Text(widget.volunteer.getVolunteerLog(widget.volunteer).elementAt(index).toString() + " @ " + Log.getPST(widget.volunteer.getVolunteerLog(widget.volunteer).elementAt(index)), style: TextStyle(fontSize: 21, fontFamily: "BarlowSemiCondensed"),),
                          subtitle: Text("Edit Hours", style: TextStyle(color: CustomTheme.getLight() ? Colors.grey : Color(0xFFE0CB8F)),),
                          tileColor: CustomTheme.getLight() ? Colors.white : Colors.black,
                          leading: Icon(
                            Icons.account_balance_wallet_rounded,
                            color: Color(0xFFE0CB8F),
                            size: 33,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}

int counter = 0;
final _firestore = FirebaseFirestore.instance;
List<AllHoursList> keepTrack = [];

bool isntSameObj() {
  bool isntSame = true;
  for (int i = 0; i < keepTrack.length - 1; i++) {
    for (int j = i + 1; j < keepTrack.length; j++) {
      if (keepTrack[i].date == keepTrack[j].date) {
        isntSame = false;
      }
    }
  }
  return isntSame;
}

class AllHoursStream extends StatelessWidget {
  AllHoursStream({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;

  @override
  Widget build(BuildContext context) {
    counter = 0;
    return FutureBuilder<QuerySnapshot>(
      future: _firestore.collection('Log Entries').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Color(0xFFE0CB8F),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFE0CB8F)),
                  ),
                ],
              ),
            ),
          );
        }
        final orders = snapshot.data!.docs.reversed;
        List<AllHoursList> orderList = [];
        counter = 0;
        for (var order in orders) {
          final hours = order.get('hoursEntered');
          final date = order.get('date');
          final user = order.get('user');

          final orderIndividuals = AllHoursList(
            index: counter,
            volunteer: volunteer,
            one: hours,
            date: date,
          );

          if (user == volunteer.email) {
            //Log newObj = new Log(date, hours, volunteer);
            orderList.add(orderIndividuals);
            counter++;
            if (isntSameObj()) {
              keepTrack.add(orderIndividuals);
            }
            //Volunteer.volunteerPickups.add(newObj);
          }
          /*else{
            Volunteer.allPendingPickups.add(Pending(name, date, user));
          }*/
          //findSameObj();
          orderList.sort((b, a) => a.date.compareTo(b.date));
        }

        numberOfEntries = counter;
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: orderList,
          ),
        );
      },
    );
  }
}

class AllHoursList extends StatelessWidget {
  AllHoursList({
    Key? key,
    required this.index,
    required this.date,
    required this.volunteer,
    required this.one,
  }) : super(key: key);

  final int index;
  final String date;
  final Volunteer volunteer;
  final int one;
  String hourOrHours() {
    String returning = "";
    if (one == 1) {
      returning = " hour";
    }
    if (one != 1) {
      returning = " hours";
    }
    return returning;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        shadowColor: Color(0xFFE0CB8F),
        child: ListTile(
          //Navigator.push(context, MaterialPageRoute(builder: (context) => EditHoursEntry(log: volunteer.getVolunteerLog(volunteer).elementAt(index), volunteer: volunteer, idx: index,)),);
          onTap: () {},
          title: Text(
            "You logged " +
                one.toString() +
                hourOrHours() +
                " on " +
                date.substring(5, 7) +
                "-" +
                date.substring(8, 10) +
                "-" +
                date.substring(0, 4) +
                " @ " +
                getPST(date),
            style: TextStyle(fontSize: 21, fontFamily: "BarlowSemiCondensed"),
          ),
          //subtitle: Text("Edit Hours ", style: TextStyle(color: CustomTheme.getLight() ? Colors.black : Color(0xFFE0CB8F)),),
          tileColor: CustomTheme.getLight() ? Colors.white : Colors.black,
          leading: Icon(
            Icons.account_balance_wallet_rounded,
            color: Color(0xFFE0CB8F),
            size: 33,
          ),
        ),
      ),
    );
  }
}

/*
class EditHoursEntry extends StatefulWidget {
  const EditHoursEntry({Key? key, required this.log, required this.idx, required this.volunteer}) : super(key: key);
  final Log log;
  final Volunteer volunteer;
  final int idx;
  @override
  _EditHoursEntryState createState() => _EditHoursEntryState();
}

class _EditHoursEntryState extends State<EditHoursEntry> {
  int _starter = 0;
  int _total = 0;
  int totalDupe = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _total = widget.log.getHours();
    totalDupe = widget.log.getHours();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _incrementStarter() {
    setState(() {
      totalDupe++;
      _starter++;
    });

  }

  String hourOrHours() {
    String returning = "";
    if(_total == 1){
      returning = "hour.";
    }
    if(_total != 1){
      returning = "hours.";
    }
    return returning;
  }

  _decrementStarter() {
    setState(() {
      if(totalDupe > 0)
      {
        totalDupe--;
        _starter--;
      }
    });

  }

  _incrementTotal() async{
    DateTime now = new DateTime.now();
    //await _LogHoursState.hours.add({'user':widget.volunteer.getName(), 'hoursEntered':_total, 'totalHours':totalDupe, 'editedHours':totalDupe-_total}).then((value) => print("Hours added"))
    await _LogHoursState.hours.doc(FirebaseAuth.instance.currentUser!.email).set({'user':widget.volunteer.getName(), 'hoursEntered':_total, 'totalHours':_LogHoursState._total + _starter, 'editedHours':totalDupe-_total}).then((value) => print("Hours added"));//__BodyState
    await _LogHoursState.entries.doc(use.toString()+indexAsAString(widget.idx)).set({'user':widget.volunteer.getName(), 'hoursEntered':_total, 'totalHours':_LogHoursState._total + _starter, 'editedHours':totalDupe-_total, 'date':now.toLocal().toString()});
    if(widget.idx>index){
      await _LogHoursState.entries.doc(use.toString()+indexAsAString(index)).set({'user':widget.volunteer.getName(), 'hoursEntered':keepTrack.elementAt(keepTrack.length-1).one, 'totalHours':_LogHoursState._total + _starter, 'editedHours': 0, 'date':now.toLocal().toString()});//keepTrack.elementAt(keepTrack.length-1).date
    }
    setState(() {
      print(widget.volunteer.getName() + " edited their logged " + _total.toString() + " "+hourOrHours() + " to " + (totalDupe).toString() + " "+hourOrHours() + " for " + widget.log.getFormalDate() + " @ " + Log.getPST(widget.log));
      _total = totalDupe;
      widget.log.setHours(_total);
      //_Body.setTotal(__BodyState._total + _starter);//
      _LogHoursState._total += _starter;//__BodyState
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: CustomTheme.getLight() ? Color(0xFFE0CB8F) : Colors.black,
        title: const Text('Edit Hours', style: TextStyle(color: Colors.black, fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                    'Edit your volunteer hours on ' + widget.log.getFormalDate() + ",", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, fontFamily: "BarlowSemiCondensed")
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                  child: Text("entered at " + Log.getPST(widget.log),style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, fontFamily: "BarlowSemiCondensed") )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    backgroundColor: Color(0xFFE0CB8F),
                    onPressed: _decrementStarter,
                    tooltip: 'Decrement',
                    child: Icon(Icons.arrow_drop_down, size: 40,),//Icons.
                  ),
                  Text(
                      '  ',
                      style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 60)
                  ),
                  Container(
                    //padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomTheme.getLight() ? Colors.black : Colors.white,),
                      borderRadius: BorderRadius.all(
                          Radius.circular(15.0) //
                      ),
                    ),
                    child: Text(
                        '  $totalDupe  ',
                        style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 70)
                    ),
                  ),
                  Text(
                      '  ',
                      style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 60)
                  ),
                  FloatingActionButton(
                    backgroundColor: Color(0xFFE0CB8F),
                    onPressed: _incrementStarter,
                    tooltip: 'Increment',
                    child: Icon(Icons.arrow_drop_up, size: 40,),
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: TextButton(onPressed: _incrementTotal, child: Text("Enter", style: TextStyle(fontSize: 32,
                      fontFamily: "BarlowSemiCondensed",
                      color: Color(0xFFE0CB8F)),))),

              Container(
                child: Text(
                    'Total: $_total ' + hourOrHours(),
                    style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 23)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


*/

