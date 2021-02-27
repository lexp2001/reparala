import 'package:google_maps_flutter/google_maps_flutter.dart';

class Worker {
  String name;
  String address;
  String score;
  String coverImage;
  LatLng locationCoords;

  Worker(
      {this.name,
      this.address,
      this.score,
      this.coverImage,
      this.locationCoords});
}

final List<Worker> workersList = [
  Worker(
    name: 'Ana Medina - Taller de Costura',
    address: '',
    score: '4.7',
    coverImage: 'assets/images/sewing_small.jpg',
    locationCoords: LatLng(-33.461835607295214, -70.65552069086067),
  ),
  Worker(
    name: 'José Alcántara - Zapatero',
    address: '',
    score: '4.7',
    coverImage: 'assets/images/sewing_small.jpg',
    locationCoords: LatLng(-33.45249756519097, -70.6508364856746),
  ),
  Worker(
    name: 'Pedro Alcázar - Mecánico',
    address: '',
    score: '4.7',
    coverImage: 'assets/images/sewing_small.jpg',
    locationCoords: LatLng(-33.427752401749466, -70.60533480245113),
  ),
  Worker(
    name: 'Luisa Villarreal - Costurera',
    address: '',
    score: '4.7',
    coverImage: 'assets/images/sewing_small.jpg',
    locationCoords: LatLng(-33.471186429473825, -70.69658579362027),
  ),
  Worker(
    name: 'Adrián Torres - Obrero',
    address: '',
    score: '4.7',
    coverImage: 'assets/images/sewing_small.jpg',
    locationCoords: LatLng(-33.42628634628077, -70.68923213280654),
  ),
];
