class Food {
  String name = "";
  String donerName = "";
  String address = "";
  int weight = 0;//.0
  bool requiresRefridgeration = false;
  int numOfBoxes = 0;
  int numOfMeals = 0;
  bool hasDairy = false;
  bool hasNuts = false;
  bool hasEggs = false;
  bool isGrocery = false;
  int width = 0;
  int height = 0;
  int depth = 0;

  Food(String name, String donerName, String address, int weight, bool requiresRefridgeration, int numOfBoxes, int numOfMeals, bool hasDairy, bool hasNuts, bool hasEggs, bool isGrocery, int width, int height, int depth)
  {
    this.name = name;
    this.donerName = donerName;
    this.address = address;
    this.weight = weight;
    this.requiresRefridgeration = requiresRefridgeration;
    this.numOfBoxes = numOfBoxes;
    this.hasNuts = hasNuts;
    this.hasEggs = hasEggs;
    this.hasDairy = hasDairy;
    this.depth = depth;
    this.height = height;
    this.width = width;
    this.isGrocery = isGrocery;
    this.numOfMeals = numOfMeals;
  }

  getName(){
    return name;
  }

  setName(String newName)
  {
    name = newName;
  }

  getDonerName(){
    return donerName;
  }

  setDonerName(String newDoner)
  {
    donerName = newDoner;
  }

  getAddress(){
    return address;
  }

  setAddress(String newAddress){
    address = newAddress;
  }

  getWeight(){
    return weight;
  }

  setWeight(int newWeight){
    weight = newWeight;
  }

  getRequirements(){
    return requiresRefridgeration;
  }

  setRequirements(bool newRequirements){
    requiresRefridgeration = newRequirements;
  }

  getNumOfBoxes(){
    return numOfBoxes;
  }

  getNumOfMeals(){
    return numOfMeals;
  }

  getIsGrocery(){
    return isGrocery;
  }

  getDimensions(){
    return 'Width: ' + width.toString() + ", Height: " + height.toString() + ', Depth: ' + depth.toString();
  }

  getAllergens(){
    return 'Dairy: ' + trueOrFalse(hasDairy) +", Eggs: "+trueOrFalse(hasEggs)+", Nuts: "+trueOrFalse(hasNuts);
  }

  setNumOfBoxes(int newNum){
    numOfBoxes = newNum;
  }

  String trueOrFalse(bool theBoolean){
    String returning = "No";
    if(theBoolean){
      returning = "Yes";
    }
    return returning;
  }
}
