import 'package:flutter/material.dart';
import 'package:repara_latam/models/work_order_model.dart';

class Encargos extends StatelessWidget {
  const Encargos({
    Key key,
    updateCurrentScreen,
    @required int currentScreen,
    @required Color coral,
    @required Color darkBlue,
    @required double screen30XOffset,
    @required double screen31XOffset,
    @required double windowHeight,
    @required double windowWidth,
    @required bool isSmallScreen,
  })  : _updateCurrentScreen = updateCurrentScreen,
        _currentScreen = currentScreen,
        _coral = coral,
        _darkBlue = darkBlue,
        _screen30XOffset = screen30XOffset,
        _screen31XOffset = screen31XOffset,
        _windowHeight = windowHeight,
        _windowWidth = windowWidth,
        _isSmallScreen = isSmallScreen,
        super(key: key);

  final _updateCurrentScreen;
  final _currentScreen;
  final Color _coral;
  final Color _darkBlue;
  final _screen30XOffset;
  final _screen31XOffset;
  final _windowHeight;
  final _windowWidth;
  final _isSmallScreen;

  final int _selectedWorkOrder = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TUS ENCARGOS',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    decoration:
                        BoxDecoration(color: _coral, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
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
          transform: Matrix4.translationValues(_screen30XOffset, 0, 0),
          child: Container(
            margin: EdgeInsets.only(top: 70),
            height: _windowHeight - 140,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      _updateCurrentScreen(31);
                      // setState(() {
                      //   _currentScreen = 31;
                      //   _selectedWorkOrder = index;
                      // });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 35),
                      width: _isSmallScreen ? _windowWidth * 0.91 : MediaQuery.of(context).size.width * 0.77,
                      height: 100,
                      decoration: (BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
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
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              padding: EdgeInsets.only(left: 14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workOrders[index].title,
                                    style: TextStyle(color: _darkBlue),
                                  ),
                                  Text(
                                    "\$" + workOrders[index].cost,
                                    style: TextStyle(
                                      color: _darkBlue.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // CONTENT RIGHT
                            Container(
                              //color: Colors.red,
                              width: 93,
                              padding: EdgeInsets.only(left: 14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    workOrders[index].status,
                                    style: TextStyle(
                                      color: workOrders[index].status == "Aguardando Colecta"
                                          ? Color(0xFFFFAA00)
                                          : workOrders[index].status == "En Progreso"
                                              ? Color(0xFF5BADFF)
                                              : Color(0xFF6DD132),
                                    ),
                                  ),
                                  Text(
                                    'Ver detalles',
                                    style: TextStyle(
                                      color: _darkBlue.withOpacity(0.7),
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
          transform: Matrix4.translationValues(_screen31XOffset, 0, 0),
          child: Center(
            child: Container(
              margin: _isSmallScreen ? EdgeInsets.only(top: 25) : EdgeInsets.only(top: 110, bottom: 21),
              width: _isSmallScreen ? _windowWidth * 0.91 : MediaQuery.of(context).size.width * 0.77,
              height: _windowHeight >= 750 ? _windowHeight * 0.63 : null,
              decoration: (BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ID
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 7),
                                child: Text(
                                  'Encargo #',
                                  style: TextStyle(
                                    color: _darkBlue.withOpacity(0.35),
                                  ),
                                ),
                              ),
                              Text(
                                workOrders[_selectedWorkOrder].id,
                              ),
                            ],
                          ),
                          // STATUS
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 7),
                                child: Text(
                                  'Status',
                                  style: TextStyle(
                                    color: _darkBlue.withOpacity(0.35),
                                  ),
                                ),
                              ),
                              Text(
                                workOrders[_selectedWorkOrder].status,
                                style: TextStyle(
                                  color: workOrders[_selectedWorkOrder].status == "Aguardando Colecta"
                                      ? Color(0xFFFFAA00)
                                      : workOrders[_selectedWorkOrder].status == "En Progreso"
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                workOrders[_selectedWorkOrder].image,
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
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        workOrders[_selectedWorkOrder].title,
                                        style: TextStyle(color: _darkBlue, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    workOrders[_selectedWorkOrder].description,
                                    style: TextStyle(color: _darkBlue, fontSize: 12),
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
                          print('Clicked worker link');
                          // setState(() {
                          //   //print('Clicked worker link');
                          // });
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  workOrders[_selectedWorkOrder].workerId,
                                  style: TextStyle(
                                    color: _darkBlue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 7),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Inicio del Encargo',
                                      style: TextStyle(
                                        color: _darkBlue.withOpacity(0.70),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      workOrders[_selectedWorkOrder].start,
                                      style: TextStyle(
                                        color: _darkBlue,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Fin del Encargo',
                                    style: TextStyle(
                                      color: _darkBlue.withOpacity(0.70),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    workOrders[_selectedWorkOrder].end != 'En Progreso'
                                        ? workOrders[_selectedWorkOrder].end
                                        : 'En Progreso',
                                    style: TextStyle(
                                      color: workOrders[_selectedWorkOrder].end == 'En Progreso'
                                          ? _darkBlue.withOpacity(0.35)
                                          : _darkBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Duración Estimada',
                                  style: TextStyle(
                                    color: _darkBlue.withOpacity(0.70),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  workOrders[_selectedWorkOrder].estimate,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Garantía',
                                  style: TextStyle(
                                    color: _darkBlue.withOpacity(0.70),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  workOrders[_selectedWorkOrder].warranty,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Método de pago',
                                  style: TextStyle(
                                    color: _darkBlue.withOpacity(0.70),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  workOrders[_selectedWorkOrder].paymentMethod,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Confianza del reparador',
                                style: TextStyle(
                                  color: _darkBlue.withOpacity(0.70),
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 4),
                                    child: Text(
                                      workOrders[_selectedWorkOrder].workerConfidence,
                                      style: TextStyle(
                                        color: _darkBlue,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    workOrders[_selectedWorkOrder].workerConfidence == "Alta"
                                        ? Icons.signal_cellular_4_bar_rounded
                                        : workOrders[_selectedWorkOrder].workerConfidence == "Media"
                                            ? Icons.signal_cellular_off_rounded
                                            : Icons.signal_cellular_null_rounded,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Costo',
                                style: TextStyle(
                                  color: _darkBlue.withOpacity(0.70),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "\$" + workOrders[_selectedWorkOrder].cost,
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
                        _updateCurrentScreen(30);
                        // setState(() {
                        //   _currentScreen = 30;
                        // });
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
    );
  }
}

//
// Stack Encargos(BuildContext context) {
//   // TEMPORARY: THESE SHOULD ALL BE GLOBAL VARIABLES
//
//   Color _coral = Color(0xFFBFF4949);
//   Color _darkBlue = Color(0xFFB021028);
//
//   return Stack(
//     children: [
//       //HEADER
//       Container(
//         child: Column(
//           children: [
//             // TITLE
//             Container(
//               width: double.infinity,
//               height: 70,
//               decoration: BoxDecoration(
//                   color: _coral,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(100),
//                   )),
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 77),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'TUS ENCARGOS',
//                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // RIGHT BOTTOM CURVE
//             AnimatedContainer(
//               duration: Duration(milliseconds: 1800),
//               curve: Curves.fastLinearToSlowEaseIn,
//               transform: Matrix4.translationValues(0, 0, 0),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: Container(
//                   width: 56,
//                   height: 56,
//                   decoration:
//                       BoxDecoration(color: _coral, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
//                   child: Container(
//                     width: 56,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).scaffoldBackgroundColor,
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(100),
//                         bottomLeft: Radius.circular(90),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       // SMALL CARD
//       AnimatedContainer(
//         duration: Duration(milliseconds: 1000),
//         curve: Curves.fastLinearToSlowEaseIn,
//         transform: Matrix4.translationValues(_screen30XOffset, 0, 0),
//         child: Container(
//           margin: EdgeInsets.only(top: 70),
//           height: _windowHeight - 140,
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               return Center(
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _currentScreen = 31;
//                       _selectedWorkOrder = index;
//                     });
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 35),
//                     width: _isSmallScreen ? _windowWidth * 0.91 : MediaQuery.of(context).size.width * 0.77,
//                     height: 100,
//                     decoration: (BoxDecoration(
//                       color: Theme.of(context).scaffoldBackgroundColor,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(21),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.49),
//                           spreadRadius: 0,
//                           blurRadius: 7,
//                           offset: Offset(3, 3),
//                         )
//                       ],
//                     )),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 17),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // IMAGE
//                           Container(
//                             height: 63,
//                             width: 63,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(7),
//                               ),
//                               child: Image.asset(
//                                 workOrders[index].image,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           // CONTENT MIDDLE
//                           Container(
//                             //color: Colors.blue,
//                             width: 140,
//                             padding: EdgeInsets.only(left: 14),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   workOrders[index].title,
//                                   style: TextStyle(color: _darkBlue),
//                                 ),
//                                 Text(
//                                   "\$" + workOrders[index].cost,
//                                   style: TextStyle(
//                                     color: _darkBlue.withOpacity(0.7),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // CONTENT RIGHT
//                           Container(
//                             //color: Colors.red,
//                             width: 93,
//                             padding: EdgeInsets.only(left: 14),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   workOrders[index].status,
//                                   style: TextStyle(
//                                     color: workOrders[index].status == "Aguardando Colecta"
//                                         ? Color(0xFFFFAA00)
//                                         : workOrders[index].status == "En Progreso"
//                                             ? Color(0xFF5BADFF)
//                                             : Color(0xFF6DD132),
//                                   ),
//                                 ),
//                                 Text(
//                                   'Ver detalles',
//                                   style: TextStyle(
//                                     color: _darkBlue.withOpacity(0.7),
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//             itemCount: workOrders.length,
//           ),
//         ),
//       ),
//       // EXPANDED CARD
//       AnimatedContainer(
//         duration: Duration(milliseconds: 1000),
//         curve: Curves.fastLinearToSlowEaseIn,
//         transform: Matrix4.translationValues(_screen31XOffset, 0, 0),
//         child: Center(
//           child: Container(
//             margin: _isSmallScreen ? EdgeInsets.only(top: 25) : EdgeInsets.only(top: 110, bottom: 21),
//             width: _isSmallScreen ? _windowWidth * 0.91 : MediaQuery.of(context).size.width * 0.77,
//             height: _windowHeight >= 750 ? _windowHeight * 0.63 : null,
//             decoration: (BoxDecoration(
//               color: Theme.of(context).scaffoldBackgroundColor,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(21),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.49),
//                   spreadRadius: 0,
//                   blurRadius: 7,
//                   offset: Offset(3, 3),
//                 )
//               ],
//             )),
//             child: Padding(
//               padding: const EdgeInsets.all(17),
//               child: Column(
//                 //mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // ID AND STATUS
//                   Container(
//                     margin: EdgeInsets.only(bottom: 14),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // ID
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(bottom: 7),
//                               child: Text(
//                                 'Encargo #',
//                                 style: TextStyle(
//                                   color: _darkBlue.withOpacity(0.35),
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               workOrders[_selectedWorkOrder].id,
//                             ),
//                           ],
//                         ),
//                         // STATUS
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(bottom: 7),
//                               child: Text(
//                                 'Status',
//                                 style: TextStyle(
//                                   color: _darkBlue.withOpacity(0.35),
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               workOrders[_selectedWorkOrder].status,
//                               style: TextStyle(
//                                 color: workOrders[_selectedWorkOrder].status == "Aguardando Colecta"
//                                     ? Color(0xFFFFAA00)
//                                     : workOrders[_selectedWorkOrder].status == "En Progreso"
//                                         ? Color(0xFF5BADFF)
//                                         : Color(0xFF6DD132),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   // STATUS BAR
//                   Container(
//                     margin: EdgeInsets.only(
//                       bottom: 21,
//                     ),
//                     child: Image.asset(
//                       "assets/images/temp_progress_recolored2.png",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   // IMAGE AND DESCRIPTION
//                   Container(
//                     margin: EdgeInsets.only(
//                       bottom: 14,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // IMAGE
//                         Container(
//                           height: 100,
//                           width: 100,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(7),
//                             ),
//                             child: Image.asset(
//                               workOrders[_selectedWorkOrder].image,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         // TITLE AND DESCRIPTION
//                         Expanded(
//                           // color: Colors.red,
//                           // width: 100,
//                           child: Container(
//                             margin: EdgeInsets.only(left: 14),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   //color: Colors.black,
//                                   margin: EdgeInsets.only(bottom: 10),
//                                   child: Align(
//                                     alignment: Alignment.bottomLeft,
//                                     child: Text(
//                                       workOrders[_selectedWorkOrder].title,
//                                       style: TextStyle(color: _darkBlue, fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   workOrders[_selectedWorkOrder].description,
//                                   style: TextStyle(color: _darkBlue, fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // WORKER
//                   Container(
//                     margin: EdgeInsets.only(
//                       bottom: 14,
//                     ),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           //print('Clicked worker link');
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(
//                               bottom: 4,
//                             ),
//                             child: Text(
//                               'Reparación por',
//                               style: TextStyle(
//                                 color: _darkBlue,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 workOrders[_selectedWorkOrder].workerId,
//                                 style: TextStyle(
//                                   color: _darkBlue,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(left: 7),
//                                 child: Icon(
//                                   Icons.open_in_new_rounded,
//                                   size: 14,
//                                   color: _coral,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // DATES
//                   Container(
//                     margin: EdgeInsets.only(
//                       bottom: 14,
//                     ),
//                     width: _windowWidth * 0.47,
//                     child: Column(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(bottom: 7),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Inicio del Encargo',
//                                     style: TextStyle(
//                                       color: _darkBlue.withOpacity(0.70),
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   Text(
//                                     workOrders[_selectedWorkOrder].start,
//                                     style: TextStyle(
//                                       color: _darkBlue,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Fin del Encargo',
//                                   style: TextStyle(
//                                     color: _darkBlue.withOpacity(0.70),
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Text(
//                                   workOrders[_selectedWorkOrder].end != 'En Progreso'
//                                       ? workOrders[_selectedWorkOrder].end
//                                       : 'En Progreso',
//                                   style: TextStyle(
//                                     color: workOrders[_selectedWorkOrder].end == 'En Progreso'
//                                         ? _darkBlue.withOpacity(0.35)
//                                         : _darkBlue,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   // DETAILS AND COST
//                   Container(
//                     width: _windowWidth * 0.58,
//                     child: Column(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(bottom: 5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Duración Estimada',
//                                 style: TextStyle(
//                                   color: _darkBlue.withOpacity(0.70),
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Text(
//                                 workOrders[_selectedWorkOrder].estimate,
//                                 style: TextStyle(
//                                   color: _darkBlue,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(bottom: 5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Garantía',
//                                 style: TextStyle(
//                                   color: _darkBlue.withOpacity(0.70),
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Text(
//                                 workOrders[_selectedWorkOrder].warranty,
//                                 style: TextStyle(
//                                   color: _darkBlue,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(bottom: 5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Método de pago',
//                                 style: TextStyle(
//                                   color: _darkBlue.withOpacity(0.70),
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Text(
//                                 workOrders[_selectedWorkOrder].paymentMethod,
//                                 style: TextStyle(
//                                   color: _darkBlue,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Confianza del reparador',
//                               style: TextStyle(
//                                 color: _darkBlue.withOpacity(0.70),
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.only(right: 4),
//                                   child: Text(
//                                     workOrders[_selectedWorkOrder].workerConfidence,
//                                     style: TextStyle(
//                                       color: _darkBlue,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Icon(
//                                   workOrders[_selectedWorkOrder].workerConfidence == "Alta"
//                                       ? Icons.signal_cellular_4_bar_rounded
//                                       : workOrders[_selectedWorkOrder].workerConfidence == "Media"
//                                           ? Icons.signal_cellular_off_rounded
//                                           : Icons.signal_cellular_null_rounded,
//                                   size: 14,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Divider(
//                           thickness: 0.7,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Costo',
//                               style: TextStyle(
//                                 color: _darkBlue.withOpacity(0.70),
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Text(
//                               "\$" + workOrders[_selectedWorkOrder].cost,
//                               style: TextStyle(
//                                 color: _darkBlue,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(),
//                   ),
//                   // ESCONDER DETALLES
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentScreen = 30;
//                       });
//                     },
//                     child: Text(
//                       'Esconder detalles',
//                       style: TextStyle(
//                         color: _darkBlue.withOpacity(0.7),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
