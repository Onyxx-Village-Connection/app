import 'package:ovcapp/volunteerlog/food/food.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';

class Pickups {
  Food item = new Food("name", "donerName", "", 0, false, 0, 0, false, false, false, false, 0, 0, 0);
  String date = "3/15";
  String dateInt = "";
  Volunteer volunteer = new Volunteer("", "", "");
  static List<Pickups> pickups = <Pickups>[];

  Pickups(Food item, String date, Volunteer volunteer){
    this.item = item;
    this.date = date;
    this.dateInt = date;
    this.volunteer = volunteer;
    pickups.add(this);
  }

  getName(){
    return item.getName();
  }

  getVolunteer(){
    return volunteer.toString();
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

  static getPickups(){
    return pickups;
  }

  static printList(){
    String returning = "";
    for(int i=pickups.length-1; i>=0; i--)
    {
      returning += "Food: " + pickups.elementAt(i).getName() + "\nDate: " + pickups.elementAt(i).getDate() + "\n\n";
    }
    return returning;
  }

  organizeByDate(){
    pickups.sort((a, b) => a.getDateInt().compareTo(b.getDateInt()));
  }

  setDate(String newDate){
    date = "Picked up on " + newDate;
  }
}
