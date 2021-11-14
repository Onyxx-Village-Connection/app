import 'package:ovcapp/volunteerlog/food/food.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';

class Pickups {
  Food item = new Food("name", "donerName", "address", 0.0, false, 0);
  String date = "3/15";
  int dateInt = 0;
  Volunteer volunteer = new Volunteer("", "", "");
  static List<Pickups> pickups = <Pickups>[];

  Pickups(Food item, String date, Volunteer volunteer){
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
    //volunteer.addPickup(this);
    pickups.add(this);
    organizeByDate();
    volunteer.sortVolunteerPickups();
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
