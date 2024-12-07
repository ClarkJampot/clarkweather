import 'package:geolocator/geolocator.dart';

class Location{

  double lon =0,lat=0;

  Future getLocation()async{
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best));

      lat = position.latitude;
      lon = position.longitude;
    }catch(e) {
      print(e);
    }
  }
}