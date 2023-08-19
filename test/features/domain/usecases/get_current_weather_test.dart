import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/features/domain/entities/weather.dart';
import 'package:weather/features/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../helper/test_helper.mocks.dart';


void main(){
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
 late MockWeatherRepository mockWeatherRepository;

  setUp((){
 mockWeatherRepository=MockWeatherRepository();
 getCurrentWeatherUseCase=GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetail=WeatherEntity(
      cityName: "Lagos",
      main: "Rain",
      description: "Low rain",
      iconCode: "02d",
      temperature: 300.3,
      pressure: 1010,
      humidity: 76);

  const testCityName= "Lagos";

  test(" get current weather detail ",
      ()async{

    //arrange
        when(
          mockWeatherRepository.getCurrentWeather(testCityName)
        ).thenAnswer((_) async => const Right(testWeatherDetail));
        //act
        final result =await  getCurrentWeatherUseCase.execute(testCityName);
        //assert
        expect(result,const  Right(testWeatherDetail));
      });
}