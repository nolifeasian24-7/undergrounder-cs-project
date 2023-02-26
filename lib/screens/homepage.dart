import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:undergrounder/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:undergrounder/API_service/api_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:undergrounder/LineStatusess/StationDetailsScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
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
      body: GestureDetector(
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
      drawer: NavDrawer(), //calls sidemenu once hamburger menu button is pressed.
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


class StationSearch extends StatefulWidget {
  final TflApi api;

  StationSearch(this.api);

  @override
  _StationSearchState createState() => _StationSearchState(this.api);
}

class _StationSearchState extends State<StationSearch> {
  TflApi api;

  _StationSearchState(this.api);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Find Desired Station: Eg: 'Bermondsey'"),
            ),
            suggestionsCallback: (patterns) async {
              final stations = await api.searchStationByName(patterns);

              return stations;
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion['name']),
              );
            },
            onSuggestionSelected: (suggestion) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => StationStatus(suggestion)));
            },
          )
        ],
      ),
    );
  }
}