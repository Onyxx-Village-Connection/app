import 'package:ovcapp/volunteerlog/loghours/loghours.dart';
import 'package:ovcapp/volunteerlog/pickups/pickups.dart';
import 'package:ovcapp/volunteerlog/deliveries/deliveries.dart';

class Volunteer{
  String name = "";
  String email = "";
  String phone = "";
  int hours = 0;
  static List<Pickups> volunteerPickups = <Pickups>[];
  static List<Deliveries> volunteerDeliveries = <Deliveries>[];
  static List<Log> volunteerLog = <Log>[];
  static List<Log> threeLogEntries = <Log>[];
  static List<Volunteer> allVolunteers = <Volunteer>[];
  static List<Pending> allPendingPickups = <Pending>[];

  Volunteer(String name, String email, String phone){
    this.name = name;
    this.email = email;
    this.phone = phone;
    allVolunteers.add(this);
  }

  getName(){
    return name;
  }

  setName(String newName){
    name = newName;
  }

  getEmail(){
    return email;
  }

  setEmail(String newEmail){
    email = newEmail;
  }

  getPhone(){
    return phone;
  }

  setPhone(String newPhone){
    phone = newPhone;
  }
  
  static matchingCredentials(String theEmail){
    Volunteer returning =  new Volunteer("name", "email", "phone");
    int counter = 0;
    for(int i=0; i<allVolunteers.length; i++)
      {
        if(allVolunteers.elementAt(i).email == theEmail)
          {
            returning = allVolunteers.elementAt(i);
            counter++;
          }
      }
    if(counter == 0){
      returning = new Volunteer(theEmail, theEmail, "N/A");
    }
    return returning;
  }

  getVolunteerPickups(){
    return volunteerPickups;
  }

  getVolunteerDeliveries(){
    return volunteerDeliveries;
  }

  static sortVolunteerDeliveries(){
    volunteerDeliveries.sort((a, b) => a.getDate().compareTo(b.getDate()));
  }

  static sortVolunteerPickups(){
    volunteerPickups.sort((a, b) => a.getDate().compareTo(b.getDate()));
  }
  
  static returnVolunteersPickups(Volunteer volunteer){
    List<Pickups> listPickups = <Pickups>[];
    for(int i=0; i<volunteer.getVolunteerPickups().length; i++){
      if(volunteer.getVolunteerPickups().elementAt(i).volunteer == volunteer){
        listPickups.add(volunteer.getVolunteerPickups().elementAt(i));
      }
    }
    return listPickups;
  }

  static returnVolunteersDeliveries(Volunteer volunteer){
    List<Deliveries> listDeliveries = <Deliveries>[];
    for(int i=0; i<volunteer.getVolunteerDeliveries().length; i++){
      if(volunteer.getVolunteerDeliveries().elementAt(i).volunteer == volunteer){
        listDeliveries.add(volunteer.getVolunteerDeliveries().elementAt(i));
      }
    }
    return listDeliveries;
  }

  getVolunteerLog(Volunteer volunteerObj){
    List<Log> volLog = <Log>[];
    for(int i=0; i<volunteerLog.length; i++)
      {
        if(volunteerLog.elementAt(i).volunteer == volunteerObj)
          {
            volLog.add(volunteerLog.elementAt(i));
          }
      }
    return volLog;
  }
  
  totalVolunteerHours(Volunteer volunteerObj){
    int hours = 0;
    for(int i=0; i<volunteerLog.length; i++)
      {
        if(volunteerLog.elementAt(i).volunteer == volunteerObj)
          {
            hours += volunteerLog.elementAt(i).hours;
          }
      }
    return hours;
  }

  /*addPickup(Pickups pickup){
    int counter=0;
    for(int i=0; i<volunteerPickups.length; i++){
      if(volunteerPickups[i].item == pickup.item && volunteerPickups[i].date == pickup.date){
        counter++;
      }
    }
    if(counter == 0){
      volunteerPickups.add(pickup);
    }
  }*/

  addDelivery(Deliveries deliveries){
   // volunteerDeliveries.add(deliveries);
    int counter=0;
    for(int i=0; i<volunteerDeliveries.length; i++){
      if(volunteerDeliveries[i].item == deliveries.item && volunteerDeliveries[i].date == deliveries.date){
        counter++;
      }
    }
    if(counter == 0){
      volunteerDeliveries.add(deliveries);
    }
  }

  addEntries(Log log){
    threeLogEntries.add(log);
    if(threeLogEntries.length > 3)
    {
      threeLogEntries.removeAt(0);
    }
  }

  getThreeLogEntries(Volunteer volunteerObj){
    List<Log> threeLog = <Log>[];
    for(int i=0; i<threeLogEntries.length; i++){
      if(threeLogEntries[i].volunteer == volunteerObj){
        threeLog.add(threeLogEntries[i]);
      }
    }
    return threeLog;
  }

  addHours(Log log){
    volunteerLog.add(log);
  }
  
  addIntHours(int total){
    hours = total;
  }

  getHours(){
    return hours;
  }

  @override
  String toString() {
    return "Volunteer: " + getName() + "\nPhone Number: " + getPhone() + "\nE-mail: " + getEmail();
  }
}

class Pending {
  String one = "";
  String two = "";
  String user = "";
  Pending(String one, String two, String user){
    this.one = one;
    this.two = two;
    this.user = user;
  }

  returnPendingPickups(Volunteer volunteer){
    List<Pending> userPending = <Pending>[];
    for(int i=0; i<Volunteer.allPendingPickups.length; i++){
      if(Volunteer.allPendingPickups[i].user == volunteer.email){
        userPending.add(Volunteer.allPendingPickups[i]);
      }
    }
    return userPending;
  }
}
