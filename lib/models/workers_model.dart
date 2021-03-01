import 'package:google_maps_flutter/google_maps_flutter.dart';

class Worker {
  String name;
  String description;
  String address;
  String distance;
  String score;
  String coverImage;
  List gallery;
  LatLng locationCoords;

  Worker(
      {this.name,
      this.description,
      this.address,
      this.distance,
      this.score,
      this.coverImage,
      this.gallery,
      this.locationCoords});
}

final List<Worker> workersList = [
  Worker(
    name: 'Ana Medina - Taller de Costura',
    description:
        'Architecto omnis atque dolores harum sapiente ab quia. Ipsam est aperiam accusamus quia quas qui. Amet eos sint ab rem sapiente. Nulla consequ untur praesentium aspernatur reiciendis. Aut debitis mollitia vero.',
    address: '',
    distance: 'A 1,4Km de distancia',
    score: '4.5',
    coverImage: 'assets/images/sewing_small.jpg',
    gallery: [
      'assets/images/sewing_work_table_small.jpg',
      'assets/images/silk_small.jpg',
      'assets/images/reels_small.jpg',
      'assets/images/fibers_small.jpg',
    ],
    locationCoords: LatLng(-33.461835607295214, -70.65552069086067),
  ),
  Worker(
    name: 'José Alcántara - Zapatero',
    description:
        'Apsam est aperiam accusamus quia quas qui. Amet eos sint ab rem sapiente. Nulla consequ untur praesentium aspernatur reiciendis. Aut debitis mollitia vero. rchitecto omnis atque dolores harum sapiente ab quia.',
    address: '',
    distance: 'A 2,1Km de distancia',
    score: '4.2',
    coverImage: 'assets/images/leather_shoes_small.jpg',
    gallery: [
      'assets/images/fibers_small.jpg',
      'assets/images/leather_shoes_small.jpg',
      'assets/images/sewing_work_table_small.jpg',
      'assets/images/reels_small.jpg',
    ],
    locationCoords: LatLng(-33.45249756519097, -70.6508364856746),
  ),
  Worker(
    name: 'Pedro Alcázar - Mecánico',
    description:
        'Amet eos sint ab rem sapiente. Architecto omnis atque dolores harum sapiente ab quia. Ipsam est aperiam accusamus quia quas qui. Nulla consequ untur praesentium aspernatur reiciendis. Aut debitis mollitia vero.',
    address: '',
    distance: 'A 2,8Km de distancia',
    score: '4.1',
    coverImage: 'assets/images/radio_small.jpg',
    gallery: [
      'assets/images/person3.jpg',
      'assets/images/radio_small.jpg',
      'assets/images/sewing_work_table_small.jpg',
      'assets/images/silk_small.jpg',
    ],
    locationCoords: LatLng(-33.44087312775334, -70.67539448035822),
  ),
  Worker(
    name: 'Luisa Villarreal - Costurera',
    description:
        ' Nulla consequ untur praesentium aspernatur reiciendis. Architecto omnis atque dolores harum sapiente ab quia. Ipsam est aperiam accusamus quia quas qui. Amet eos sint ab rem sapiente. Aut debitis mollitia vero.',
    address: '',
    distance: 'A 3,5Km de distancia',
    score: '3.8',
    coverImage: 'assets/images/silk_small.jpg',
    gallery: [
      'assets/images/tshirts_small.jpg',
      'assets/images/silk_small.jpg',
      'assets/images/shirt_small.jpg',
      'assets/images/fibers_small.jpg',
    ],
    locationCoords: LatLng(-33.471186429473825, -70.69658579362027),
  ),
  Worker(
    name: 'Adrián Torres - Obrero',
    description:
        ' Aut debitis mollitia vero. Architecto omnis atque dolores harum sapiente ab quia. Ipsam est aperiam accusamus quia quas qui. Amet eos sint ab rem sapiente. Nulla consequ untur praesentium aspernatur reiciendis.',
    address: '',
    distance: 'A 4,2Km de distancia',
    score: '3.5',
    coverImage: 'assets/images/login_bg_small_compressed.jpg',
    gallery: [
      'assets/images/person2.jpg',
      'assets/images/login_bg_small_compressed.jpg',
      'assets/images/radio_small.jpg',
      'assets/images/fibers_small.jpg',
    ],
    locationCoords: LatLng(-33.42628634628077, -70.68923213280654),
  ),
];
