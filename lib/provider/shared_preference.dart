import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  bool isLoggedIn = false;
  String id = "";
  String first_name = "";
  String last_name = "";
  String email = "";
  String password = "";
  String phone = "";
  String image_url = "";
  String address = "";
  String pan_card = "";
  String dob = "";
  String company_name = "";
  String description = "";
  String gst_number = "";

  static final SharedPreference _instance = SharedPreference.internal();
  factory SharedPreference() {
    return _instance;
  }
  SharedPreference.internal();

  Future<void> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getInt('isLoggedIn') as bool;
    isLoggedIn ? isLoggedIn = true : isLoggedIn = false;
  }

  // save seller details after login or singup
  Future<void> setSellerData(
      String id,
      first_name,
      last_name,
      email,
      phone,
      imageUrl,
      pan_card,
      dob,
      companyName,
      companyAddress,
      description,
      gstNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('first_name', first_name);
    await prefs.setString('last_name', last_name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('image_url', imageUrl);
    await prefs.setString('pan_card', pan_card);
    await prefs.setString('dob', dob);
    await prefs.setString('companyName', companyName);
    await prefs.setString('address', companyAddress);
    await prefs.setString('description', description);
    await prefs.setString('gst_number', gstNumber);
  }

  // retriving seller data
  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    first_name = prefs.getString('first_name') ?? '';
    last_name = prefs.getString('last_name') ?? '';
    email = prefs.getString('email') ?? '';
    password = prefs.getString('password') ?? '';
    phone = prefs.getString('phone') ?? '';
    image_url = prefs.getString('image_url') ?? '';
    address = prefs.getString('address') ?? '';
    pan_card = prefs.getString('pan_card') ?? '';
    dob = prefs.getString('dob') ?? '';
    company_name = prefs.getString('companyName') ?? '';
    description = prefs.getString('description') ?? '';
    gst_number = prefs.getString('gst_number') ?? '';
  }

  // get user email
  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? '';
  }

  // set seller login status
  Future<void> setIsLoggedIn(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', val);
  }

  // get seller login status
  Future<bool> getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  void resetAll() {
    id = "";
    first_name = "";
    last_name = "";
    email = "";
    password = "";
    phone = "";
    image_url = "";
    address = "";
    pan_card = "";
    dob = "";
    company_name = "";
    description = "";
    gst_number = "";
  }

  // after update the seller data
  // Future<void> setOnlyData(String first_name, last_name, gender, dob) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('first_name', first_name);
  //   await prefs.setString('last_name', last_name);
  //   await prefs.setString('phone', gender);
  //   await prefs.setString('u_dob', dob);
  // }
}
