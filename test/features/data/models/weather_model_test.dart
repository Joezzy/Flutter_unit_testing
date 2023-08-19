

import 'package:flutter_test/flutter_test.dart';
import 'package:weather/features/data/models/weather_model.dart';
import 'package:weather/features/domain/entities/weather.dart';

void main(){

   const testWeatherModel=WeatherModel(
       cityName: "Lagos",
       main: "Rain",
       description: "Low rain",
       iconCode: "02d",
       temperature: 300.3,
       pressure: 1010,
       humidity: 76 );

   test("Should be a subclass of weather entity",
           () {
                  //assert
           expect(testWeatherModel, isA<WeatherEntity>());
   });

}