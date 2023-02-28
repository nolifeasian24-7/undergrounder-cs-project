import 'dart:async';

import 'package:flutter/material.dart';
import 'package:undergrounder/API_service/api_service.dart';
import 'package:undergrounder/LineStatusess/DistrictStatus.dart';
import 'package:undergrounder/screens/homepage.dart';


class StationsDisplay extends StatelessWidget {
  final Function(String) onNameChanged;

  const StationsDisplay({Key? key, required this.onNameChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search Results"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: onNameChanged,
          )
        ],
      ),
    );
  }
}