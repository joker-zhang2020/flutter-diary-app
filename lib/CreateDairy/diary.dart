import 'package:app/CreateDairy/picture.dart';
import 'package:app/icons/myIcons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'createDiaryAppBar.dart';

class CreateDairy extends StatefulWidget {
  const CreateDairy({Key? key}) : super(key: key);

  @override
  _CreateDairyState createState() => _CreateDairyState();
}

class _CreateDairyState extends State<CreateDairy> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Map<String,dynamic> weather = {"name":"点击选择天气","icon":Icons.wb_sunny_outlined};
  String contentLength = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DiaryAppBar(),
        backgroundColor: const Color(0xFF2F4F4F),
        body: FutureBuilder<AndroidDeviceInfo>(
          future: deviceInfo.androidInfo,
          builder: (context, snapshot){
            return Container(
                margin: const EdgeInsets.all(10),
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const TextField(maxLines: 20, minLines: 5, decoration: InputDecoration(
                    border: InputBorder.none,
                  ),),
                  const PictureChose(),
                  InkWell(
                    onTap: (){_weather(context);},
                    child: Row(children: [Icon(weather['icon'],size: 16),const SizedBox(width: 10),Text(weather['name'])])),
                  const SizedBox(height: 10),
                  Row(children: [const Icon(Icons.add_location_rounded,size: 16),const SizedBox(width: 10),
                    FutureBuilder<Position>(future:_determinePosition() ,builder: (context, snapshot) {
                      return Text(snapshot.connectionState == ConnectionState.done ? snapshot.data!.latitude.toString() : "定位失败，请检查系统定位是否已开启");
                    }),
                  ]),
                  const SizedBox(height: 10,),
                  Row(children: [const Icon(Icons.phone_android,size:16),const SizedBox(width: 10),Text(snapshot.connectionState == ConnectionState.done ? snapshot.data!.model : '')]),
                  const SizedBox(height:10),
                  // Row(children: [const Icon(Icons.text_fields,size:16),const SizedBox(width: 10),Text(contentLength + '字')])
                ]));
          },
        ) );
  }


  Future<void> _weather(context) async{
    List<Map<String,dynamic>> weatherList = [{
      "name":"晴",
      "icon": MyIcons.clear
    },{
      "name":"多云",
      "icon": MyIcons.cloudy
    },{
      "name":"阴",
      "icon": MyIcons.shade
    },{
      "name":"雨",
      "icon": MyIcons.rainstorm
    },{
      "name":"雷阵雨",
      "icon": MyIcons.thundershower
    },{
      "name":"雪",
      "icon": MyIcons.snow
    },{
      "name":"大风",
      "icon": MyIcons.gale
    },{
      "name":"大雾",
      "icon": MyIcons.heavyFog
    },{
      "name":"冰雹",
      "icon": MyIcons.hailstone
    },{
      "name":"雾霾",
      "icon": MyIcons.haze
    },{
      "name":"沙尘暴",
      "icon": MyIcons.sandstorm
    },{
      "name":"日出",
      "icon": MyIcons.sunrise
    },{
      "name":"日落",
      "icon":MyIcons.sunset
    },{
      "name":"深夜",
      "icon": MyIcons.lateAtNight
    }];
    await showModalBottomSheet(
        builder: (BuildContext context) {
          return Column(children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: InkWell(child: const Icon(Icons.arrow_downward),onTap: (){Navigator.pop(context);}),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Wrap( spacing: 20,children: weatherList.map((item){
                return InkWell(onTap: (){
                  setState(() {
                    weather = item;
                  });
                  Navigator.pop(context);
                },child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    width: 50,
                    height: 50,
                    child: Column(children: [
                      Icon(item['icon']),
                      const SizedBox(height: 2),
                      Text(item["name"])
                    ])
                ));
              }).toList()),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          );
        },
        context: context
    );
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}
