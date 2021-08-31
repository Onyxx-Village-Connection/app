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

  sortVolunteerDeliveries(){
    volunteerDeliveries.sort((a, b) => a.getDateInt().compareTo(b.getDateInt()));
  }

  sortVolunteerPickups(){
    volunteerPickups.sort((a, b) => a.getDateInt().compareTo(b.getDateInt()));
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

  addPickup(Pickups pickup){
    volunteerPickups.add(pickup);
  }

  addDelivery(Deliveries deliveries){
    volunteerDeliveries.add(deliveries);
  }

  addEntries(Log log){
    threeLogEntries.add(log);
  }

  getThreeLogEntries(Volunteer volunteerObj){
    List<Log> three = <Log>[];
    for(int i=0; i<threeLogEntries.length; i++)
      {
        if(threeLogEntries.elementAt(i).volunteer == volunteerObj)
          {
            three.add(threeLogEntries.elementAt(i));
          }
      }
    return three;
  }

  addHours(Log log){
    volunteerLog.add(log);
  }

  @override
  String toString() {
    return "Volunteer: " + getName() + "\nPhone Number: " + getPhone() + "\nE-mail: " + getEmail();
  }
}
