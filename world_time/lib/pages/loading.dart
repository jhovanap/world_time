import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/models/world_time.dart';
import 'package:world_time/services/world_time_repo.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  WorldTimeRepository repository = WorldTimeRepository();

  void setupWorldTime() async {
    try {
      WorldTime instance = await repository.getTime('Europe/London');
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDayTime
      });
    } catch (e) {
      print('Error: $e');
      // Manejar el error de manera adecuada, por ejemplo, mostrar un mensaje de error en la interfaz de usuario
    }
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        )
      ),
    );
  }
}
