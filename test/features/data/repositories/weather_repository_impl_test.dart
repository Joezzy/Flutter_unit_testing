
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/data/models/weather_model.dart';
import 'package:weather/features/data/repositories/weather_repository_impl.dart';
import 'package:weather/features/domain/entities/weather.dart';
import 'package:weather/features/domain/repositories/weather_repository.dart';
import '../../../helper/test_helper.mocks.dart';
void main(){
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;


   setUp(() {
     mockWeatherRemoteDataSource=MockWeatherRemoteDataSource();
     weatherRepositoryImpl=WeatherRepositoryImpl(
         weatherRemoteDataSource: mockWeatherRemoteDataSource);

   });
  const testWeatherModel = WeatherModel(
    cityName: 'Lagos',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const cityName='Lagos';
  const testWeatherEntity = WeatherEntity(
    cityName: 'Lagos',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group("test Weather Repo", () {
    test("Return current weather if its successful - 200", () async{
        when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
            .thenAnswer((_) async =>testWeatherModel);

        final result=await weatherRepositoryImpl.getCurrentWeather(cityName);
        
        expect(result, const Right(testWeatherEntity));


    });
    test("Return server failure  if its unsuccessful  - 404", () async{
        when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
            .thenThrow(ServerException());
        final result=await weatherRepositoryImpl.getCurrentWeather(cityName);
        expect(result,const  Left(ServerFailure("An error occurred")));
    });

    test("Return connection failure  if it couldnt connect - 500", () async{
        when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
            .thenThrow(const SocketException('Cannot connect'));
        final result=await weatherRepositoryImpl.getCurrentWeather(cityName);
        expect(result,const  Left(ConnectionFailure("Connection failure")));
    });

    
  });

}