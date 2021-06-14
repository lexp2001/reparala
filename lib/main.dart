import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:repara_latam/models/tos_model.dart';
import 'package:repara_latam/screens/app_body.dart';

import 'components/login_page_text_field.dart';

CameraDescription firstCamera;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final exampleConst = BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    spreadRadius: 0,
    blurRadius: 7,
    offset: Offset(3, 3),
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterBugfender.init(
      "JeeRh6cC5HWdWrEV8hDEPod0e08cTEUS",
      enableAndroidLogcatLogging: true,
      enableCrashReporting: true,
      enableUIEventLogging: true,
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: AllLogin(),
        ),
      ),
    );
  }
}

class AllLogin extends StatefulWidget {
  @override
  _AllLoginState createState() => _AllLoginState();
}

class _AllLoginState extends State<AllLogin> {
  String _email, _password;

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  User user;
  Timer timer;

  // Login States:
  //
  // 0: First Screen
  // 10: Registrarse
  // 101: Términos y Condiciones
  // 11: Validación
  // 20: Entrar
  // 21: Recuperar contraseña
  // 30: Creando cuenta

  int _pageState = 0;

  double _windowWidth = 0;
  double _windowHeight = 0;
  bool _isSmallScreen = false;

  double _firstScreenXOffset = 0;
  double _registrarseXOffset = 0;
  double _terminosXOffset = 0;
  double _validacionXOffset = 0;
  double _entrarXOffset = 0;
  double _recuperarXOffset = 0;

  bool _isToSChecked = false;

  @override
  void initState() {
    user = auth.currentUser;
    //
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  onClickSignUpTerminos() {
    setState(() {
      _pageState = 11;
    });
  }

  onClickSignUpSiguiente() async {
    print('Sign Up Initialized');

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

      FirebaseAuth.instance.currentUser.sendEmailVerification().then((_) {
        print('Verification email sent');
        triggerEmailVerification();

        FocusScope.of(context).unfocus();

        setState(() {
          _pageState = 101;
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(backgroundColor: Color(0xFFBFF4949), content: Text('La contraseña es muy débil')));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Color(0xFFBFF4949), content: Text('La dirección de correo ya está en uso')));
      }
    } catch (e) {
      print(e);
    }

    //
    //
    // auth
    //     .createUserWithEmailAndPassword(
    //         email: _emailController.text, password: _passwordController.text)
    //     .then((_) {
    //   print('User created');
    //
    //   // user.sendEmailVerification().then((_) {
    //   //   print('Verification email sent');
    //   //   triggerEmailVerification();
    //   // });
    // });

    // new Future.delayed(const Duration(seconds: 20), () {
    //   // deleayed code here
    //   print('Delayed execution');
    //   user.sendEmailVerification().then((_) {
    //     print('Delayed verification email sent');
    //     triggerEmailVerification();
    //     setState(() {
    //       _pageState = 11;
    //     });
    //   });
    // });
  }

  triggerEmailVerification() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AppBody(camera: firstCamera)));
    }
  }

  @override
  Widget build(BuildContext context) {
    _windowHeight = MediaQuery.of(context).size.height;
    _windowWidth = MediaQuery.of(context).size.width;

    if (_windowHeight <= 690) {
      _isSmallScreen = true;
    }

    switch (_pageState) {
      case 0:
        _firstScreenXOffset = 0;
        _registrarseXOffset = _windowWidth;
        _terminosXOffset = _windowWidth;
        _validacionXOffset = _windowWidth;
        _entrarXOffset = _windowWidth;
        _recuperarXOffset = _windowWidth;
        break;
      case 10:
        _firstScreenXOffset = -_windowWidth;
        _registrarseXOffset = 0;
        _terminosXOffset = _windowWidth;
        //_validacionXOffset = _windowWidth;
        break;
      case 101:
        _firstScreenXOffset = -_windowWidth;
        _registrarseXOffset = -_windowWidth;
        _terminosXOffset = 0;
        _validacionXOffset = _windowWidth;
        break;
      case 11:
        _firstScreenXOffset = -_windowWidth;
        _terminosXOffset = -_windowWidth;
        _validacionXOffset = 0;
        break;
      case 20:
        _firstScreenXOffset = -_windowWidth;
        _entrarXOffset = 0;
        _recuperarXOffset = _windowWidth;
        break;
      case 21:
        _entrarXOffset = -_windowWidth;
        _recuperarXOffset = 0;
        break;
    }

    Future<bool> onWillPop() {
      switch (_pageState) {
        case 0:
          break;
        case 10:
          setState(() {
            _pageState = 0;
          });
          break;
        case 101:
          setState(() {
            _pageState = 10;
          });
          break;
        case 11:
          setState(() {
            _pageState = 101;
          });
          break;
        case 20:
          setState(() {
            _pageState = 0;
          });
          break;
        case 21:
          setState(() {
            _pageState = 20;
          });
          break;
      }
      //print(_pageState);
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_bg_medium_compressed.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // FIRST SCREEN
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  transform: Matrix4.translationValues(_firstScreenXOffset, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // LOGO
                      Container(
                        height: 140,
                        //flex: 2,
                        child: Image.asset("assets/images/logo_square.png"),
                      ),
                      // SEPARATION
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                      // Lower third
                      Column(
                        children: [
                          Container(
                            width: 190,
                            child: Text(
                              'Conecta con individuos ansiosos por darle una segunda oportunidad a tus pertenencias',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white.withOpacity(0.77), height: 1.5, letterSpacing: 1.9),
                            ),
                          ),
                          // BTN SIGN UP
                          Container(
                            margin: EdgeInsets.only(top: 21),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _pageState = 10;
                                });
                              },
                              child: Container(
                                //margin: EdgeInsets.symmetric(vertical: 14, horizontal: 56),
                                padding: EdgeInsets.all(21),
                                width: MediaQuery.of(context).size.width / 1.4,
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
                                  color: Color(0xFFBFF4949),
                                ),
                                child: Center(
                                  child: Text(
                                    'REGISTRARSE',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 21),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // BTN SIGN IN
                          Container(
                            margin: EdgeInsets.only(top: 21),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _pageState = 20;
                                });
                              },
                              child: Container(
                                //margin: EdgeInsets.symmetric(vertical: 14, horizontal: 56),
                                padding: EdgeInsets.all(21),
                                width: MediaQuery.of(context).size.width / 1.4,
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
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    'ENTRAR',
                                    style:
                                        TextStyle(color: Color(0xFFBFF4949), fontWeight: FontWeight.w700, fontSize: 21),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // GOOGLE SIGN UP
                          Container(
                            margin: EdgeInsets.only(top: 21, bottom: 21),
                            width: 35,
                            height: 35,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset("assets/images/google_small.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // REGISTRARSE
                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _isSmallScreen
                        ? MediaQuery.of(context).size.height * 0.54
                        : MediaQuery.of(context).size.height * 0.49,
                    width: MediaQuery.of(context).size.width * 0.91,
                    transform: Matrix4.translationValues(_registrarseXOffset, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // HEADER
                        Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFF021028),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(21),
                              topRight: Radius.circular(21),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Nueva Cuenta',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 7),
                            ),
                          ),
                        ),
                        // BODY
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                InputWithIcon(
                                  controller: _emailController,
                                  icon: Icons.email_outlined,
                                  hint: 'Email',
                                  obscure: false,
                                  onChanged: (value) {},
                                ),
                                InputWithIcon(
                                  controller: _usernameController,
                                  icon: Icons.person_outline,
                                  hint: 'Usuario',
                                  obscure: false,
                                  onChanged: (value) {},
                                ),
                                InputWithIcon(
                                  controller: _passwordController,
                                  icon: Icons.lock_outline_rounded,
                                  hint: 'Contraseña',
                                  obscure: true,
                                  onChanged: (value) {},
                                ),
                                Expanded(flex: 4, child: Container()),
                                // BTN SIGUIENTE
                                Container(
                                  margin: EdgeInsets.only(bottom: 21),
                                  child: GestureDetector(
                                    onTap: () {
                                      onClickSignUpSiguiente();
                                    },
                                    child: PrimaryButton(
                                      btnText: 'SIGUIENTE',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // TÉRMINOS Y CONDICIONES
                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: MediaQuery.of(context).size.height * 0.91,
                    width: MediaQuery.of(context).size.width * 0.91,
                    transform: Matrix4.translationValues(_terminosXOffset, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // HEADER
                        Container(
                          width: double.infinity,
                          height: 91,
                          decoration: BoxDecoration(
                            color: Color(0xFF021028),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(21),
                              topRight: Radius.circular(21),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Términos de Servicio',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 7),
                            ),
                          ),
                        ),
                        // BODY
                        Expanded(
                          child: Container(
                            //height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 21),
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(temporaryToS[0].tos),
                                  ),
                                ),

                                // TaC CHECKBOX
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                          value: _isToSChecked,
                                          onChanged: (value) {
                                            setState(() {
                                              _isToSChecked = value;
                                            });
                                          }),
                                      Flexible(
                                        child: Container(
                                          width: 210,
                                          child: Text('He leído y acepto los términos y condiciones de uso.'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Expanded(flex: 4, child: Container()),
                                // BTN SIGUIENTE
                                Container(
                                  child: GestureDetector(
                                    onTap: !_isToSChecked ? null : () => onClickSignUpTerminos(),
                                    child: Container(
                                      //margin: EdgeInsets.symmetric(vertical: 14, horizontal: 56),
                                      padding: EdgeInsets.all(21),
                                      height: 70,
                                      width: MediaQuery.of(context).size.width / 1.4,
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
                                        color: !_isToSChecked ? Colors.grey : Color(0xFFBFF4949),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'SIGUIENTE',
                                          style:
                                              TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 21),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // AGUARDANDO VALIDACIÓN
                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.91,
                    transform: Matrix4.translationValues(_validacionXOffset, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // HEADER
                        Container(
                          width: double.infinity,
                          height: 91,
                          decoration: BoxDecoration(
                            color: Color(0xFF021028),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(21),
                              topRight: Radius.circular(21),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Aguardando Validación',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 7),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 280,
                            child: Center(
                              child: Text(
                                'Hemos enviado un correo de confirmación a tu email. Por favor ábrelo y haz click en el enlace para continuar.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // ENTRAR
                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _isSmallScreen
                        ? MediaQuery.of(context).size.height * 0.54
                        : MediaQuery.of(context).size.height * 0.40,
                    width: MediaQuery.of(context).size.width * 0.91,
                    transform: Matrix4.translationValues(_entrarXOffset, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // HEADER
                        Container(
                          //margin: EdgeInsets.only(bottom: 14),
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFF021028),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(21),
                              topRight: Radius.circular(21),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              auth.signInAnonymously().then((value) => Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => AppBody(camera: firstCamera),
                                    ),
                                  ));
                            },
                            child: Center(
                              child: Text(
                                '¡Bienvenido!',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 7),
                              ),
                            ),
                          ),
                        ),
                        // BODY
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                InputWithIcon(
                                  controller: _emailController,
                                  icon: Icons.person_outline,
                                  hint: 'Email',
                                  obscure: false,
                                  onChanged: (value) {},
                                ),
                                InputWithIcon(
                                  controller: _passwordController,
                                  icon: Icons.lock_outline_rounded,
                                  hint: 'Contraseña',
                                  obscure: true,
                                  onChanged: (value) {},
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 14),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _pageState = 21;
                                        });
                                      },
                                      child: Text(
                                        '¿Olvidaste tu contraseña?',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(),
                                ),
                                // BTN ENTRAR
                                Container(
                                  margin: EdgeInsets.only(bottom: 21),
                                  child: GestureDetector(
                                    onTap: () {
                                      auth
                                          .signInWithEmailAndPassword(
                                              email: _emailController.text, password: _passwordController.text)
                                          .then((value) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (context) => AppBody(camera: firstCamera)));
                                      });
                                    },
                                    child: PrimaryButton(
                                      btnText: 'ENTRAR',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // RECUPERAR CONTRASEÑA
                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _isSmallScreen ? _windowHeight * 0.54 : _windowHeight * 0.38,
                    width: MediaQuery.of(context).size.width * 0.91,
                    transform: Matrix4.translationValues(_recuperarXOffset, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // HEADER
                        Container(
                          margin: EdgeInsets.only(bottom: 14),
                          width: double.infinity,
                          height: 98,
                          decoration: BoxDecoration(
                            color: Color(0xFF021028),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(21),
                              topRight: Radius.circular(21),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              auth.signInAnonymously().then((value) => Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => AppBody(camera: firstCamera),
                                    ),
                                  ));
                            },
                            child: Center(
                              child: Text(
                                'Recuperar Contraseña',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 7),
                              ),
                            ),
                          ),
                        ),
                        // BODY
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    'Introduce la dirección de correo con la cual te registraste',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14, color: Color(0xFFB021028).withOpacity(0.70)),
                                  ),
                                ),
                                InputWithIcon(
                                  controller: _emailController,
                                  icon: Icons.person_outline,
                                  hint: 'Email',
                                  obscure: false,
                                  onChanged: (value) {},
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(),
                                ),
                                // BTN ENTRAR
                                Container(
                                  margin: EdgeInsets.only(bottom: 21),
                                  child: GestureDetector(
                                    onTap: () {
                                      auth.sendPasswordResetEmail(email: _emailController.text);
                                      FocusScope.of(context).unfocus();

                                      setState(() {
                                        _pageState = 20;
                                      });

                                      new Future.delayed(const Duration(seconds: 1), () {
                                        // deleayed code here
                                        //print('delayed execution');
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            backgroundColor: Color(0xFFBFF4949), content: Text('Email enviado')));
                                      });
                                    },
                                    child: PrimaryButton(
                                      btnText: 'RESETEAR',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 14, horizontal: 56),
      padding: EdgeInsets.all(21),
      height: 70,
      width: MediaQuery.of(context).size.width / 1.4,
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
        color: Color(0xFFBFF4949),
      ),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 21),
        ),
      ),
    );
  }
}
