import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = "AIzaSyCyA-FRhU8MP_Gt8yLke9spBukTvfCBCFE";

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=mongolian&inputtype=textquery&locationbias=circle%3A2000%4047.6918452%2C-122.2226413&key=AIzaSyCyA-FRhU8MP_Gt8yLke9spBukTvfCBCFE';
    // 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=${input}&inputtype=textquery&key=${key}';

    var response = await http.get(Uri.parse(url));
    print("============== ${response.body}");

    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);

    final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?place_id=${placeId}&inputtype=textquery&key=${key}';

    var response = await http.get(Uri.parse(url));
    print("============== ${response.body}");

    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    return results;

  }
}
