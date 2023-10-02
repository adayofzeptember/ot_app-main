import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ot_app/routes/route_side.dart';
import 'package:ot_app/screens/login/page_forgot_password.dart';
import 'package:ot_app/utils/app_color.dart';
import 'package:ot_app/utils/app_icon.dart';

import '../../blocs/login/login_bloc.dart';
import '../../components/AlertErrorLogin.dart';

class PageLogin extends StatefulWidget {
  PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _LoginPageState();
}

class _LoginPageState extends State<PageLogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterNativeSplash.remove();
  }

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.softBlue,
        centerTitle: true,
        title: const Text(
          "เข้าสู่ระบบ",
          style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/image/login-bg.png",
                  height: 190,
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    FormLogin(
                      usernameController: usernameController,
                      hintText: 'อีเมล',
                      icon: Icons.person_outline,
                      enabled: (state.loading == true) ? false : true,
                    ),
                    const SizedBox(height: 14),
                    FormLogin(
                      usernameController: passwordController,
                      hintText: 'รหัสผ่าน',
                      obscureText: showPass,
                      icon: Icons.lock_outline,
                      enabled: (state.loading == true) ? false : true,
                      suffixIcon: IconButton(
                        // padding: EdgeInsets.zero,
                        onPressed: () {
                          showPass = !showPass;
                          setState(() {});
                        },
                        icon: (showPass)
                            ? const ImageIcon(
                                AssetImage(AppIcons.eye),
                                color: Colors.grey,
                              )
                            : const ImageIcon(
                                AssetImage(AppIcons.eyeSlash),
                                color: Colors.grey,
                              ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, RouteSide.slideLeft(const PageForgotPassword()));
                          },
                          child: const Text(
                            "ลืมรหัสผ่าน?",
                            style: TextStyle(color: Color.fromARGB(255, 147, 195, 199), fontWeight: FontWeight.w500, fontSize: 16),
                          )),
                    ),
                    const SizedBox(height: 10),
                    (state.check == false) ? const SizedBox(height: 5) : AlertErrorLogin(title: "อีเมลหรือรหัสไม่ถูกต้อง"),
                    const SizedBox(height: 10),
                    (state.loading)
                        ? const SpinKitChasingDots(
                            color: AppColors.blue,
                            size: 50,
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blue,
                              fixedSize: const Size(200, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            onPressed: () {
                              context.read<LoginBloc>().add(CheckLogin(
                                    context,
                                    usernameController.text,
                                    passwordController.text,
                                  ));
                            },
                            child: const Text(
                              "ล็อกอิน",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    super.key,
    required this.usernameController,
    required this.hintText,
    this.obscureText,
    required this.icon,
    required this.enabled,
    this.suffixIcon,
  });

  final TextEditingController usernameController;
  final String hintText;
  final bool? obscureText;
  final bool enabled;
  final IconData icon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 4, 0, 4),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromRGBO(195, 219, 226, 0.09),
                    spreadRadius: 0,
                    offset: Offset(3, 3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: TextField(
                minLines: 1,
                maxLines: 1,
                cursorColor: Colors.grey,
                textInputAction: TextInputAction.done,
                onChanged: (val) {},
                controller: usernameController,
                obscureText: obscureText ?? false,
                textAlignVertical: TextAlignVertical.center,
                enabled: enabled,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 52, right: 18),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  suffixIcon: suffixIcon ?? null,
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(90),
              boxShadow: [
                BoxShadow(
                  color: AppColors.softBlue.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, size: 38, color: AppColors.blue),
          ),
        ],
      ),
    );
  }
}
