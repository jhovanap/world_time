import 'package:flutter/material.dart';
import 'package:world_time/services/world_time_repo.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTimeRepository> locations = [
    WorldTimeRepository(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTimeRepository(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTimeRepository(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTimeRepository(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTimeRepository(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTimeRepository(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTimeRepository(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTimeRepository(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];
  void updateTime(index) async {
    WorldTimeRepository instance = locations[index];
    await instance.getTime(locations[index].location);
    Navigator.pushReplacementNamed(context, '/', arguments: {
      'location': locations[index].location,
      'flag': locations[index].flag,
      'time': locations[index].time,
      'isDaytime': locations[index].isDaytime
    });
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                    Navigator.pushNamed(context, '/home');
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
