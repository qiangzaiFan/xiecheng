//  config Object
//  bannerList Array
//  localNavList Array
//  gridNav Objecgt
//  subNavList Array
//  salesBox Object
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel{
  final ConfigModel config; //配置
  final List<CommonModel> bannerList; //轮播图
  final List<CommonModel> localNavList; //本地导航
  final List<CommonModel> subNavList;  //卡片下面那个
  final GridNavModel gridNav; //卡片
  final SalesBoxModel salesBox; //活动
  HomeModel({
    this.config,
    this.bannerList,
    this.localNavList,
    this.gridNav,
    this.subNavList,
    this.salesBox
  });

  factory HomeModel.fromJson(Map<String,dynamic> json){
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
    localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
      bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
      subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      localNavList:localNavList,
      bannerList:bannerList,
      subNavList:subNavList,
      config:ConfigModel.fromJson(json['config']),
      gridNav:GridNavModel.fromJson(json['gridNav']),
      salesBox:SalesBoxModel.fromJson(json['salesBox']),
    );
  }
}