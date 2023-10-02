import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ot_app/components/custom_easy.dart';
import 'package:ot_app/routes/route_side.dart';
import 'package:ot_app/screens/main_navigation_bar.dart';
import 'package:ot_app/utils/app_color.dart';
import 'package:ot_app/utils/app_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageLoginPin extends StatefulWidget {
  const PageLoginPin({Key? key}) : super(key: key);

  @override
  _PageLoginPinState createState() => _PageLoginPinState();
}

class _PageLoginPinState extends State<PageLoginPin> {
  String pin = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocalAuth();
    FlutterNativeSplash.remove();
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? checkPin = await prefs.getString('pin_auth');
    if (pin == checkPin) {
      eazyShowLoading();
      Future.delayed(const Duration(milliseconds: 350), () async {
        Navigator.pushReplacement(context, RouteSide.slideLeft(const MainNavigationBar()));
      });
    } else {
      pin = "";
      eazyShowError(title: "รหัสผ่านไม่ถูกต้อง");
      setState(() {});
    }
  }

  final LocalAuthentication auth = LocalAuthentication();
  bool canAuth = false;
  List typeBio = [];

  void checkLocalAuth() async {
    final prefs = await SharedPreferences.getInstance();
    bool? checkLocalAuth = await prefs.getBool('local_auth');
    if (checkLocalAuth != null) {
      if (checkLocalAuth) {
        final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
        final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
        final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
        print(availableBiometrics);
        if (canAuthenticate) {
          canAuth = true;
          try {
            final bool didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate');
            print(didAuthenticate);
            if (didAuthenticate) {
              eazyShowLoading();
              Future.delayed(const Duration(milliseconds: 350), () async {
                Navigator.pushReplacement(context, RouteSide.slideLeft(const MainNavigationBar()));
              });
            }
          } on PlatformException catch (e) {
            print('Error - ${e.message}');
          }
        }
        if (availableBiometrics.isNotEmpty) {
          typeBio = availableBiometrics;
          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = (MediaQuery.of(context).copyWith().size.width / 4) - 30;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "กรอกรหัสผ่าน",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: w,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircleAvatar(
                      backgroundColor: (pin.length >= 1) ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: w,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircleAvatar(
                      backgroundColor: (pin.length >= 2) ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: w,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircleAvatar(
                      backgroundColor: (pin.length >= 3) ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: w,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircleAvatar(
                      backgroundColor: (pin.length >= 4) ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          if (typeBio.contains(BiometricType.face))
            InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () async {
                if (canAuth) {
                  try {
                    final bool didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate');
                    print(didAuthenticate);
                    if (didAuthenticate) {
                      eazyShowLoading();
                      Future.delayed(const Duration(milliseconds: 350), () async {
                        Navigator.pushReplacement(context, RouteSide.slideLeft(const MainNavigationBar()));
                      });
                    }
                  } on PlatformException catch (e) {
                    print('Error - ${e.message}');
                  }
                } else {
                  eazyShowError(title: "ระบบไม่รองรับ");
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: const Column(
                  children: [
                    ImageIcon(
                      AssetImage(AppIcons.faceId),
                      size: 50,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "สแกนใบหน้า",
                      style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 400,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                NumberWidget(
                  number: '1',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '1';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }

                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '2',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '2';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '3',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '3';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              children: [
                NumberWidget(
                  number: '4',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '4';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '5',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '5';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '6',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '6';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              children: [
                NumberWidget(
                  number: '7',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '7';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '8',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '8';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '9',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '9';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container()),
                NumberWidget(
                  number: '0',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '0';
                    }
                    if (pin.length == 4) {
                      checkLogin();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: 'x',
                  onTap: () {
                    if (pin.length > 0) {
                      pin = (pin.length > 0) ? pin.substring(0, pin.length - 1) : "";
                    }

                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    super.key,
    required this.number,
    required this.onTap,
  });
  final String number;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextButton(
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              number,
              style: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          style: TextButton.styleFrom(foregroundColor: Colors.black12, side: const BorderSide(width: 1, color: Colors.black)),
        ),
      ),
    );
  }
}
