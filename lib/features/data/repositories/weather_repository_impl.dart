

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/data/datasource/remote_data_source.dart';
import 'package:weather/features/domain/entities/weather.dart';
import 'package:weather/features/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository{
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) async{
    try{
      final result=await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    }on ServerException{
      return const Left(ServerFailure("An error occurred"));
    }on SocketException{
      return const Left(ConnectionFailure("Connection failure"));
    }
  }


}