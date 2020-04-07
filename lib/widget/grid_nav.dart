import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';
//网格卡片 携程首页网格布局
class GridNav extends StatelessWidget{
  final GridNavModel gridNavModel;
  final String name;

  const GridNav({Key key, @required this.gridNavModel,this.name="xiaoming"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _gridNavItems(context),
    );
  }
  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if(gridNavModel == null) return null;
    if(gridNavModel.hotel !=null){

    }
    if(gridNavModel.flight !=null){

    }
    if(gridNavModel.travel !=null){

    }
  }
  _gridNavItem(BuildContext context,GridNavItem gridNavItem,bool first){
    List<Widget> items = [];
    items.add(_mainItem(context,gridNavItem.mainItem));
  }
  _mainItem(BuildContext context,CommonModel model){
    return _wrapGesture(context, Stack(
      children: <Widget>[
        Image.network(
          model.icon,
          fit: BoxFit.contain,
          height: 88,
          width: 121,
          alignment: AlignmentDirectional.bottomEnd,
        ),
        Text(
          model.title,
          style: TextStyle(fontSize: 14,color: Colors.white),
        )
      ],
    ), model);
  }

  _doubleItem(BuildContext context,CommonModel topItem,CommonModel bottomItem, bool isCenterItem){
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context,topItem,true,isCenterItem),
        ),
        Expanded(
          child: _item(context,bottomItem,false,isCenterItem),
        )
      ],
    );
  }
  _item(BuildContext context, CommonModel item, bool first, bool isCenterItem){
    BorderSide borderSide = BorderSide(width: 0.8,color: Colors.white);
    return FractionallySizedBox(
      //撑满父布局的宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first?borderSide:BorderSide.none,
          )
        ),
        child: _wrapGesture(context, Center(
          child: Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14,color: Colors.white),
          ),
        ), item),
      ),
    );
  }

  _wrapGesture(BuildContext context,Widget widget, CommonModel model){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                WebView(
                  url: model.url,
                  statusBarColor: model.statusBarColor,
                  hideAppBar: model.hideAppBar,
                  title: model.title,
                )
            )
        );
      },
      child: widget,
    );
  }
}