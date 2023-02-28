import 'package:flutter/material.dart';
import 'package:undergrounder/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:undergrounder/API_service/api_service.dart';
import 'package:undergrounder/LineStatusess/StationDetailsScreen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  String _stationName = '';
  double _zoom = 1.0; //zoom in function
  void zoomIn() {
    setState(() {
      _zoom += 0.5;
    });
  }

  void zoomOut() { //zoom out function
    setState(() {
      _zoom -= 0.5;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Undergrounder: Tube Status Live", style: TextStyle(color: Colors.black),), //appbar on the top of the app
      ),
      body:SingleChildScrollView(
        child:Column( //list of infinite size, used to render multiple Widgets on the same tree.
            children: [

              ClipRect(
                child: GestureDetector(
                  onScaleUpdate: (ScaleUpdateDetails details) {
                    setState(() {
                      _zoom = details.scale; //touch detection applies my zoom functions onto the image (links to: pinch to zoom)
                    });
                  },
                  child: Transform.scale(
                    scale: _zoom,
                    child: SvgPicture.asset("assets/railmap1.svg", height: 500.0, width: 100.0,), //scrollable image asset
                  ),
                ),
              ),
              StationSearch(TflApi(), onNameSelected: (_stationName)),
            ],
          ),
        ),
      drawer: NavDrawer(),
      );//calls sidemenu once hamburger menu button is pressed.
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

class StopPoint {
  final String id;
  final String name;
  List<String> modes = [];

  StopPoint({required this.id, required this.name, required this.modes});

  factory StopPoint.fromJson(Map<String, dynamic> json){
    return StopPoint(id: json['id'], name: json['name'], modes: json['modes']);
  }
}



class StationSearch extends StatefulWidget {
  final TflApi api;

  StationSearch(this.api, {required String onNameSelected});

  @override
  _StationSearchState createState() => _StationSearchState(this.api);
}

class _StationSearchState extends State<StationSearch> {
  TflApi api;

  _StationSearchState(this.api);
  final _textController = TextEditingController();
  List<StopPoint> _searchRresults = [];


  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  onNameSelected(String name) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, //constrains the searchBar to the height of this box, to prevent rendering overflow errors
      child: Container(
        padding: EdgeInsets.only(left: 5.0, bottom: 10.0, right: 5.0, top: 10.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: "search",
                hintText: "enter a station name 'Bermondsey'", //provides hint for user to enter the name of a station
              ),
              onSubmitted: (value) {
                _onTextChanged(value);
              }
            ),
          ],
        ),
      ),
    );
  }

  _onTextChanged(String value) async {
      final response = await TflApi().searchStationByName(value);
      final List<dynamic> matches = response['matches'];

      for (var match in matches) {
        final String name = match['name'];
        final modes = match['modes'];
        print(name);
      }// this will print a list of all the station names in the response
  }
}


