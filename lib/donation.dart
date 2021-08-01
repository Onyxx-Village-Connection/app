// model for one donation
class Donation {
  String name = "unknown";
  double weight = 0.0;
  int numBoxes = 0;
  int numMeals = 0;
  double width = 0.0;
  double height = 0.0;
  double depth = 0.0;
  bool hasDairy = false;
  bool hasNuts = false;
  bool hasEggs = false;
  bool reqFrige = false;
  bool isGrocery = false;
  DateTime pickupDateTime = DateTime.now();
  DateTime submitDateTime = DateTime.now();
}
