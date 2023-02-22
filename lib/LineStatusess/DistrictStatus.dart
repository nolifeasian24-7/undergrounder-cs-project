import 'dart:async';

import 'package:flutter/material.dart';
import 'package:undergrounder/API_service/api_service.dart';

class StatusIndicator extends StatefulWidget {
  final List lineIds;

  final TflApi api;

  final int ImgIndex;


  StatusIndicator(this.lineIds, this.ImgIndex, {required this.api});

  @override
  _StatusIndicatorState createState() =>
      _StatusIndicatorState(this.lineIds, (this.api));
}

class Expandable {
  bool isExpanded = false;
  Map data;

  Expandable(this.data);
}


class _StatusIndicatorState extends State<StatusIndicator> {
  final lineIds;
  TflApi api;
  List items = [];
  var routeMapsImages = ["assets/District-line-map.jpg", "assets/Central-line-map.jpg","assets/Northern Line.jpg", "assets/Jubilee-line-map.jpg", "assets/Picadilly Line.jpg", "assets/Bakerloo-line-map.jpg", "assets/Hammersmith.jpg", "assets/Circle.jpg", "assets/Metropolitan-line-map.jpg", "assets/Elizabeth Map.jpg"]; //initalizing of data model to parse recieved json data into
  var routeColours = [Colors.green, Colors.red, Colors.black, Colors.blueGrey, Colors.blueAccent, Colors.brown, Colors.pinkAccent, Colors.yellow, Colors.indigo, Colors.deepPurple];
  bool snapShotLoaded = false;

  static Timer ?refresh;

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
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: statusFuture,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return SnackBar(content: Text("Failed to load line status"));
            }

            if (!snapShotLoaded) {
              snapshot.data?.forEach((item) {items.add(Expandable(item));});
              snapShotLoaded = true;
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: routeColours[widget.ImgIndex],
              ),
              body: SingleChildScrollView(
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      items[index].isExpanded = !items[index].isExpanded;
                    });
                  },
                  children: items.map((item) {
                    return createListView(item);
                  }).toList(),
                  expandedHeaderPadding: EdgeInsets.all(10.0),

                ),
              ),
              backgroundColor: routeColours[widget.ImgIndex],
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
      }
    });

    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return GestureDetector(
          onTap: () {
            expandable.isExpanded = !expandable.isExpanded;
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10.0),
                child: Text(item['name']),
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
                  child: Image.asset(routeMapsImages[widget.ImgIndex]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}




