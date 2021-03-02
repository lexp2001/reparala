import 'package:google_maps_flutter/google_maps_flutter.dart';

class Worker {
  String name;
  String category;
  String description;
  String address;
  String distance;
  String score;
  String coverImage;
  List gallery;
  LatLng locationCoords;

  Worker(
      {this.name,
      this.category,
      this.description,
      this.address,
      this.distance,
      this.score,
      this.coverImage,
      this.gallery,
      this.locationCoords});

  factory Worker.fromJson(Map<String, dynamic> json) {
    return new Worker(
      name: json['name'],
      category: json['category'],
      description: json['description'],
      address: json['address'],
      distance: json['distance'],
      score: json['score'].toString(),
      coverImage: json['cover_image'],
      gallery: json['gallery'],
      locationCoords: new LatLng(json['lat'], json['long']),
    );
  }
}

class WorkersList {
  final List<Worker> workers;

  WorkersList({
    this.workers,
  });

  factory WorkersList.fromJson(List<dynamic> parsedJson) {
    List<Worker> workers = [];
    workers = parsedJson.map((i) => Worker.fromJson(i)).toList();

    return new WorkersList(workers: workers);
  }
}


//final WorkersList wl = new WorkersList() ;

//
// final List<Worker> workersList = [
//   Worker(
//     name: 'Ana Medina - Taller de Costura',
//     description:
//         'Architecto omnis atque dolores harum sapiente ab quia. Ipsam est aperiam accusamus quia quas qui. Amet eos sint ab rem sapiente. Nulla consequ untur praesentium aspernatur reiciendis. Aut debitis mollitia vero.',
//     address: '',
//     distance: 'A 1,4Km de distancia',
//     score: '4.5',
//     coverImage: 'assets/images/sewing_small.jpg',
//     locationCoords: LatLng(-33.461835607295214, -70.65552069086067),
//   ),
//   Worker(
//     name: 'José Alcántara - Zapatero',
//     description:
//         'Apsam est aperiam accusamus quia quas qui. Amet eos sint ab rem sapiente. Nulla consequ untur praesentium aspernatur reiciendis. Aut debitis mollitia vero. rchitecto omnis atque dolores harum sapiente ab quia.',
//     address: '',
//     distance: 'A 2,1Km de distancia',
//     score: '4.2',
//     coverImage: 'assets/images/leather_shoes_small.jpg',
//     locationCoords: LatLng(-33.45249756519097, -70.6508364856746),
//   ),
//   Worker(
//     name: 'Pedro Alcázar - Mecánico',
//     description:
//         'Amet eos sint ab rem sapiente. Architecto omnis atque dolores harum sapiente ab quia. Ipsam est aperiam accusamus quia quas qui. Nulla consequ untur praesentium aspernatur reiciendis. Aut debitis mollitia vero.',
//     address: '',
//     distance: 'A 2,8Km de distancia',
//     score: '4.1',
//     coverImage: 'assets/images/radio_small.jpg',
//     locationCoords: LatLng(-33.44087312775334, -70.67539448035822),
//   ),
//   Worker(
//     name: 'Luisa Villarreal - Costurera',
//     description:
//         ' Nulla consequ untur praesentium aspernatur reiciendis. Architecto omnis atque dolores harum sapiente ab quia. Ipsam est aperiam accusamus quia quas qui. Amet eos sint ab rem sapiente. Aut debitis mollitia vero.',
//     address: '',
//     distance: 'A 3,5Km de distancia',
//     score: '3.8',
//     coverImage: 'assets/images/silk_small.jpg',
//     locationCoords: LatLng(-33.471186429473825, -70.69658579362027),
//   ),
//   Worker(
//     name: 'Adrián Torres - Obrero',
//     description:
//         ' Aut debitis mollitia vero. Architecto omnis atque dolores harum sapiente ab quia. Ipsam est aperiam accusamus quia quas qui. Amet eos sint ab rem sapiente. Nulla consequ untur praesentium aspernatur reiciendis.',
//     address: '',
//     distance: 'A 4,2Km de distancia',
//     score: '3.5',
//     coverImage: 'assets/images/login_bg_small_compressed.jpg',
//     locationCoords: LatLng(-33.42628634628077, -70.68923213280654),
//   ),
// ];
