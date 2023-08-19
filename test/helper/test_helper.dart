import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/features/data/datasource/remote_data_source.dart';
import 'package:weather/features/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
    [
        WeatherRepository ,
        WeatherRemoteDataSource
    ],
    customMocks:[MockSpec<http.Client>(as: #MockHttpClient)],
)

void main(){}