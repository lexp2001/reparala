import 'dart:convert';
import 'package:repara_latam/models/workers_model.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Get workers list
Future<WorkersList> getWorkers() async {
  final response = await http.get('https://api-reparala.herokuapp.com/workers');
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    var workersList = WorkersList.fromJson(jsonResponse['results']);

    // List<Marker> allMarkers = [];
    //
    // workersList.workers.asMap().forEach((index, element) {
    //   allMarkers.add(Marker(
    //     markerId: MarkerId(element.name),
    //     draggable: false,
    //     infoWindow: InfoWindow(
    //       title: element.name,
    //       snippet: '★' + element.score,
    //       onTap: () {
    //         setState(() {
    //           _currentScreen = 50;
    //           _selectedWorker = index;
    //           print(_selectedWorker);
    //         });
    //       },
    //     ),
    //     position: element.locationCoords,
    //   ));
    // });


    return workersList;
  } else {
    throw Exception('Unable to find workers from the REST API');
  }
}