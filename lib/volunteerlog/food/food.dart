class Food {
  String name = "";
  String donerName = "";
  String address = "";
  double weight = 0.0;
  bool requiresRefridgeration = false;
  int numOfBoxes = 0;

  Food(String name, String donerName, String address, double weight, bool requiresRefridgeration, int numOfBoxes)
  {
    this.name = name;
    this.donerName = donerName;
    this.address = address;
    this.weight = weight;
    this.requiresRefridgeration = requiresRefridgeration;
    this.numOfBoxes = numOfBoxes;
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

  setWeight(double newWeight){
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

  setNumOfBoxes(int newNum){
    numOfBoxes = newNum;
  }
}