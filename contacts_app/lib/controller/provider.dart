import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ContactAppProvider with ChangeNotifier {
  CountryCode selectedCountry = CountryCode.fromDialCode("+91");

  // UserCredential? userCredential;

  void onCountryChanged(CountryCode value) {
    selectedCountry = value;
    notifyListeners();
  }
}
