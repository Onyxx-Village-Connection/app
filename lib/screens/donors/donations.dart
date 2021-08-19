// model for a list of donations
import 'package:ovcapp/screens/donors/donation.dart';

class Donations {
  List<Donation> donations;

  Donations(this.donations);

  int length() => donations.length;

  void add(Donation donation) {
    donations.add(donation);
  }
}
