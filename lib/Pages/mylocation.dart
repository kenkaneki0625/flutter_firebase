import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  String? _currentAddress;
  Position? _currentposition;
  bool isLoading = false;

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location not available');
    } else {
      print('Location not available');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (_currentAddress != null)
                      Text(
                        _currentAddress!,
                        style: const TextStyle(fontSize: 25),
                      ),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        _currentposition = await _determinePosition();
                        _getAddress(_currentposition!.latitude, _currentposition!.longitude);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text(
                        "Get Location",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  ],
                )),
    );
  }

  void _getAddress(latitude, longitude) async {
    try {
      List<Placemark> placemark = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemark[0];
      setState(() {
        _currentAddress = '${place.locality},${place.street},${place.country}';
      });
    } catch (e) {
      print(e);
    }
  }
}
