import 'package:flutter/material.dart';
import 'package:ovcapp/donations.dart';

class DonationsProvider extends InheritedWidget {
  final Donations donations;

  DonationsProvider({Key? key, required Widget child, required this.donations})
      : super(key: key, child: child);

  static Donations of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DonationsProvider>();
    // todo: handle null properly
    return (provider != null) ? provider.donations : Donations([]);
  }

  @override
  bool updateShouldNotify(DonationsProvider oldWidget) =>
      // todo: detect change in better way
      donations != oldWidget.donations;
}
