import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ovcapp/assets/ovcicons.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';

class LogHours extends StatefulWidget {
  LogHours({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;
  @override
  _LogHoursState createState() => _LogHoursState();
  static int getTotal(){
    return _LogHoursState._total;
  }
}

class _LogHoursState extends State<LogHours> with SingleTickerProviderStateMixin {
  static int _counter = 0;
  static int _starter = 0;
  static int _total = _counter + _starter;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _total = widget.volunteer.totalVolunteerHours(widget.volunteer);
  }

  String hourOrHours() {
    String returning = "";
    if(_total == 1){
      returning = "hour";
    }
    if(_total != 1){
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


  _incrementTotal() {
    setState(() {
      _total += _starter;
      if(_starter !=0)
        {
          DateTime now = new DateTime.now();
          Log today = new Log(now.toString(), _starter, widget.volunteer);
          print(widget.volunteer.getName() + " logged " + _starter.toString() + " "+ hourOrHours() + " volunteering on " + today.getFormalDate() + " @ " + Log.getPST(today));
        }
      _starter = 0;

    });

  }

  int itemCount(){
    int returning = 0;
    if(widget.volunteer.getVolunteerLog(widget.volunteer).length > 3)
      {
        returning = widget.volunteer.getVolunteerLog(widget.volunteer).length;
      }
    if(widget.volunteer.getVolunteerLog(widget.volunteer).length <= 3)
      {
        returning = 3;
      }
    return returning;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: CustomTheme.getLight() ? Color(0xFFE0CB8F) : Colors.black,
        title: const Text('Log Hours', style: TextStyle(
          color: Colors.black,
            fontFamily: "BigShouldersDisplay",
            fontWeight: FontWeight.w500,
            fontSize: 25)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
                'Log the amount of hours in which you spent',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, fontFamily: "BarlowSemiCondensed")
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
            child: Text(
              'volunteering:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, fontFamily: "BarlowSemiCondensed"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: Color(0xFFE0CB8F),
                onPressed: _decrementStarter,
                tooltip: 'Decrement',
                child: Icon(Icons.arrow_drop_down, size: 40,), //Icons.
              ),
              Text(
                  '  ',
                  style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 60)
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: CustomTheme.getLight() ? Colors.black : Colors.white,),
                  borderRadius: BorderRadius.all(
                      Radius.circular(
                          15.0)
                  ),
                ),
                child: Text(
                    '  $_starter  ',
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
              child: TextButton(onPressed: _incrementTotal,
                  child: Text("Enter", style: TextStyle(fontSize: 32,
                      fontFamily: "BarlowSemiCondensed",
                      color: Color(0xFFE0CB8F)),))),
          ListView.builder(
              itemCount: widget.volunteer.getThreeLogEntries(widget.volunteer).length,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                  child: Card(
                    shadowColor: Colors.white,
                    child: ListTile(
                      onTap: () {Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditHoursEntry(log: widget.volunteer.getThreeLogEntries(widget.volunteer).elementAt(index), volunteer: widget.volunteer,)));},
                      title: Text(widget.volunteer.getThreeLogEntries(widget.volunteer).elementAt(index).toString() + " @ " + Log.getPST(widget.volunteer.getThreeLogEntries(widget.volunteer).elementAt(index)), style: TextStyle(fontSize: 20, fontFamily: "BarlowSemiCondensed"),),
                      subtitle: Text("Edit Hours", style: TextStyle(color: CustomTheme.getLight() ? Colors.black : Color(0xFFE0CB8F),),),
                      tileColor: CustomTheme.getLight() ? Colors.white : Colors.black,
                      leading: Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Color(0xFFE0CB8F),
                        size: 32,
                      ),
                    ),
                  ),
                );
              }
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(85.0, 0.0, 0.0, 0.0),
                child: Text(
                    'Total: $_total ' + hourOrHours() + ".",
                    style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 21)
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: TextButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllEntries(volunteer: widget.volunteer,)),
                    );
                  },
                      child: Text("View all entries", style: TextStyle(
                          fontSize: 21, fontFamily: "BarlowSemiCondensed", color: Color(
                          0xFFE0CB8F)),))),
            ],
          ),
        ],
      ),
    );
  }
}

class Log{
  String date = "";
  int hours = 0;
  Volunteer volunteer = new Volunteer("name", "email", "phone");
  static List<Log> logs = <Log>[];
  static List<Log> threeEntries = <Log>[];
  Log(String date, int hours, Volunteer volunteer)
  {
    this.date = date;
    this.hours = hours;
    this.volunteer = volunteer;
    int counter = 0;
    for(int i=0; i<logs.length; i++)
      {
        if(date == logs[i].getDate())
          {
            counter++;
          }
      }
    if(counter==0)
      {
        logs.add(this);
        volunteer.addHours(this);
      }
    if(volunteer.getThreeLogEntries(volunteer).length >= 3)
    {
      volunteer.getThreeLogEntries(volunteer).removeAt(0);
      volunteer.addEntries(this);
    }
    if(volunteer.getThreeLogEntries(volunteer).length < 3)
      {
        volunteer.addEntries(this);
      }

  }

  String getDate() {
    return date;
  }

  static String getPST(Log log){
    String mutable = log.getDate();
    String time = mutable.substring(11, 16);
    String returning = "";
    if(time.substring(0, 2) == "00")
      {
        returning = "12";
      }
    if(time.substring(0, 2) == "13")
    {
      returning = "1";
    }
    if(time.substring(0, 2) == "14")
    {
      returning = "2";
    }
    if(time.substring(0, 2) == "15")
    {
      returning = "3";
    }
    if(time.substring(0, 2) == "16")
    {
      returning = "4";
    }
    if(time.substring(0, 2) == "17")
    {
      returning = "5";
    }
    if(time.substring(0, 2) == "18")
    {
      returning = "6";
    }
    if(time.substring(0, 2) == "19")
    {
      returning = "7";
    }
    if(time.substring(0, 2) == "20")
    {
      returning = "8";
    }
    if(time.substring(0, 2) == "21")
    {
      returning = "9";
    }
    if(time.substring(0, 2) == "22")
    {
      returning = "10";
    }
    if(time.substring(0, 2) == "23")
    {
      returning = "11";
    }
    if(int.parse(time.substring(0, 2)) > 11)
    {
      if(int.parse(time.substring(0, 2)) == 12)
        {
          returning += time.substring(0, 2);
        }
        returning += time.substring(2) + "pm";

    }
    if(int.parse(time.substring(0, 2)) <= 11)
    {
      if(int.parse(time.substring(0, 2)) == 00)
      {
        returning += time.substring(2) + "am";
      }
      else{
        returning += time + "am";
      }
    }
    if(returning.substring(0, 1) == '0')
      {
        returning = returning.substring(1);
      }

    return returning;
  }

  String getFormalDate()
  {
    String mutable = getDate().substring(0, 10);
    String year = mutable.substring(0, 4);
    String month = mutable.substring(5, 7);
    String day = mutable.substring(8);
    String date = month + "-" + day + "-" + year;
    return date;
  }

  setHours(int newHours){
    hours = newHours;
  }

  String hourOrHours() {
    String returning = "";
    if(hours == 1){
      returning = " hour";
    }
    if(hours != 1){
      returning = " hours";
    }
    return returning;
  }

  int getHours(){
    return hours;
  }

  String toString(){
    String returning = "";
    String mutable = getDate().substring(0, 10);
    String year = mutable.substring(0, 4);
    String month = mutable.substring(5, 7);
    String day = mutable.substring(8);
    String date = month + "-" + day + "-" + year;
    if(logs.length == 0 || getHours() == 0)
    {
      returning = "No hours logged.";
    }
    if(logs.length >= 1 && getHours() != 0)
    {
      returning = "You logged " + getHours().toString() + hourOrHours() + ' on ' + date;
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
    if(_LogHoursState._total == 1){
      returning = "hour";
    }
    if(_LogHoursState._total != 1){
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
    );
  }
}

class EditHoursEntry extends StatefulWidget {
  const EditHoursEntry({Key? key, required this.log, required this.volunteer}) : super(key: key);
  final Log log;
  final Volunteer volunteer;
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

  _incrementTotal() {
    setState(() {
      print(widget.volunteer.getName() + " edited their logged " + _total.toString() + " "+hourOrHours() + " to " + (totalDupe).toString() + " "+hourOrHours() + " for " + widget.log.getFormalDate() + " @ " + Log.getPST(widget.log));
      _total = totalDupe;
      widget.log.setHours(_total);
      _LogHoursState.setTotal(_LogHoursState._total + _starter);
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


