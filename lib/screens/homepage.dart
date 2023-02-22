import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:undergrounder/widgets.dart';
import 'package:flutter_svg/svg.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  double _zoom = 1.0;
  void zoomIn() {
    setState(() {
      _zoom += 0.5;
    });
  }

  void zoomOut() {
    setState(() {
      _zoom -= 0.5;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("more options", style: TextStyle(color: Colors.black),),
      ),
      body: GestureDetector(
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _zoom = details.scale;
          });
        },
        child: Transform.scale(
          scale: _zoom,
          child: SvgPicture.asset("assets/railmap1.svg", height: 500.0, width: 100.0,),
        ),
      ),
      drawer: NavDrawer(),
    );
  }
}

class sideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
    );
  }
}