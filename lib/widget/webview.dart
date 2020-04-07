import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
const CATCH_URLS = ['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5'];  //设置白名单，防止返回到携程的首页
class WebView extends StatefulWidget{
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid; //禁止返回

  WebView({
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid = false
  });
  //backForbid 下面有判断这个值的if语句，所以需要给它一个默认值
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView>{
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;
  @override
  void initState() {
    super.initState();
    webviewReference.close();//Close launc hed WebView
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url){});
    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type){
        case WebViewState.startLoad:
          if(_isToMain(state.url) && !exiting){
            if(widget.backForbid){
              webviewReference.launch(widget.url);
            }else{
              Navigator.pop(context); //返回上一页，做一个标志位
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError error){
      print(error);
    });
  }
  _isToMain(String url){
    bool contain = false;
    for(final value in CATCH_URLS){
      //这样的写法是，如果url存在，就走endsWith方法，否则就走false
      if(url?.endsWith(value)?? false){
        contain = true;
        break;
      }
    }
    return contain;
  }
  @override
  void dispose() {
    super.dispose();
    _onUrlChanged.cancel(); //将对应的注册监听给取消掉
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //初始化状态颜色
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff'; //statusBarColor颜色没有设的话就显示一个白色
    Color backButtonColor;
    if(statusBarColorStr == 'ffffff'){
      backButtonColor = Colors.black;
    }else{
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          //将String 类型的颜色转化为int类型
          _appBar(Color(int.parse('0xff'+ statusBarColorStr)),backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(  //初始化加载的时候 loading 圈
                color:Colors.white,
                child:Center(
                  child: Text('Waiting...'),
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  _appBar(Color backgroundColor,Color backButtonColor){
    if(widget.hideAppBar??false){
      return Container(
        color:backgroundColor,
        height:30,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1, //设置为1就可以使Stack里面的内容撑满整个布局
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left:10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
                right: 0,
              child: Center(
                child:Text(
                  widget.title ?? "",
                  style: TextStyle(color: backButtonColor,fontSize: 20)
                )
              )
            )
          ],
        ),
      ),
    );
  }
}