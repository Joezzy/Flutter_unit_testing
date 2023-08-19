
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/constant/constant.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/features/data/datasource/remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:weather/features/data/models/weather_model.dart';
import '../../../helper/json_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main(){
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

setUp((){
  mockHttpClient=MockHttpClient();
  weatherRemoteDataSourceImpl=WeatherRemoteDataSourceImpl(client: mockHttpClient);
});

const testCity='Lagos';

group("Get current weather", (){
  test('should return weather model when the response code is 200', () async {
    //arrange
    when(
        mockHttpClient.get(
            Uri.parse(Urls.currentWeatherByName(testCity))
        )
    ).thenAnswer(
            (_) async => http.Response(
            readJson('helper/dummy_data/dummy_weather_response.json'),
            200
        )
    );


    //act
    final result = await weatherRemoteDataSourceImpl.getCurrentWeather(testCity);
    //assert
    expect(result, isA<WeatherModel>());

  });


  test('should throw ServerException model when the response code is 404 and above', () async {
    //arrange
    when(
        mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCity))),
    ).thenAnswer(
            (_) async => http.Response('Not found', 404)
    );

    //act
    final result =  weatherRemoteDataSourceImpl.getCurrentWeather(testCity);
    //assert
    expect(result, throwsA(isA<ServerException>()));
  });


});


}