import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:world_time/models/world_time.dart';

class WorldTimeRepository {

  late String location = ''; // location name for UI
  late String time; // the time in that location
  late String flag = ''; // url to an asset flag icon
  late String url; // location url for api endpoint
  late bool isDaytime; // true or false if daytime or not

  WorldTimeRepository({url, location, flag});

  Future<WorldTime> getTime(String url) async {
    print(url);
    try {
      final response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      final data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String? offset = data['utc_offset']?.substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset ?? '0')));

      bool isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      return WorldTime(
          location: data['timezone'] ?? '',
          flag: flag ?? '',
          url: url,
          time: DateFormat.jm().format(now),
          isDayTime: isDayTime);
    } catch (e) {
      print(e);
      throw Exception('No se pudo obtener la hora');
    }
  }
}
