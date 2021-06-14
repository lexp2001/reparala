// import 'package:flutter/material.dart';
//
// class Mensajes extends StatelessWidget {
//   const Mensajes({
//     Key key,
//     @required Color coral,
//   })  : _coral = coral,
//         super(key: key);
//
//   final Color _coral;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // HEADER
//         Column(
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
//                         'MENSAJES',
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
//         // MESSAGES
//         AnimatedContainer(
//           duration: Duration(milliseconds: 1000),
//           curve: Curves.fastLinearToSlowEaseIn,
//           transform: Matrix4.translationValues(_screen20XOffset, 0, 0),
//           child: Container(
//             margin: EdgeInsets.only(top: 100),
//             width: _windowWidth,
//             height: _windowHeight - 170,
//             //color: Colors.blue,
//             child: Column(
//               //mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // SEARCH BAR
//                 Container(
//                   margin: EdgeInsets.only(bottom: 21),
//                   //padding: EdgeInsets.all(21),
//                   height: 49,
//                   width: _isSmallScreen ? _windowWidth * 0.91 : _windowWidth * 0.77,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         spreadRadius: 0,
//                         blurRadius: 7,
//                         offset: Offset(3, 3),
//                       )
//                     ],
//                     color: _darkBlue.withOpacity(0.04),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(left: 21),
//                         child: Icon(
//                           Icons.search_rounded,
//                           color: _darkBlue.withOpacity(0.49),
//                         ),
//                       ),
//                       Center(
//                         child: Container(
//                           margin: EdgeInsets.only(left: 7),
//                           width: 210,
//                           child: TextField(
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: 'Buscar...',
//                               hintStyle: TextStyle(
//                                 color: _darkBlue.withOpacity(0.49),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // MESSAGE CARD
//                 Expanded(
//                   child: ListView.builder(
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _currentScreen = 21;
//                             _selectedMessage = index;
//                           });
//                         },
//                         child: Align(
//                           child: Container(
//                             margin: EdgeInsets.only(bottom: 35),
//                             width: _isSmallScreen ? _windowWidth * 0.91 : _windowWidth * 0.77,
//                             height: 70,
//                             //color: Colors.red,
//                             child: Row(
//                               //crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // PROFILE PICTURE
//                                 Container(
//                                   margin: EdgeInsets.only(right: 14),
//                                   height: 70,
//                                   width: 70,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(100),
//                                     ),
//                                     child: Image.asset(
//                                       messages[index].workerPicture,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 // BODY MESSAGE
//                                 Expanded(
//                                   child: Column(
//                                     children: [
//                                       // NAME AND TIME
//                                       Container(
//                                         margin: EdgeInsets.only(bottom: 10),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               messages[index].workerId,
//                                               style: TextStyle(
//                                                 fontWeight: messages[index].amountUnread != '0'
//                                                     ? FontWeight.bold
//                                                     : FontWeight.w500,
//                                                 color: messages[index].amountUnread != '0'
//                                                     ? _darkBlue.withOpacity(0.84)
//                                                     : _darkBlue.withOpacity(0.77),
//                                               ),
//                                             ),
//                                             Text(
//                                               messages[index].timeSent,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 12,
//                                                 color: messages[index].amountUnread != '0'
//                                                     ? _coral
//                                                     : _darkBlue.withOpacity(0.35),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       // MESSAGE AND NOTIFICATION
//                                       Row(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           // MESSAGE
//                                           Expanded(
//                                             child: Text(
//                                               messages[index].message,
//                                               maxLines: 2,
//                                               style: TextStyle(height: 1.4),
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                           // NOTIFICATION
//                                           Visibility(
//                                             visible: messages[index].amountUnread != '0',
//                                             child: Container(
//                                               margin: EdgeInsets.only(left: 14),
//                                               width: 21,
//                                               height: 21,
//                                               decoration: BoxDecoration(
//                                                 color: _coral,
//                                                 borderRadius: BorderRadius.all(
//                                                   Radius.circular(21),
//                                                 ),
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                   messages[index].amountUnread,
//                                                   style: TextStyle(
//                                                       fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     itemCount: 7,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // MESSAGE
//         AnimatedContainer(
//           duration: Duration(milliseconds: 1000),
//           curve: Curves.fastLinearToSlowEaseIn,
//           transform: Matrix4.translationValues(0, _screen21YOffset, 0),
//           child: Container(
//             width: _windowWidth,
//             height: _windowHeight - 70,
//             color: _darkBlue,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // HEADER
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         //print('Worker profile clicked');
//                       });
//                     },
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         margin: EdgeInsets.only(top: 25),
//                         width: _isSmallScreen ? _windowWidth * 0.91 : _windowWidth * 0.77,
//                         height: 70,
//                         //color: Colors.red,
//                         child: Row(
//                           //crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // PROFILE PICTURE
//                             Container(
//                               margin: EdgeInsets.only(right: 21),
//                               height: 70,
//                               width: 70,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(100),
//                                 ),
//                                 child: Image.asset(
//                                   messages[_selectedMessage].workerPicture,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             // NAME AND CATEGORY
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // NAME
//                                 Text(
//                                   messages[_selectedMessage].workerId,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 // CATEGORY
//                                 Text(
//                                   messages[_selectedMessage].workerCategories,
//                                   maxLines: 2,
//                                   style: TextStyle(
//                                     height: 1.4,
//                                     color: Colors.white.withOpacity(0.70),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // CHAT AREA
//                 Container(
//                   width: _windowWidth,
//                   height: _windowHeight * 0.7,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).scaffoldBackgroundColor,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(35),
//                       topRight: Radius.circular(35),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       // TODAY MESSAGE
//                       Container(
//                         margin: EdgeInsets.only(
//                           top: 14,
//                         ),
//                         child: Text(
//                           'TODAY',
//                           style:
//                               TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: _darkBlue.withOpacity(0.35)),
//                         ),
//                       ),
//                       // CHAT PLACEHOLDER
//                       Expanded(
//                         //height: 200,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Visibility(
//                                   visible: _isMessageWithWorker,
//                                   child: Container(
//                                     //color: Colors.red,
//                                     height: _isSmallScreen ? _windowHeight * 0.28 : _windowHeight * 0.35,
//                                     width: _windowWidth * 0.9,
//                                     child: _filePictureFromCamera != null
//                                         ? Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Image.file(File(_filePictureFromCamera.path)),
//                                           )
//                                         : _pathImageFromGallery != null
//                                             ? Align(
//                                                 alignment: Alignment.centerRight,
//                                                 child: Image.file(File(_pathImageFromGallery)),
//                                               )
//                                             : Align(
//                                                 alignment: Alignment.centerRight,
//                                                 child: Image.asset(
//                                                   'assets/images/temp_chat.png',
//                                                   fit: BoxFit.fitWidth,
//                                                 ),
//                                               ),
//                                   )),
//                               Visibility(
//                                 visible: !_isMessageWithWorker,
//                                 child: Image.asset(
//                                   'assets/images/temp_chat.png',
//                                   fit: BoxFit.fitWidth,
//                                   // ),
//                                 ),
//                               ),
//                               // USER REPAIR QUERY MESSAGE
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Visibility(
//                                   visible: _userRepairQuery != null || _isMessageWithWorker,
//                                   child: Container(
//                                     margin: EdgeInsets.only(top: 21, right: 21),
//                                     padding: EdgeInsets.all(21),
//                                     //height: 49,
//                                     width: _windowWidth * 0.77,
//                                     decoration: BoxDecoration(
//                                       color: Colors.red,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(100),
//                                         topRight: Radius.circular(100),
//                                         bottomLeft: Radius.circular(100),
//                                       ),
//                                     ),
//                                     child: Text(
//                                       '¡Hola! Hoy quiero reparar: ' + _userRepairQuery.text,
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // INPUT BAR
//                       AnimatedContainer(
//                         duration: Duration(milliseconds: 1000),
//                         curve: Curves.fastLinearToSlowEaseIn,
//                         padding: EdgeInsets.symmetric(horizontal: 21),
//                         margin: EdgeInsets.only(bottom: _keyboardVisible ? 250 : 21, top: 21),
//                         //padding: EdgeInsets.all(21),
//                         height: 49,
//                         width: _windowWidth * 0.91,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.1),
//                               spreadRadius: 0,
//                               blurRadius: 7,
//                               offset: Offset(3, 3),
//                             )
//                           ],
//                           color: _darkBlue.withOpacity(0.04),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: _windowWidth * 0.56,
//                               child: TextField(
//                                 enabled: true,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Escribe tu mensaje aquí...',
//                                   hintStyle: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     color: _darkBlue.withOpacity(0.49),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // ATTACH ICON
//                             Container(
//                               margin: EdgeInsets.only(left: _windowWidth * 0.01),
//                               child: Icon(
//                                 Icons.attach_file_rounded,
//                                 color: _darkBlue.withOpacity(0.49),
//                               ),
//                             ),
//                             // SEND ICON
//                             Container(
//                               margin: EdgeInsets.only(left: _windowWidth * 0.01),
//                               width: 28,
//                               height: 28,
//                               decoration: BoxDecoration(
//                                 color: _coral,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(21),
//                                 ),
//                               ),
//                               child: Icon(Icons.send_rounded, color: Colors.white, size: 18),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
