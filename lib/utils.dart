// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import './color.dart';
import './fonts.dart';

class Utils {
  List<String> states = [
    "Alaska",
    "Alabama",
    "Arkansas",
    "American Samoa",
    "Arizona",
    "California",
    "Colorado",
    "Connecticut",
    "District of Columbia",
    "Delaware",
    "Florida",
    "Georgia",
    "Guam",
    "Hawaii",
    "Iowa",
    "Idaho",
    "Illinois",
    "Indiana",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Massachusetts",
    "Maryland",
    "Maine",
    "Michigan",
    "Minnesota",
    "Missouri",
    "Mississippi",
    "Montana",
    "North Carolina",
    "North Dakota",
    "Nebraska",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "Nevada",
    "New York",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Puerto Rico",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Virginia",
    "Virgin Islands",
    "Vermont",
    "Washington",
    "Wisconsin",
    "West Virginia",
    "Wyoming"
  ];

  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static bool emailValidator(String email) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    return emailValid;
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static String messageTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    String difference = '';

    difference = DateFormat('jm').format(dt).toString();
    return difference;
  }

  static DateTime returnDateAndTimeFormat(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    // var originalDate = DateFormat('MM/dd/yyyy').format(dt);
    return DateTime(dt.year, dt.month, dt.day);
  }

  static String groupMessageDateAndTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    // var originalDate = DateFormat('MM/dd/yyyy').format(dt);

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';

    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      difference = "Today";
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else if (todayDate.difference(dt).inDays >= 2 &&
        todayDate.difference(dt).inDays < 3) {
      difference = DateFormat('EEEE').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 3 &&
        todayDate.difference(dt).inDays < 4) {
      difference = DateFormat('EEEE').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 4 &&
        todayDate.difference(dt).inDays < 5) {
      difference = DateFormat('EEEE').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 5 &&
        todayDate.difference(dt).inDays < 6) {
      difference = DateFormat('EEEE').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 6 &&
        todayDate.difference(dt).inDays < 7) {
      difference = DateFormat('EEEE').format(dt).toString();
    } else {
      difference = DateFormat.yMMMd().format(dt).toString();
    }

    return difference;
  }

  static void flushBarErrorMessage(
    BuildContext context,
    String message,
  ) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          titleColor: Colors.white,

          borderRadius: BorderRadius.circular(10),
          reverseAnimationCurve: Curves.easeOut,
          //  backgroundColor: MyColors.primaryColor,
          backgroundColor: AppColors.alertColor,
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          messageText: Text(message,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontFamily: AppFonts.intCircularMeduim,
                  height: 0)),
          icon: const Icon(
            Icons.error,
            size: 28.0,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 2),
          //leftBarIndicatorColor: Colors.red[300],
        )..show(context));
  }

  static void flushBarSuccessMessage(
    BuildContext context,
    String message,
  ) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          titleColor: Colors.white,

          borderRadius: BorderRadius.circular(10),
          reverseAnimationCurve: Curves.easeOut,
          backgroundColor: Colors.green.shade600,
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          messageText: Text(message,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontFamily: AppFonts.intCircularMeduim,
                  height: 0)),
          icon: const Icon(
            Icons.check_circle,
            size: 28.0,
            color: Colors.white,
          ),

          duration: const Duration(seconds: 2),
          //leftBarIndicatorColor: Colors.red[300],
        )..show(context));
  }

  static rSnackBar(String text, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ));
  }

  // Contacts Stages Colors
  static const contactColor = Color(0xffEE8332);
  static const contactPlusColor = Color(0xffEE8332);
  static const shProColor = Color(0xff7715F5);
  static const shProPlusColor = Color(0xff7715F5);
  static const recruiterColor = Color(0xff57C1F9);
  static const recruiterPlusColor = Color(0xff57C1F9);
  static const signedColor = Color(0xff02F900);
  static const signedPlusColor = Color(0xff02F900);

  static height(value) {
    return SizedBox(
      height: value,
    );
  }

  String daysBetween(String date) {
    try {
      final tagName = date;
      final split = tagName.split('-');
      DateTime dt = DateTime(
        int.parse(split[0]),
        int.parse(split[1]),
        int.parse(split[2]),
      );
      final todayDate = DateTime.now();
      return todayDate.difference(dt).inDays.toString();
    } catch (e) {
      return '';
    }
  }

  String daysBetweenDateAndTime(DateTime date) {
    try {
      DateTime dt = date;
      final todayDate = DateTime.now();

      if (todayDate.difference(dt).inDays.toString() == 0) {
        return 'Today';
      } else {
        return todayDate.difference(dt).inDays.toString() == '0'
            ? 'Today'
            : todayDate.difference(dt).inDays.toString();
      }
    } catch (e) {
      return '';
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // Contact stages colors
  Color contactColors(String stage) {
    if (stage == "Contact") {
      return const Color(0xffEE8332);
    } else if (stage == "Contact+") {
      return const Color(0xffEE8332);
    } else if (stage == "SH Pro") {
      return const Color(0xff7715F5);
    } else if (stage == "SH Pro+") {
      return const Color(0xff7715F5);
    } else if (stage == "Recruiter") {
      return const Color(0xff57C1F9);
    } else if (stage == "Recruiter+") {
      return const Color(0xff57C1F9);
    } else if (stage == 'Signed') {
      return const Color(0xff02F900);
    } else if (stage == "Signed+") {
      return const Color(0xff02F900);
    } else {
      return const Color.fromARGB(255, 255, 255, 255);
    }
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static List<String> blitzMonthList = [
    "Select blitz month",
    "October",
    "November",
    "December",
    "January",
    "February",
    "March",
    "April"
  ];

  static List<String> weeklyTrainingLocationList = [
    "Select Location",
    "Atlanta",
    "Baton Rouge",
    "Boise",
    "Ephraim",
    "Flagstaff",
    "Fullerton",
    "Las Vegas",
    "Logan",
    "Long Beach",
    "Mesa",
    "Nashville",
    "Norman",
    "Plano",
    "Price",
    "Provo",
    "San Antonio",
    "Tucson"
  ];
  static List<String> statsList = [
    "Select State",
    "AL",
    "AK",
    "AZ",
    "AR",
    "CA",
    "CO",
    "CT",
    "DE",
    "FL",
    "GA",
    "HI",
    "ID",
    "IL",
    "IN",
    "IA",
    "KS",
    "KY",
    "LA",
    "ME",
    "MD",
    "MA",
    "MI",
    "MN",
    "MS",
    "MO",
    "MT",
    "NE",
    "NV",
    "NH",
    "NJ",
    "NM",
    "NY",
    "NC",
    "ND",
    "OH",
    "OK",
    "OR",
    "PA",
    "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VT",
    "VA",
    "WA",
    "WV",
    "WI",
    "WY"
  ];

  static Map usStateMap = {
    "AL": "Alabama",
    "AK": "Alaska",
    "AZ": "Arizona",
    "AR": "Arkansas",
    "AS": "American Samoa",
    "CA": "California",
    "CO": "Colorado",
    "CT": "Connecticut",
    "DE": "Delaware",
    "DC": "District of Columbia",
    "FL": "Florida",
    "GA": "Georgia",
    "GU": "Guam",
    "HI": "Hawaii",
    "ID": "Idaho",
    "IL": "Illinois",
    "IN": "Indiana",
    "IA": "Iowa",
    "KS": "Kansas",
    "KY": "Kentucky",
    "LA": "Louisiana",
    "ME": "Maine",
    "MD": "Maryland",
    "MA": "Massachusetts",
    "MI": "Michigan",
    "MN": "Minnesota",
    "MS": "Mississippi",
    "MO": "Missouri",
    "MT": "Montana",
    "NE": "Nebraska",
    "NV": "Nevada",
    "NH": "New Hampshire",
    "NJ": "New Jersey",
    "NM": "New Mexico",
    "NY": "New York",
    "NC": "North Carolina",
    "ND": "North Dakota",
    "MP": "Northern Mariana Islands",
    "OH": "Ohio",
    "OK": "Oklahoma",
    "OR": "Oregon",
    "PA": "Pennsylvania",
    "PR": "Puerto Rico",
    "RI": "Rhode Island",
    "SC": "South Carolina",
    "SD": "South Dakota",
    "TN": "Tennessee",
    "TX": "Texas",
    "TT": "Trust Territories",
    "UT": "Utah",
    "VT": "Vermont",
    "VA": "Virginia",
    "VI": "Virgin Islands",
    "WA": "Washington",
    "WV": "West Virginia",
    "WI": "Wisconsin",
    "WY": "Wyoming"
  };

  static List<ModelRanking> rankingList = [
    ModelRanking(id: 1, title: "Patrick August", ranking: "71"),
    ModelRanking(id: 2, title: "Richie Tallia", ranking: "53"),
    ModelRanking(id: 3, title: "Bridger Dallimore", ranking: "47"),
    ModelRanking(id: 4, title: "Antonio Shaw", ranking: "45"),
    ModelRanking(id: 5, title: "Jon Stevens", ranking: "45"),
    ModelRanking(id: 6, title: "Angel Chavez", ranking: "41"),
    ModelRanking(id: 7, title: "Russ Smoot", ranking: "39"),
    ModelRanking(id: 8, title: "Kaden Ingram", ranking: "39"),
    ModelRanking(id: 9, title: "Tyce Petterson", ranking: "33"),
    ModelRanking(id: 10, title: "Nicholas Grant", ranking: "30"),
    ModelRanking(id: 11, title: "Brandon Miller", ranking: "151"),
    ModelRanking(id: 12, title: "Rial Parish", ranking: "128"),
    ModelRanking(id: 13, title: "Patrick August", ranking: "116"),
    ModelRanking(id: 14, title: "Kaden Ingram", ranking: "91"),
    ModelRanking(id: 15, title: "Bridger Dallimore", ranking: "89"),
    ModelRanking(id: 16, title: "Gabe Ramirez", ranking: "87"),
    ModelRanking(id: 17, title: "Blake Pennington", ranking: "87"),
    ModelRanking(id: 18, title: "Raymond Manriquez", ranking: "86"),
  ];

  String userRole(String role) {
    if (role == 'Rep') {
      return 'Rep';
    } else if (role == 'Team Lead') {
      return 'Team Lead';
    } else if (role == 'Manager') {
      return 'Manager';
    } else if (role == 'Senior Manager') {
      return 'Senior Manager';
    } else if (role == 'Regional') {
      return 'Regional';
    } else if (role == 'Senior Regional') {
      return 'Senior Regional';
    } else if (role == 'Partner') {
      return 'Partner';
    } else if (role == 'Division') {
      return 'Division';
    } else if (role == 'VP') {
      return 'VP';
    } else {
      return '';
    }
  }
}

class ModelRanking {
  int? id;
  String? title;
  String? ranking;
  ModelRanking({
    this.id,
    this.title,
    this.ranking,
  });
}
