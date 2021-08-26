import 'package:ovcapp/volunteerlog/loghours/loghours.dart';
import 'package:ovcapp/volunteerlog/pickups/pickups.dart';
import 'package:ovcapp/volunteerlog/deliveries/deliveries.dart';

class Volunteer{
  String name = "";
  String email = "";
  String phone = "";
  static List<Pickups> volunteerPickups = <Pickups>[];
  static List<Deliveries> volunteerDeliveries = <Deliveries>[];
  static List<Log> volunteerLog = <Log>[];
  static List<Log> threeLogEntries = <Log>[];

  Volunteer(String name, String email, String phone){
    this.name = name;
    this.email = email;
    this.phone = phone;
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

  getVolunteerLog(){
    return volunteerLog;
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

  getThreeLogEntries(){
    return threeLogEntries;
  }

  addHours(Log log){
    volunteerLog.add(log);
  }

  @override
  String toString() {
    return "Volunteer: " + getName() + "\nPhone Number: " + getPhone() + "\nE-mail: " + getEmail();
  }
}