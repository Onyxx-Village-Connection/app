import 'package:flutter/cupertino.dart';
import 'package:ovcapp/volunteerlog/food/food.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';

class Deliveries {
    Food item = new Food("name", "donerName", "address", 0.0, false, 0);
    String date = "Delivered on 3/15";
    int dateInt = 0;
    Volunteer volunteer = new Volunteer("name", "email", "phone");
    static List<Deliveries> deliveries = <Deliveries>[];

    Deliveries(Food item, String date, Volunteer volunteer, BuildContext context){
      this.item = item;
      this.date = date;
      this.volunteer = volunteer;
      String month = getDate().toString().substring(0, 2);
      int mo = int.parse(month);
      String days = getDate().toString().substring(3, 5);
      int day = int.parse(days);
      String year = getDate().toString().substring(6);
      int yr = int.parse(year);
      dateInt = mo + day + yr;
      deliveries.add(this);
      volunteer.addDelivery(this);
      organizeByDate();
      volunteer.sortVolunteerDeliveries();
    }

    getName(){
      return item.getName();
    }

    getDate(){
      return date;
    }

    getItem(){
      return item;
    }

    getDateInt(){
      return dateInt;
    }

    getDeliveries(){
      return deliveries;
    }

    static printList(){
      String returning = "";
      for(int i=deliveries.length-1; i>=0; i--)
        {
          returning += "Food: " + deliveries.elementAt(i).getName() + "\nDate: " + deliveries.elementAt(i).getDate() + "\n\n";
        }
      return returning;
    }

    organizeByDate(){
      deliveries.sort((a, b) => a.getDateInt().compareTo(b.getDateInt()));
    }

    setDate(String newDate){
      date = "Delivered on " + newDate;
    }
}