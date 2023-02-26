import 'dart:async'; //async function for Initalizing variables during runtime

import 'package:flutter/material.dart';
import 'package:undergrounder/API_service/api_service.dart'; //importing the API service used to parse data.

class StatusIndicator extends StatefulWidget { //StatusIndicator class, extends "stateful" Ui class as the state of this widget changes during runtime.
  final List lineIds;

  final TflApi api;

  final int ImgIndex; //final constructors for variables passed into the Widget to prevent accidental modification.


  StatusIndicator(this.lineIds, this.ImgIndex, {required this.api}); //"required" keyword, to pass my TfLApi from "api_service.dart" which I had imported

  @override
  _StatusIndicatorState createState() =>
      _StatusIndicatorState(this.lineIds, (this.api));
}

class Expandable {
  bool isExpanded = true; //this sets the card to expanded, and users can toggle to hide the information.
  Map data; //multi dimensional array

  Expandable(this.data); //constructor used to expands the card with the data
}


class _StatusIndicatorState extends State<StatusIndicator> {
  final lineIds;
  TflApi api;
  List items = [];
  var routeMapsImages = ["assets/District-line-map.jpg", "assets/Central-line-map.jpg","assets/Northern Line.jpg", "assets/Jubilee-line-map.jpg", "assets/Picadilly Line.jpg", "assets/Bakerloo-line-map.jpg", "assets/Hammersmith.jpg", "assets/Circle.jpg", "assets/Metropolitan-line-map.jpg", "assets/Elizabeth Map.jpg"]; //initalizing of data model to parse recieved json data into
  var routeColours = [Colors.green, Colors.red, Colors.black, Colors.blueGrey, Colors.blueAccent, Colors.brown, Colors.pinkAccent, Colors.yellow, Colors.indigo, Colors.deepPurple];
  bool snapShotLoaded = false;
  //routeMapImages[] is an array of assetImages, and routeColors[] is an array of Ui Colors.

  static Timer ?refresh; //timer Library imported with "material" Ui

  static Future<List> ?statusFuture;

  _StatusIndicatorState(this.lineIds, this.api) {
    initFuture();

    if (refresh == null) {
      refresh = new Timer.periodic(Duration(minutes: 30),(Timer t) {
        reloadFuture();
      }); //timer function, responsible for refreshing updates to the API, shouldn't be too frequent otherwise overflow of requests is made
    }
  }

  void initFuture() {
    statusFuture = api.getLineStatus(lineIds);
  }
  void reloadFuture() {
    initFuture();
    setState(() {});
  }
  var index = 0; //index used to identify which routeMap/colur to display, pased in my constructor calls in "Widgets.dart

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: statusFuture,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator()); //Loading spinner while waiting to initalize "await" variables.
          case ConnectionState.done:
            if (snapshot.hasError) {
              return SnackBar(content: Text("Failed to load line status")); //error Checking if the API experiences an error
            }

            if (!snapShotLoaded) {
              snapshot.data?.forEach((item) {items.add(Expandable(item));});
              snapShotLoaded = true; //verifying the snapshot Widget loaded (card Widget)
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: routeColours[widget.ImgIndex], //setting colour, done during Sprint 3
              ),
              body: SingleChildScrollView(
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) { //checking if user toggled the card expansion button
                    setState(() {
                      items[index].isExpanded = !items[index].isExpanded;
                    });
                  },
                  children: items.map((item) { //maps Status onto expanded PanelListView.
                    return createListView(item);
                  }).toList(),
                  expandedHeaderPadding: EdgeInsets.all(10.0),

                ),
              ),
              backgroundColor: routeColours[widget.ImgIndex], //background colour, sprint 3.
            );
        }
      }
    );
  }

  ExpansionPanel createListView(Expandable expandable) {
    final item = expandable.data;


    final lineStauses = item['lineStatuses'];
    List reasons = [];

    lineStauses.forEach((status) {
      if(status['statusSeverityDescription'] != 'Good Service') {
        reasons.add(status['reason']);
        //formation of the card Widget, if the service is not "Good service" reassign "replace" to the jsonResponse "reason"
      }
    });

    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return GestureDetector(
          onTap: () {
            expandable.isExpanded = !expandable.isExpanded;
            setState(() {});
          },// listener class for deteching Touch input from user
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10.0),
                child: Text(item['name']), //disaplying name of selected line
              ),

            ],
          ),
        );
      },
      isExpanded: expandable.isExpanded,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text(reasons.length > 0 ? reasons.join('\n\n'): 'Good service'),
                Container(
                  child: Image.asset(routeMapsImages[widget.ImgIndex]), //loads the background colour/routeMapImage.
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}




