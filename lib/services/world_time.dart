import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location on UI
  String time; //time of that location
  String flag; // an asset for flag icon
  String url; // location url for api endpoint
  bool isDayTime; //true-day false-night

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');

      Map data = jsonDecode(response.body);
      //print(data);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);
      //create Datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print(now);

      //set time
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      print(time);
    } catch (e) {
      print('caught error:$e');
      time = 'could not get time';
    }
  }
}
