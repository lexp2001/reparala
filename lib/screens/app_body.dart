import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:repara_latam/blocs/application_bloc.dart';
import 'package:repara_latam/main.dart';
import 'package:repara_latam/models/messages.dart';
import 'package:repara_latam/models/work_order_model.dart';
import 'package:repara_latam/models/workers_model.dart';
import 'package:repara_latam/services/worker_service.dart';

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ApplicationBloc(),
        child: Scaffold(resizeToAvoidBottomInset: false, body: AllHomepage()));
  }
}

class AllHomepage extends StatefulWidget {
  @override
  _AllHomepageState createState() => _AllHomepageState();
}

List<Marker> allMarkers = [];
List<Marker> allMarkersRenderd = [];

class _AllHomepageState extends State<AllHomepage> {
  final auth = FirebaseAuth.instance;

  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  Worker _selectedWorker;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();

    _selectedWorker = new Worker(
      name: "",
      description: "",
      category: "",
      address: "",
      distance: "",
      score: "",
      coverImage: "",
      gallery: ["", "", "", ""],
      locationCoords: new LatLng(0.0, 0.0),
    );

    //List<Marker> allMarkers = [];
    final Future<WorkersList> workers = getWorkers().then((value) {
      value.workers.asMap().forEach((index, element) {
        //print(index);
        //print(element.name);
        //print(element.coverImage);
        //print(element.gallery[0]);
        allMarkers.add(Marker(
          markerId: MarkerId(element.name),
          draggable: false,
          infoWindow: InfoWindow(
            title: element.name + " - " + element.category,
            snippet: '★' + element.score,
            onTap: () {
              setState(() {
                _currentScreen = 50;
                _selectedWorker = element;
                //print(_selectedWorker);
              });
            },
          ),
          position: element.locationCoords,
        ));
      });
      setState(() {
        allMarkersRenderd = allMarkers;
      });
      return null;
    });
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _mapController.setMapStyle(style);
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/images/star_small.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('0'),
        position: LatLng(-33.445995, -70.667057),
        infoWindow:
            InfoWindow(title: 'Punto 1', snippet: 'Descripción Punto 1'),
        icon: _markerIcon,
      ));

      // _markers.add(Marker(
      //   markerId: MarkerId('0'),
      //   position: LatLng(-32.445994, -72.667054),
      //   infoWindow:
      //       InfoWindow(title: 'Punto 1', snippet: 'Descripción Punto 2'),
      //   icon: _markerIcon,
      // ));
    });
    _setMapStyle();
  }

  double _windowWidth = 0;
  double _windowHeight = 0;
  bool _isSmallScreen = false;

  // Options
  //
  // 10: Reparar
  // 11: Subir Foto
  // 12: Mapa
  // 20: Mensajes
  // 21: Mensaje
  // 30: Encargos
  // 31: Encargo
  // 31: Calificar trabajador
  // 40: Perfil
  //
  // 50: Página taller
  // 51: Mapa taller
  // 52: Reviews taller

  double _screen10XOffset = 0;
  double _screen11XOffset = 0;
  double _screen12XOffset = 0;
  double _screen20XOffset = 0;
  double _screen21XOffset = 0;
  double _screen30XOffset = 0;
  double _screen31XOffset = 0;
  double _screen50XOffset = 0;
  double _screen51XOffset = 0;
  double _screen52XOffset = 0;

  double _screen10YOffset = 0;
  double _screen21YOffset = 0;

  double _headerRightBottomCurveXOffset = 0;

  Color _coral = Color(0xFFBFF4949);
  Color _darkBlue = Color(0xFFB021028);

  Color _colorInactiveOption = Color(0xFFB021028).withOpacity(0.35);

  int _selectedOption = 1;
  int _currentScreen = 10;

  bool _isUserQueryValidated = true;

  int _selectedWorkOrder = 0;
  int _selectedMessage = 0;

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    _windowHeight = MediaQuery.of(context).size.height;
    _windowWidth = MediaQuery.of(context).size.width;

    if (_windowWidth <= 400) {
      _isSmallScreen = true;
    }

    switch (_currentScreen) {
      case 10:
        setState(() {
          _screen10XOffset = 0;
          _screen11XOffset = _windowWidth;
          _screen12XOffset = _windowWidth;

          _screen50XOffset = _windowWidth;
          _screen52XOffset = _windowWidth;
        });
        break;
      case 11:
        setState(() {
          _screen10XOffset = -_windowWidth;
          _screen11XOffset = 0;
          _screen12XOffset = _windowWidth;
          _headerRightBottomCurveXOffset = 0;
        });
        break;
      case 12:
        _screen11XOffset = -_windowWidth;
        _screen12XOffset = 0;
        _headerRightBottomCurveXOffset = 70;

        _screen50XOffset = _windowWidth;
        break;
      case 20:
        _screen20XOffset = 0;
        _screen21YOffset = -_windowHeight;
        break;
      case 21:
        _screen20XOffset = 0;
        _screen21YOffset = 0;
        break;
      case 30:
        _screen30XOffset = 0;
        _screen31XOffset = _windowWidth;
        break;
      case 31:
        _screen30XOffset = -_windowWidth;
        _screen31XOffset = 0;
        break;
      case 40:
        break;
      case 50:
        _screen12XOffset = -_windowWidth;
        _screen50XOffset = 0;
        _screen52XOffset = _windowWidth;
        break;
      case 52:
        _screen50XOffset = -_windowWidth;
        _screen52XOffset = 0;
        break;
    }

    _signOut() {
      _selectedOption = null;
      _currentScreen = null;
      auth.signOut().then((value) => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyApp())));
    }

    Future<bool> _confirmSignOut() {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Center(child: Text('Salir')),
                content: Text(
                  '¿Deseas salir de la aplicación o salir de tu cuenta?',
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Center(
                    child: TextButton(
                        onPressed: () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                        child: Text('Salir de la aplicación')),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          _signOut();
                          Navigator.pop(context, true);
                        },
                        child: Text('Salir de mi cuenta')),
                  ),
                  Center(
                      child: TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Cancelar')))
                ],
              ));
    }

    Future<bool> onWillPopOptions() {
      switch (_currentScreen) {
        case 10:
          // _selectedOption = null;
          // _currentScreen = null;
          _confirmSignOut();
          //signOut();
          break;
        case 11:
          setState(() {
            _currentScreen = 10;
          });
          break;
        case 12:
          setState(() {
            _currentScreen = 11;
          });
          break;
        case 20:
          _confirmSignOut();
          break;
        case 21:
          setState(() {
            _currentScreen = 20;
          });
          break;
        case 30:
          _confirmSignOut();
          break;
        case 31:
          setState(() {
            _currentScreen = 30;
          });
          break;
        case 40:
          _confirmSignOut();
          break;
        case 50:
          setState(() {
            _currentScreen = 12;
          });
          break;
        case 52:
          setState(() {
            _currentScreen = 50;
          });
          break;
      }
      //print(_currentScreen);
    }

    return WillPopScope(
      onWillPop: onWillPopOptions,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: _windowHeight - 70,
                //color: Colors.greenAccent,
                child: IndexedStack(
                  index: _selectedOption - 1,
                  children: [
                    // REPARAR
                    Stack(
                      children: [
                        // MAP
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          //color: Colors.yellow.withOpacity(0.21),
                          width: _windowWidth,
                          height: MediaQuery.of(context).size.height,
                          transform:
                              Matrix4.translationValues(_screen12XOffset, 0, 0),
                          child: Stack(
                            children: [
                              // MAP PLACEHOLDER
                              Container(
                                width: _windowWidth,
                                // child: Image.asset(
                                //   "assets/images/temp_map.png",
                                //   fit: BoxFit.cover,
                                // ),

                                child: (applicationBloc.currentLocation == null || allMarkersRenderd.length==0)
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : GoogleMap(
                                        onMapCreated: _onMapCreated,
                                        mapType: MapType.normal,
                                        myLocationEnabled: true,
                                        initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                -33.445995, -70.667057

                                                // SETS USER LOCATION
                                                // applicationBloc
                                                //     .currentLocation.latitude,
                                                // applicationBloc
                                                //     .currentLocation.longitude

                                                ),
                                            zoom: 13),
                                        markers: Set.from(allMarkersRenderd),
                                      ),
                              ),
                              //STARS
                              // STARS
                              // Stack(
                              //   children: [
                              //     // GOLDEN STAR
                              //     Positioned(
                              //       top: 70,
                              //       left: 21,
                              //       width: 100,
                              //       height: 100,
                              //       child: GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             _currentScreen = 50;
                              //           });
                              //         },
                              //         child: Stack(
                              //           children: [
                              //             Align(
                              //               alignment: Alignment.center,
                              //               child: Stack(
                              //                 alignment:
                              //                     AlignmentDirectional.center,
                              //                 children: [
                              //                   Icon(Icons.location_on,
                              //                       size: 75, color: _coral),
                              //                   Icon(Icons.location_on,
                              //                       size: 70,
                              //                       color: Colors.white),
                              //                 ],
                              //               ),
                              //             ),
                              //             Container(
                              //               margin: EdgeInsets.only(
                              //                 bottom: 21,
                              //               ),
                              //               child: Align(
                              //                 alignment: Alignment.center,
                              //                 child: Icon(
                              //                     Icons.star_rate_rounded,
                              //                     size: 35,
                              //                     color: Colors.amberAccent),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     // SILVER STAR
                              //     Positioned(
                              //       top: 140,
                              //       left: 280,
                              //       width: 100,
                              //       height: 100,
                              //       child: GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             _currentScreen = 50;
                              //           });
                              //         },
                              //         child: Stack(
                              //           children: [
                              //             Align(
                              //               alignment: Alignment.center,
                              //               child: Stack(
                              //                 alignment:
                              //                     AlignmentDirectional.center,
                              //                 children: [
                              //                   Icon(Icons.location_on,
                              //                       size: 75, color: _coral),
                              //                   Icon(Icons.location_on,
                              //                       size: 70,
                              //                       color: Colors.white),
                              //                 ],
                              //               ),
                              //             ),
                              //             Container(
                              //               margin: EdgeInsets.only(
                              //                 bottom: 21,
                              //               ),
                              //               child: Align(
                              //                 alignment: Alignment.center,
                              //                 child: Icon(
                              //                   Icons.star_rate_rounded,
                              //                   size: 35,
                              //                   color: Color(0xFFBDEDEDE),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     // GOLDEN STAR
                              //     Positioned(
                              //       top: 280,
                              //       left: 140,
                              //       width: 100,
                              //       height: 100,
                              //       child: GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             _currentScreen = 50;
                              //           });
                              //         },
                              //         child: Stack(
                              //           children: [
                              //             Align(
                              //               alignment: Alignment.center,
                              //               child: Stack(
                              //                 alignment:
                              //                     AlignmentDirectional.center,
                              //                 children: [
                              //                   Icon(Icons.location_on,
                              //                       size: 75, color: _coral),
                              //                   Icon(Icons.location_on,
                              //                       size: 70,
                              //                       color: Colors.white),
                              //                 ],
                              //               ),
                              //             ),
                              //             Container(
                              //               margin: EdgeInsets.only(
                              //                 bottom: 21,
                              //               ),
                              //               child: Align(
                              //                 alignment: Alignment.center,
                              //                 child: Icon(
                              //                     Icons.star_rate_rounded,
                              //                     size: 35,
                              //                     color: Colors.amberAccent),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     // GOLDEN STAR
                              //     Positioned(
                              //       top: 350,
                              //       left: 280,
                              //       width: 100,
                              //       height: 100,
                              //       child: GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             _currentScreen = 50;
                              //           });
                              //         },
                              //         child: Stack(
                              //           children: [
                              //             Align(
                              //               alignment: Alignment.center,
                              //               child: Stack(
                              //                 alignment:
                              //                     AlignmentDirectional.center,
                              //                 children: [
                              //                   Icon(Icons.location_on,
                              //                       size: 75, color: _coral),
                              //                   Icon(Icons.location_on,
                              //                       size: 70,
                              //                       color: Colors.white),
                              //                 ],
                              //               ),
                              //             ),
                              //             Container(
                              //               margin: EdgeInsets.only(
                              //                 bottom: 21,
                              //               ),
                              //               child: Align(
                              //                 alignment: Alignment.center,
                              //                 child: Icon(
                              //                     Icons.star_rate_rounded,
                              //                     size: 35,
                              //                     color: Colors.amberAccent),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     // BRONZE STAR
                              //     Positioned(
                              //       top: 420,
                              //       left: 140,
                              //       width: 100,
                              //       height: 100,
                              //       child: GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             _currentScreen = 50;
                              //           });
                              //         },
                              //         child: Stack(
                              //           children: [
                              //             Align(
                              //               alignment: Alignment.center,
                              //               child: Stack(
                              //                 alignment:
                              //                     AlignmentDirectional.center,
                              //                 children: [
                              //                   Icon(Icons.location_on,
                              //                       size: 75, color: _coral),
                              //                   Icon(Icons.location_on,
                              //                       size: 70,
                              //                       color: Colors.white),
                              //                 ],
                              //               ),
                              //             ),
                              //             Container(
                              //               margin: EdgeInsets.only(
                              //                 bottom: 21,
                              //               ),
                              //               child: Align(
                              //                 alignment: Alignment.center,
                              //                 child: Icon(
                              //                   Icons.star_rate_rounded,
                              //                   size: 35,
                              //                   color: Color(0xFFEBB580),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     // SILVER STAR
                              //     Positioned(
                              //       top: 490,
                              //       left: 77,
                              //       width: 100,
                              //       height: 100,
                              //       child: GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             _currentScreen = 50;
                              //           });
                              //         },
                              //         child: Stack(
                              //           children: [
                              //             Align(
                              //               alignment: Alignment.center,
                              //               child: Stack(
                              //                 alignment:
                              //                     AlignmentDirectional.center,
                              //                 children: [
                              //                   Icon(Icons.location_on,
                              //                       size: 75, color: _coral),
                              //                   Icon(Icons.location_on,
                              //                       size: 70,
                              //                       color: Colors.white),
                              //                 ],
                              //               ),
                              //             ),
                              //             Container(
                              //               margin: EdgeInsets.only(
                              //                 bottom: 21,
                              //               ),
                              //               child: Align(
                              //                 alignment: Alignment.center,
                              //                 child: Icon(
                              //                   Icons.star_rate_rounded,
                              //                   size: 35,
                              //                   color: Color(0xFFBDEDEDE),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        // ADDRESS HEADER
                        Container(
                          child: Column(
                            children: [
                              // ADDRESS
                              Container(
                                width: double.infinity,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: _coral,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(100),
                                    )),
                                child: SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 49),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.white,
                                        ),
                                        Center(
                                          child: Text(
                                            ' Santiago 1320, Región Metropolitana',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // RIGHT BOTTOM CURVE
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1800),
                                curve: Curves.fastLinearToSlowEaseIn,
                                transform: Matrix4.translationValues(
                                    _headerRightBottomCurveXOffset, 0, 0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                        color: _coral,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(100))),
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(100),
                                          bottomLeft: Radius.circular(90),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // BODY: ¿Qué deseas reparar?
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          //color: Colors.yellow,
                          height: MediaQuery.of(context).size.height * 0.75,
                          transform: Matrix4.translationValues(
                              _screen10XOffset, 100, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 49),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // TITLE AND INPUT
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // TITLE
                                    Container(
                                      width: 210,
                                      child: Text(
                                        '¿Qué deseas reparar?',
                                        style: TextStyle(
                                            color: _darkBlue,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    // INPUT
                                    Container(
                                      margin: EdgeInsets.only(top: 21),
                                      width: _isSmallScreen ? 280 : 320,
                                      child: TextField(
                                        maxLength: 30,
                                        keyboardType: TextInputType.text,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 35,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Botas de Cuero...',
                                          hintStyle: TextStyle(
                                            color: _darkBlue.withOpacity(0.21),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // FAB
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      setState(() {
                                        _currentScreen = 11;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: 28,
                                        right: 14,
                                      ),
                                      width: 63,
                                      height: 63,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: _isUserQueryValidated
                                              ? _coral
                                              : _darkBlue.withOpacity(0.07)),
                                      child: Icon(Icons.chevron_right,
                                          color: _isUserQueryValidated
                                              ? Colors.white
                                              : _colorInactiveOption),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // BODY: Subir Foto
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          //color: Colors.yellow.withOpacity(0.21),
                          width: _windowWidth,
                          height: _isSmallScreen
                              ? _windowHeight * 0.75
                              : _windowHeight * 0.80,
                          transform: Matrix4.translationValues(
                              _screen11XOffset, 75, 0),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 49,
                                ),
                                child: ListView(
                                  addAutomaticKeepAlives: false,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // TITLE
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'Toma una foto de tu artículo',
                                        style: TextStyle(
                                            color: _darkBlue,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    // TAKE PICTURE
                                    Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 21),
                                          padding: EdgeInsets.all(21),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _coral, width: 2),
                                          ),
                                          child: Image.asset(
                                              "assets/images/boots_square_compressed.png"),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75),
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100),
                                                ),
                                                border: Border.all(
                                                    color: _coral, width: 2),
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor),
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: _coral,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    // SEPARATOR
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 21),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '--------------',
                                            style: TextStyle(
                                                color: _colorInactiveOption),
                                          ),
                                          Text(
                                            '       O       ',
                                            style: TextStyle(
                                                color: _colorInactiveOption),
                                          ),
                                          Text(
                                            '--------------',
                                            style: TextStyle(
                                                color: _colorInactiveOption),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // UPLOAD FILE
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.image_outlined,
                                          color: _coral,
                                          size: 72,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 7),
                                          child: Text(
                                            'Selecciona una imagen de la galería',
                                            style: TextStyle(color: _darkBlue),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 7),
                                          child: Text(
                                            'foto_botas.jpg',
                                            style: TextStyle(
                                                color: _colorInactiveOption),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // CONTINUE
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 70, bottom: 28),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _currentScreen = 12;
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Saltar este paso',
                                            style: TextStyle(
                                                color: _colorInactiveOption),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // FAB
                              Container(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      setState(() {
                                        _currentScreen = 12;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 21),
                                      width: 63,
                                      height: 63,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: _isUserQueryValidated
                                              ? _coral
                                              : _darkBlue.withOpacity(0.07)),
                                      child: Icon(Icons.chevron_right,
                                          color: _isUserQueryValidated
                                              ? Colors.white
                                              : _colorInactiveOption),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // WORKER PAGE
                        //-- // SIZE DEFINER
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          //width: _windowWidth,
                          height: _windowHeight,
                          transform:
                              Matrix4.translationValues(_screen50XOffset, 0, 0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // CONTENT
                              ListView(
                                children: [
                                  // PICTURE
                                  Container(
                                    height: 210,
                                    transform:
                                        Matrix4.translationValues(0, -25, 0),
                                    child: Image.asset(
                                      _selectedWorker.coverImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // TITLE
                                  Container(
                                    //margin: EdgeInsets.only(top: 21),
                                    child: Center(
                                      child: Text(
                                        _selectedWorker.name +
                                            " - " +
                                            _selectedWorker.category,
                                        style: TextStyle(
                                            color: _darkBlue,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  // DISTANCE
                                  Container(
                                    margin: EdgeInsets.only(top: 14),
                                    child: Center(
                                      child: Text(
                                        _selectedWorker.distance,
                                        style: TextStyle(
                                          color: _darkBlue.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // RATING
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        //print('Click reviews');
                                        _currentScreen = 52;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star_rate_rounded,
                                            color: _coral,
                                          ),
                                          // Icon(
                                          //   Icons.star_rate_rounded,
                                          //   color: _coral,
                                          // ),
                                          // Icon(
                                          //   Icons.star_rate_rounded,
                                          //   color: _coral,
                                          // ),
                                          // Icon(
                                          //   Icons.star_rate_rounded,
                                          //   color: _coral,
                                          // ),
                                          // Icon(
                                          //   Icons.star_half_rounded,
                                          //   color: _coral,
                                          // ),
                                          Text(_selectedWorker.score),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // DESCRIPTION
                                  Align(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 21),
                                      width: _windowWidth * 0.77,
                                      child: Text(
                                        _selectedWorker.description,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  // GALLERY
                                  Container(
                                    margin: EdgeInsets.only(top: 28),
                                    width: _windowWidth,
                                    height: _windowWidth,
                                    child: GridView.count(
                                      physics: NeverScrollableScrollPhysics(),
                                      crossAxisCount: 2,
                                      children: [
                                        Image.asset(
                                          _selectedWorker.gallery[0],
                                          fit: BoxFit.cover,
                                        ),
                                        Image.asset(
                                          _selectedWorker.gallery[1],
                                          fit: BoxFit.cover,
                                        ),
                                        Image.asset(
                                          _selectedWorker.gallery[2],
                                          fit: BoxFit.cover,
                                        ),
                                        Image.asset(
                                          _selectedWorker.gallery[3],
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // BTN CONTACTAR
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    //print('Contactar');
                                    _currentScreen = 21;
                                    _selectedOption = 2;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 14),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: PrimaryButton(
                                      btnText: 'CONTACTAR',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // REVIEWS PLACEHOLDER
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          //color: Colors.yellow.withOpacity(0.21),
                          //width: _windowWidth,
                          //height: MediaQuery.of(context).size.height * 0.77,
                          transform:
                              Matrix4.translationValues(_screen52XOffset, 0, 0),
                          child: Container(
                            width: _windowWidth,
                            height: _windowHeight - 70,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 25),
                                    child: Image.asset(
                                      'assets/images/temp_reviews.png',
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  //Expanded(child: Container()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // MENSAJES
                    Stack(
                      children: [
                        // HEADER
                        Column(
                          children: [
                            // TITLE
                            Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: _coral,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                  )),
                              child: SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 77),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'MENSAJES',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // RIGHT BOTTOM CURVE
                            AnimatedContainer(
                              duration: Duration(milliseconds: 1800),
                              curve: Curves.fastLinearToSlowEaseIn,
                              transform: Matrix4.translationValues(0, 0, 0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                      color: _coral,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(100))),
                                  child: Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(90),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        // MESSAGES
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          transform:
                              Matrix4.translationValues(_screen20XOffset, 0, 0),
                          child: Container(
                            margin: EdgeInsets.only(top: 100),
                            width: _windowWidth,
                            height: _windowHeight - 170,
                            //color: Colors.blue,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SEARCH BAR
                                Container(
                                  margin: EdgeInsets.only(bottom: 21),
                                  //padding: EdgeInsets.all(21),
                                  height: 49,
                                  width: _isSmallScreen
                                      ? _windowWidth * 0.91
                                      : _windowWidth * 0.77,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 7,
                                        offset: Offset(3, 3),
                                      )
                                    ],
                                    color: _darkBlue.withOpacity(0.04),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 21),
                                        child: Icon(
                                          Icons.search_rounded,
                                          color: _darkBlue.withOpacity(0.49),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 7),
                                          width: 210,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Buscar...',
                                              hintStyle: TextStyle(
                                                color:
                                                    _darkBlue.withOpacity(0.49),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // MESSAGE CARD
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _currentScreen = 21;
                                            _selectedMessage = index;
                                          });
                                        },
                                        child: Align(
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 35),
                                            width: _isSmallScreen
                                                ? _windowWidth * 0.91
                                                : _windowWidth * 0.77,
                                            height: 70,
                                            //color: Colors.red,
                                            child: Row(
                                              //crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // PROFILE PICTURE
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 14),
                                                  height: 70,
                                                  width: 70,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(100),
                                                    ),
                                                    child: Image.asset(
                                                      messages[index]
                                                          .workerPicture,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                // BODY MESSAGE
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      // NAME AND TIME
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              messages[index]
                                                                  .workerId,
                                                              style: TextStyle(
                                                                fontWeight: messages[index]
                                                                            .amountUnread !=
                                                                        '0'
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .w500,
                                                                color: messages[index]
                                                                            .amountUnread !=
                                                                        '0'
                                                                    ? _darkBlue
                                                                        .withOpacity(
                                                                            0.84)
                                                                    : _darkBlue
                                                                        .withOpacity(
                                                                            0.77),
                                                              ),
                                                            ),
                                                            Text(
                                                              messages[index]
                                                                  .timeSent,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                                color: messages[index]
                                                                            .amountUnread !=
                                                                        '0'
                                                                    ? _coral
                                                                    : _darkBlue
                                                                        .withOpacity(
                                                                            0.35),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // MESSAGE AND NOTIFICATION
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // MESSAGE
                                                          Expanded(
                                                            child: Text(
                                                              messages[index]
                                                                  .message,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  height: 1.4),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          // NOTIFICATION
                                                          Visibility(
                                                            visible: messages[
                                                                        index]
                                                                    .amountUnread !=
                                                                '0',
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 14),
                                                              width: 21,
                                                              height: 21,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: _coral,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          21),
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  messages[
                                                                          index]
                                                                      .amountUnread,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: 7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // MESSAGE
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          transform:
                              Matrix4.translationValues(0, _screen21YOffset, 0),
                          child: Container(
                            width: _windowWidth,
                            height: _windowHeight - 70,
                            color: _darkBlue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // HEADER
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        //print('Worker profile clicked');
                                      });
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 25),
                                        width: _isSmallScreen
                                            ? _windowWidth * 0.91
                                            : _windowWidth * 0.77,
                                        height: 70,
                                        //color: Colors.red,
                                        child: Row(
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // PROFILE PICTURE
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 21),
                                              height: 70,
                                              width: 70,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100),
                                                ),
                                                child: Image.asset(
                                                  messages[_selectedMessage]
                                                      .workerPicture,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            // NAME AND CATEGORY
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // NAME
                                                Text(
                                                  messages[_selectedMessage]
                                                      .workerId,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                // CATEGORY
                                                Text(
                                                  messages[_selectedMessage]
                                                      .workerCategories,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    height: 1.4,
                                                    color: Colors.white
                                                        .withOpacity(0.70),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // CHAT AREA
                                Container(
                                  width: _windowWidth,
                                  height: _windowHeight * 0.7,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35),
                                      topRight: Radius.circular(35),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      // TODAY MESSAGE
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 14,
                                        ),
                                        child: Text(
                                          'TODAY',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  _darkBlue.withOpacity(0.35)),
                                        ),
                                      ),
                                      // CHAT PLACEHOLDER
                                      Expanded(
                                        //height: 200,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: _windowWidth * 0.9,
                                                child: Image.asset(
                                                  'assets/images/temp_chat.png',
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              //Expanded(child: Container()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // INPUT BAR
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 21),
                                        margin: EdgeInsets.only(
                                            bottom: 21, top: 21),
                                        //padding: EdgeInsets.all(21),
                                        height: 49,
                                        width: _windowWidth * 0.77,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              offset: Offset(3, 3),
                                            )
                                          ],
                                          color: _darkBlue.withOpacity(0.04),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: _windowWidth * 0.42,
                                              child: TextField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'Escribe tu mensaje aquí...',
                                                  hintStyle: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: _darkBlue
                                                        .withOpacity(0.49),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // ATTACH ICON
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: _windowWidth * 0.01),
                                              child: Icon(
                                                Icons.attach_file_rounded,
                                                color:
                                                    _darkBlue.withOpacity(0.49),
                                              ),
                                            ),
                                            // SEND ICON
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: _windowWidth * 0.01),
                                              width: 28,
                                              height: 28,
                                              decoration: BoxDecoration(
                                                color: _coral,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(21),
                                                ),
                                              ),
                                              child: Icon(Icons.send_rounded,
                                                  color: Colors.white,
                                                  size: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ENCARGOS
                    Stack(
                      children: [
                        //HEADER
                        Container(
                          child: Column(
                            children: [
                              // TITLE
                              Container(
                                width: double.infinity,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: _coral,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(100),
                                    )),
                                child: SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 77),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'TUS ENCARGOS',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // RIGHT BOTTOM CURVE
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1800),
                                curve: Curves.fastLinearToSlowEaseIn,
                                transform: Matrix4.translationValues(0, 0, 0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                        color: _coral,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(100))),
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(100),
                                          bottomLeft: Radius.circular(90),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // SMALL CARD
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          transform:
                              Matrix4.translationValues(_screen30XOffset, 0, 0),
                          child: Container(
                            margin: EdgeInsets.only(top: 70),
                            height: _windowHeight - 140,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _currentScreen = 31;
                                        _selectedWorkOrder = index;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 35),
                                      width: _isSmallScreen
                                          ? _windowWidth * 0.91
                                          : MediaQuery.of(context).size.width *
                                              0.77,
                                      height: 100,
                                      decoration: (BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(21),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.49),
                                            spreadRadius: 0,
                                            blurRadius: 7,
                                            offset: Offset(3, 3),
                                          )
                                        ],
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 17),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // IMAGE
                                            Container(
                                              height: 63,
                                              width: 63,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(7),
                                                ),
                                                child: Image.asset(
                                                  workOrders[index].image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            // CONTENT MIDDLE
                                            Container(
                                              //color: Colors.blue,
                                              width: 140,
                                              padding:
                                                  EdgeInsets.only(left: 14),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    workOrders[index].title,
                                                    style: TextStyle(
                                                        color: _darkBlue),
                                                  ),
                                                  Text(
                                                    "\$" +
                                                        workOrders[index].cost,
                                                    style: TextStyle(
                                                      color: _darkBlue
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // CONTENT RIGHT
                                            Container(
                                              //color: Colors.red,
                                              width: 93,
                                              padding:
                                                  EdgeInsets.only(left: 14),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    workOrders[index].status,
                                                    style: TextStyle(
                                                      color: workOrders[index]
                                                                  .status ==
                                                              "Aguardando Colecta"
                                                          ? Color(0xFFFFAA00)
                                                          : workOrders[index]
                                                                      .status ==
                                                                  "En Progreso"
                                                              ? Color(
                                                                  0xFF5BADFF)
                                                              : Color(
                                                                  0xFF6DD132),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Ver detalles',
                                                    style: TextStyle(
                                                      color: _darkBlue
                                                          .withOpacity(0.7),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: workOrders.length,
                            ),
                          ),
                        ),
                        // EXPANDED CARD
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          transform:
                              Matrix4.translationValues(_screen31XOffset, 0, 0),
                          child: Center(
                            child: Container(
                              margin: _isSmallScreen
                                  ? EdgeInsets.only(top: 25)
                                  : EdgeInsets.only(top: 110, bottom: 21),
                              width: _isSmallScreen
                                  ? _windowWidth * 0.91
                                  : MediaQuery.of(context).size.width * 0.77,
                              //height: _windowHeight * 0.7,
                              decoration: (BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.49),
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: Offset(3, 3),
                                  )
                                ],
                              )),
                              child: Padding(
                                padding: const EdgeInsets.all(17),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // ID AND STATUS
                                    Container(
                                      margin: EdgeInsets.only(bottom: 14),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // ID
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 7),
                                                child: Text(
                                                  'Encargo #',
                                                  style: TextStyle(
                                                    color: _darkBlue
                                                        .withOpacity(0.35),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                workOrders[_selectedWorkOrder]
                                                    .id,
                                              ),
                                            ],
                                          ),
                                          // STATUS
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 7),
                                                child: Text(
                                                  'Status',
                                                  style: TextStyle(
                                                    color: _darkBlue
                                                        .withOpacity(0.35),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                workOrders[_selectedWorkOrder]
                                                    .status,
                                                style: TextStyle(
                                                  color: workOrders[
                                                                  _selectedWorkOrder]
                                                              .status ==
                                                          "Aguardando Colecta"
                                                      ? Color(0xFFFFAA00)
                                                      : workOrders[_selectedWorkOrder]
                                                                  .status ==
                                                              "En Progreso"
                                                          ? Color(0xFF5BADFF)
                                                          : Color(0xFF6DD132),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // STATUS BAR
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 21,
                                      ),
                                      child: Image.asset(
                                        "assets/images/temp_progress_recolored2.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // IMAGE AND DESCRIPTION
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 14,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // IMAGE
                                          Container(
                                            height: 100,
                                            width: 100,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(7),
                                              ),
                                              child: Image.asset(
                                                workOrders[_selectedWorkOrder]
                                                    .image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          // TITLE AND DESCRIPTION
                                          Expanded(
                                            // color: Colors.red,
                                            // width: 100,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 14),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    //color: Colors.black,
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        workOrders[
                                                                _selectedWorkOrder]
                                                            .title,
                                                        style: TextStyle(
                                                            color: _darkBlue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    workOrders[
                                                            _selectedWorkOrder]
                                                        .description,
                                                    style: TextStyle(
                                                        color: _darkBlue,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // WORKER
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 14,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            //print('Clicked worker link');
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                bottom: 4,
                                              ),
                                              child: Text(
                                                'Reparación por',
                                                style: TextStyle(
                                                  color: _darkBlue,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  workOrders[_selectedWorkOrder]
                                                      .workerId,
                                                  style: TextStyle(
                                                    color: _darkBlue,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 7),
                                                  child: Icon(
                                                    Icons.open_in_new_rounded,
                                                    size: 14,
                                                    color: _coral,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // DATES
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 14,
                                      ),
                                      width: _windowWidth * 0.47,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 7),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Inicio del Encargo',
                                                      style: TextStyle(
                                                        color: _darkBlue
                                                            .withOpacity(0.70),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      workOrders[
                                                              _selectedWorkOrder]
                                                          .start,
                                                      style: TextStyle(
                                                        color: _darkBlue,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Fin del Encargo',
                                                    style: TextStyle(
                                                      color: _darkBlue
                                                          .withOpacity(0.70),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    workOrders[_selectedWorkOrder]
                                                                .end !=
                                                            'En Progreso'
                                                        ? workOrders[
                                                                _selectedWorkOrder]
                                                            .end
                                                        : 'En Progreso',
                                                    style: TextStyle(
                                                      color:
                                                          workOrders[_selectedWorkOrder]
                                                                      .end ==
                                                                  'En Progreso'
                                                              ? _darkBlue
                                                                  .withOpacity(
                                                                      0.35)
                                                              : _darkBlue,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // DETAILS AND COST
                                    Container(
                                      width: _windowWidth * 0.58,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Duración Estimada',
                                                  style: TextStyle(
                                                    color: _darkBlue
                                                        .withOpacity(0.70),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  workOrders[_selectedWorkOrder]
                                                      .estimate,
                                                  style: TextStyle(
                                                    color: _darkBlue,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Garantía',
                                                  style: TextStyle(
                                                    color: _darkBlue
                                                        .withOpacity(0.70),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  workOrders[_selectedWorkOrder]
                                                      .warranty,
                                                  style: TextStyle(
                                                    color: _darkBlue,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Método de pago',
                                                  style: TextStyle(
                                                    color: _darkBlue
                                                        .withOpacity(0.70),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  workOrders[_selectedWorkOrder]
                                                      .paymentMethod,
                                                  style: TextStyle(
                                                    color: _darkBlue,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Confianza del reparador',
                                                style: TextStyle(
                                                  color: _darkBlue
                                                      .withOpacity(0.70),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 4),
                                                    child: Text(
                                                      workOrders[
                                                              _selectedWorkOrder]
                                                          .workerConfidence,
                                                      style: TextStyle(
                                                        color: _darkBlue,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    workOrders[_selectedWorkOrder]
                                                                .workerConfidence ==
                                                            "Alta"
                                                        ? Icons
                                                            .signal_cellular_4_bar_rounded
                                                        : workOrders[_selectedWorkOrder]
                                                                    .workerConfidence ==
                                                                "Media"
                                                            ? Icons
                                                                .signal_cellular_off_rounded
                                                            : Icons
                                                                .signal_cellular_null_rounded,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 0.7,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Costo',
                                                style: TextStyle(
                                                  color: _darkBlue
                                                      .withOpacity(0.70),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                "\$" +
                                                    workOrders[
                                                            _selectedWorkOrder]
                                                        .cost,
                                                style: TextStyle(
                                                  color: _darkBlue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    // ESCONDER DETALLES
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _currentScreen = 30;
                                        });
                                      },
                                      child: Text(
                                        'Esconder detalles',
                                        style: TextStyle(
                                          color: _darkBlue.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // PERFIL
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // HEADER
                        Container(
                          child: Column(
                            children: [
                              // TITLE
                              Container(
                                width: double.infinity,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: _coral,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(100),
                                    )),
                                child: SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 77),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'TU PERFIL',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // RIGHT BOTTOM CURVE
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1800),
                                curve: Curves.fastLinearToSlowEaseIn,
                                transform: Matrix4.translationValues(0, 0, 0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                        color: _coral,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(100))),
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(100),
                                          bottomLeft: Radius.circular(90),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // CONTENT
                        Container(
                          width: _windowWidth,
                          height: MediaQuery.of(context).size.height * 0.63,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.handyman_rounded,
                                size: 140,
                                color: _coral,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print(_windowWidth);
                                  print(_windowHeight);
                                  print(_isSmallScreen);
                                },
                                child: Text(
                                  'En Desarrollo',
                                  style: TextStyle(
                                      color: _coral,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // BOTTOM OPTION BAR
          Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: _darkBlue.withOpacity(0.21),
                ),
              ),
            ),
            child: Row(
              children: [
                // BTN OPTION 1
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 1;
                          _currentScreen = 10;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hardware,
                            color: _selectedOption == 1
                                ? _coral
                                : _colorInactiveOption,
                          ),
                          Text(
                            'Reparar',
                            style: TextStyle(
                              color: _selectedOption == 1
                                  ? _coral
                                  : _colorInactiveOption,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // BTN OPTION 2
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 2;
                            _currentScreen = 20;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.messenger_outline_rounded,
                              color: _selectedOption == 2
                                  ? _coral
                                  : _colorInactiveOption,
                            ),
                            Text(
                              'Mensajes',
                              style: TextStyle(
                                color: _selectedOption == 2
                                    ? _coral
                                    : _colorInactiveOption,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // BTN OPTION 3
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 3;
                            _currentScreen = 30;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_rounded,
                              color: _selectedOption == 3
                                  ? _coral
                                  : _colorInactiveOption,
                            ),
                            Text(
                              'Encargos',
                              style: TextStyle(
                                color: _selectedOption == 3
                                    ? _coral
                                    : _colorInactiveOption,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // BTN OPTION 4
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 4;
                            _currentScreen = 40;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              color: _selectedOption == 4
                                  ? _coral
                                  : _colorInactiveOption,
                            ),
                            Text(
                              'Perfil',
                              style: TextStyle(
                                color: _selectedOption == 4
                                    ? _coral
                                    : _colorInactiveOption,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
