import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:async';

class TflApi {
  final String url = "api.tfl.gov.uk"; //base url


  final String appKey = 'a0896521114044f1861185577ec8b5b5'; //oAuth key

  Future<List> getLineStatus(List lineIds) async { //asynchronus keyword: waits for content before initialization.
    final implodedStations = lineIds.join(","); //join operator
    final response = await this._getRequest('/line/$implodedStations/status'); //encapsulation of vars into URL

    return jsonDecode(response.body);
  }


  Future<List> getLinesByStopPoint(String naptanId) async { //find statuses of lines (specified in array lineIds())
    try {
      final response = await this._getRequest('/StopPoint/$naptanId');
      //this variable is declared, however, waits for data from the http request to be sent before initalisation.
      final result = jsonDecode(response.body);
      return result['lines'];
    } catch (error) {
      throw error;
    }
  }

  Future<List> searchStationByName(String name) async {
    try {
      final params = {'query': name, 'modes': 'tube,overground,tflrail'}; //Query URL with encapusalted endpoints
      final response = await this._getRequest('/StopPoint/Search', params: params);
      final result = jsonDecode(response.body);
      return result['matches'];
    } catch (error) {
      throw error;
    }
  }

  Future<http.Response> _getRequest(path, {Map<String, String>? params}) {
    if (params == null) {
      params = {};
    }
    params.addAll({'app_key': appKey}); //adding appKey onto my requests

    final uri = Uri.https(url, path, params); //path:request endpoints to form the full URl that the https service will use
    final headers = {'Content-Type': 'application/json'};

    final request = http.get(uri, headers: headers); //formation of GET requests

    request.catchError((error) {
      throw error;
    });

    return request;
  }

  void getStationById() {}
}
