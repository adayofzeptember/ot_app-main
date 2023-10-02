import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ot_app/blocs/local_auth/local_auth_bloc.dart';
import 'package:ot_app/routes/route_fade.dart';
import 'package:ot_app/screens/setting/page_set_pin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_color.dart';

class PageSetPrivacy extends StatefulWidget {
  const PageSetPrivacy({Key? key}) : super(key: key);

  @override
  State<PageSetPrivacy> createState() => _PageSetPrivacyState();
}

class _PageSetPrivacyState extends State<PageSetPrivacy> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LocalAuthBloc>().add(PinAuth());
    context.read<LocalAuthBloc>().add(AuthLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.blue,
            centerTitle: true,
            title: const Text(
              "ตั้งค่าความเป็นส่วนตัว",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: BlocBuilder<LocalAuthBloc, LocalAuthState>(
          builder: (context, state) {
            return Column(
              children: [
                MenuSetting(
                  bottomLine: true,
                  switchOpen: state.switchPin,
                  title: "ล็อครหัสผ่าน",
                  onChanged: (value) async {
                    if (value) {
                      Navigator.push(context, RouteFade.noSlide(const PageSetPin()));
                    }
                    if (!value) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.remove("pin_auth");
                      context.read<LocalAuthBloc>().add(PinAuth());
                    }
                  },
                ),
                if (state.switchPin)
                  MenuSetting(
                    // bottomLine: false,
                    switchOpen: state.switchLocal,
                    title: "ลายนิ้วมือหรือใบหน้า",
                    onChanged: (value) async {
                      final prefs = await SharedPreferences.getInstance();
                      if (!state.switchLocal) {
                        await prefs.setBool("local_auth", true);
                      } else {
                        prefs.remove("local_auth");
                      }
                      context.read<LocalAuthBloc>().add(AuthLocal());
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MenuSetting extends StatelessWidget {
  const MenuSetting({
    super.key,
    required this.switchOpen,
    this.detail,
    this.bottomLine,
    required this.title,
    required this.onChanged,
  });

  final bool switchOpen;
  final bool? bottomLine;
  final String? detail;
  final String title;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: (bottomLine == true) ? Border(bottom: BorderSide(width: 1.5, color: Colors.grey.shade300)) : const Border(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              if (detail != null)
                Text(
                  detail!,
                  style: const TextStyle(color: Colors.grey),
                ),
            ],
          ),
          CupertinoSwitch(
            value: switchOpen,
            onChanged: onChanged,
            activeColor: const Color.fromARGB(255, 135, 188, 192),
            focusColor: Colors.red,
            thumbColor: AppColors.blue,
            trackColor: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
