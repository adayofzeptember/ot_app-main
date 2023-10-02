import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/blocs/check_in_out/check_in_out_bloc.dart';
import 'package:ot_app/routes/route_fade.dart';
import 'package:ot_app/routes/route_side.dart';
import 'package:ot_app/screens/check/check_history.dart';
import 'package:ot_app/screens/check/page_scan.dart';
import 'package:ot_app/utils/app_color.dart';
import 'package:latlong2/latlong.dart';
import '../../components/card_time.dart';
import '../../utils/app_icon.dart';

class PageCheck extends StatefulWidget {
  const PageCheck({Key? key}) : super(key: key);

  @override
  _PageCheckState createState() => _PageCheckState();
}

class _PageCheckState extends State<PageCheck> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mapController = MapController();
  }

  MapController? _mapController;

  LatLng companyLocation = const LatLng(14.98033979332644, 102.0784790895414);

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).copyWith().size.height;
    double w = MediaQuery.of(context).copyWith().size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        elevation: 0,
        title: const Text(
          "ลงเวลาทำงาน",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Hero(
            tag: 'iconScan',
            child: IconButton(
              onPressed: () {
                Navigator.push(context, RouteFade.slideBottom(PageScan()));
              },
              icon: const ImageIcon(AssetImage(AppIcons.scan), color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, RouteSide.slideLeft(const CheckHistory()));
              },
              icon: const ImageIcon(
                AssetImage(AppIcons.clock),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CheckInOutBloc, CheckInOutState>(
        builder: (context, state) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Container(
                height: 300,
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        // bounds: LatLngBounds(LatLng(state.lat, state.lng), companyLocation),
                        // boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(50)),
                        center: LatLng(state.lat, state.lng),
                        zoom: 15,
                        enableScrollWheel: false,
                        keepAlive: true,
                        interactiveFlags:
                            InteractiveFlag.pinchZoom | InteractiveFlag.pinchMove, // ปิดการซูมและเลื่อนแผนที่ด้วยการสัมผัส
                      ),
                      nonRotatedChildren: [
                        CircleLayer(
                          circles: [
                            CircleMarker(
                                point: LatLng(state.lat, state.lng),
                                radius: 15,
                                color: AppColors.blue,
                                useRadiusInMeter: true,
                                borderStrokeWidth: 30,
                                borderColor: AppColors.blue.withOpacity(0.2))
                          ],
                        ),
                      ],
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          // userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: companyLocation,
                              width: 40,
                              height: 40,
                              builder: (context) => const Icon(
                                Icons.location_on,
                                color: AppColors.red,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: companyLocation,
                              width: 200,
                              height: 200,
                              builder: (context) => Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade300.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(300),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // PolylineLayer(
                        //   polylines: [
                        //     Polyline(
                        //       points: [LatLng(state.lat, state.lng), companyLocation],
                        //       color: AppColors.blue,
                        //       strokeWidth: 3,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: InkWell(
                        onTap: () {
                          _mapController!.move(companyLocation, 15.0);
                          setState(() {});
                        },
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              const BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.298),
                                offset: Offset(3, 3),
                                blurRadius: 20,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: AppColors.red,
                                size: 39,
                              ),
                              Container(
                                width: w - 160,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "บริษัท คอมพัฒนา จำกัด",
                                      style: TextStyle(
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "369, 11 Soi Dechudom 6, ตำบลในเมือง อำเภอเมืองนครราชสีมา นครราชสีมา 30000",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              const ImageIcon(
                                AssetImage(AppIcons.building),
                                color: Colors.grey,
                                size: 28,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 10,
                      child: FloatingActionButton(
                        backgroundColor: AppColors.blue,
                        onPressed: () {
                          _mapController!.move(LatLng(state.lat, state.lng), 15.0);
                        },
                        child: const Icon(Icons.my_location),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 26,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            const BoxShadow(
                              color: Color.fromRGBO(195, 219, 226, 0.30),
                              offset: Offset(3, 3),
                              blurRadius: 20,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 550,
                // decoration: const BoxDecoration(
                //   color: Colors.white,
                // ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Text(
                        "เข้างาน ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CardTime(
                              title: (state.ifIn == true) ? "${state.checkIn.hour < 10 ? 0 : ""}${state.checkIn.hour}" : "--",
                              color: Colors.green.withOpacity(0.1)),
                          const Text(
                            ':',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          CardTime(
                              title: (state.ifIn == true) ? "${state.checkIn.minute < 10 ? 0 : ""}${state.checkIn.minute}" : "--",
                              color: Colors.green.withOpacity(0.1)),
                          // const Text(
                          //   ':',
                          //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          // ),
                          // CardTime(
                          //   title: (state.ifIn == true) ? "${state.checkIn.second}" : "--",
                          //   color: AppColors.red.withOpacity(.1),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "ออกงาน",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CardTime(
                            title: (state.ifOut == true) ? "${state.checkOut.hour < 10 ? 0 : ""}${state.checkOut.hour}" : "--",
                            color: AppColors.red.withOpacity(.1),
                          ),
                          const Text(
                            ':',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          CardTime(
                            title: (state.ifOut == true) ? "${state.checkOut.minute < 10 ? 0 : ""}${state.checkOut.minute}" : "--",
                            color: AppColors.red.withOpacity(.1),
                          ),
                          // const Text(
                          //   ':',
                          //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          // ),
                          // CardTime(
                          //     title: (state.ifOut == true) ? "${state.checkOut.second}" : "--",
                          //     color: AppColors.green.withOpacity(0.1)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "ระยะห่างจากออฟฟิศ ${state.distance} กม.",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const SizedBox(height: 18),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (state.checkBtn) ? AppColors.red : Colors.green,
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: (double.parse(state.distance) <= 0.1 && state.ifOut == false)
                            ? () {
                                DateFormat formatterDate = DateFormat.yMMMEd();
                                DateFormat formatterTime = DateFormat.jm();

                                confirmModal(
                                  context: context,
                                  onConfirm: () {
                                    context.read<CheckInOutBloc>().add(CheckInTime(context: context));
                                  },
                                  title: (state.checkBtn == false) ? "ยืนยันเวลาเข้าทำงาน" : "ยืนยันเวลาออกงาน",
                                  content: "${formatterDate.format(state.checkIn)}\nเวลา ${formatterTime.format(state.checkIn)}",
                                  titleColor: AppColors.blue,
                                  textConfirmColor: Colors.white,
                                  backgroundConfirmColor: Colors.green,
                                  textCancelColor: Colors.grey,
                                  backgroundCancelColor: Colors.grey.shade300,
                                );
                              }
                            : null,
                        child: Text(
                          (state.checkBtn == false) ? "เช็คอิน" : "เช็คเอ้าท์",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void confirmModal({
  required BuildContext context,
  required Function() onConfirm,
  required String title,
  required Color titleColor,
  required Color textConfirmColor,
  required Color backgroundConfirmColor,
  required Color textCancelColor,
  required Color backgroundCancelColor,
  required String content,
}) {
  showDialog(
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 24,
        shadowColor: Colors.black.withOpacity(0.7),
        title: Center(
            child: Text(
          title,
          style: TextStyle(color: titleColor, fontSize: 22, fontWeight: FontWeight.bold),
        )),
        content: Text(
          content,
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 90,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: backgroundCancelColor, borderRadius: BorderRadius.circular(11)),
                  child: Text(
                    'ยกลิก',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textCancelColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onConfirm,
                child: Container(
                  width: 90,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: backgroundConfirmColor, borderRadius: BorderRadius.circular(11)),
                  child: Text(
                    'ยืนยัน',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textConfirmColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
