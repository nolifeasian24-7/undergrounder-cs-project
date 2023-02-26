import 'dart:async';

import 'package:flutter/material.dart';
import 'package:undergrounder/API_service/api_service.dart';
import 'package:undergrounder/LineStatusess/DistrictStatus.dart';


class StationStatus extends StatefulWidget {
  final stopPoint;

  StationStatus(this.stopPoint);

  @override
  _StationStatuState createState() => _StationStatuState();
}

class _StationStatuState extends State<StationStatus> {
  _StationStatuState();

  @override
  void initState() {
    //refreshes database every 30 seconds
    Timer(Duration(seconds: 30), () {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lineFuture = TflApi().getLinesByStopPoint(widget.stopPoint['id']);

    return FutureBuilder<List>(
      future: lineFuture,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return SnackBar(
                  content: Text(
                      'Failed to load line data, please try again'));
            }
            
            final lineIdRegex = new RegExp(r"^[a-zA-Z-]+$");

            final lineIds = snapshot.data
                ?.where((line){
                  final id = line['id'];
                  return lineIdRegex.hasMatch(id);
            })
                .map((line) => line['id'])
                .toSet()
                .toList();
            return StatusIndicator(lineIds!, 0, api: TflApi());

        }});
  }
}