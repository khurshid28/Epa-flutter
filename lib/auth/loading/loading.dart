import 'package:epa/auth/activation_code.dart';
import 'package:flutter/material.dart';

class My_loading extends StatefulWidget {
  String? _cardNumber;
  My_loading(this._cardNumber);

  @override
  _My_loadingState createState() => _My_loadingState();
}

class _My_loadingState extends State<My_loading> with TickerProviderStateMixin{
  AnimationController? _animationController;
  @override
  void initState() {
    _animationController=AnimationController(vsync: this,duration: Duration(microseconds: 300))..forward();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animationController!, builder: (context,child){
      if (_animationController!.value==1) {
        return ActivationCode(widget._cardNumber);
      } else {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: Colors.red,),
          ),
        );
      }
    });
  }
}