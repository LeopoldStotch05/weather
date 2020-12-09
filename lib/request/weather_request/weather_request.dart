import '../../constants/constants.dart';
import '../request_model.dart';

class WeatherRequest extends RequestModel {
  @override
  String uri = url + '/onecall';

  @override
  HttpMethod method = HttpMethod.getMethod;

  @override
  Map<String, dynamic> queryParameters = Map.from(apiKeyParameter);

  WeatherRequest(double lat, double lon, {List<String> exclude, String units}) {
    assert(lat != null);
    assert(lon != null);

    queryParameters['lat'] = lat.toString();
    queryParameters['lon'] = lon.toString();
    queryParameters['exclude'] = exclude.join(',');
    queryParameters['units'] = units;
  }
}
