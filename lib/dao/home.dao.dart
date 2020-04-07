import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip/model/home_model.dart';
import 'package:http/http.dart' as http; //当包有重名的情况用as起别名
const Home_URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

//首页大街口
class HomeDao{
  static Future<HomeModel> fetch() async {
    final response = await http.get(Home_URL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();  //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else{
      throw Exception('Failed to load home_page.json');
    }
  }
}