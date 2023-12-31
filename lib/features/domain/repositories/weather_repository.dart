
import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/domain/entities/weather.dart';

abstract class WeatherRepository{
  Future<Either<Failure,WeatherEntity>> getCurrentWeather(String cityName);
}