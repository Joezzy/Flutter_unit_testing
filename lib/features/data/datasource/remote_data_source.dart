

import 'dart:convert';

import 'package:weather/core/constant/constant.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}


class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource{
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client}); @override

  @override
  Future <WeatherModel> getCurrentWeather(String cityName) async {
    final response = await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

}


// class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
//   final http.Client client;
//   WeatherRemoteDataSourceImpl({required this.client});
//
//   @override
//   Future < WeatherModel > getCurrentWeather(String cityName) async {
//     final response =
//     await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
//
//     if (response.statusCode == 200) {
//       return WeatherModel.fromJson(json.decode(response.body));
//     } else {
//       throw ServerException();
//     }
//   }
// }