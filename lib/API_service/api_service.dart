import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:async';

class TflApi {
  final String url = "api.tfl.gov.uk";


  final String appKey = 'a0896521114044f1861185577ec8b5b5';

  Future<List> getLineStatus(List lineIds) async {
    final implodedStations = lineIds.join(",");
    final response = await this._getRequest('/line/$implodedStations/status');

    return jsonDecode(response.body);
  }

  Future<List> getStopPointsByLocation(lat, lon) async {
    try {
      final geoParams = {
        'stopTypes': 'NaptanMetroStation',
        'lat': lat.toString(),
        'lon': lon.toString(),
        'radius': '2000'
      };
      final response = await this._getRequest('/StopPoint', params: geoParams);
      final result = jsonDecode(response.body);
      return result['stopPoints'];
    } catch (error) {
      throw error;
    }
  }

  Future<List> getLinesByStopPoint(String naptanId) async { //find statuses of lines (specified in array lineIds())
    try {
      final response = await this._getRequest('/StopPoint/$naptanId'); //this variable is declared, however, waits for data from the http request to be sent before initalisation.
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
    params.addAll({'app_key': appKey});

    final uri = Uri.https(url, path, params);
    final headers = {'Content-Type': 'application/json'};

    final request = http.get(uri, headers: headers);

    request.catchError((error) {
      throw error;
    });

    return request;
  }

  void getStationById() {}
}
