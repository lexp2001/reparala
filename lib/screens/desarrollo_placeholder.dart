import 'package:flutter/material.dart';

class EnDesarrolloPlaceholder extends StatelessWidget {
  const EnDesarrolloPlaceholder({
    Key key,
    @required Color coral,
    @required double windowWidth,
    @required double windowHeight,
    @required bool isSmallScreen,
  }) : _coral = coral, _windowWidth = windowWidth, _windowHeight = windowHeight, _isSmallScreen = isSmallScreen, super(key: key);

  final Color _coral;
  final double _windowWidth;
  final double _windowHeight;
  final bool _isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        color: Theme
                            .of(context)
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
          height: MediaQuery
              .of(context)
              .size
              .height * 0.63,
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
    );
  }
}