import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ot_app/components/alert.dart';
import 'package:shimmer/shimmer.dart';

import '../../blocs/leaves/leaves_bloc.dart';
import '../../components/kon_button.dart';
import '../../components/photo_view.dart';
import '../../routes/route_side.dart';
import '../../utils/app_color.dart';
import '../../utils/app_icon.dart';
import '../../utils/app_image.dart';

// ignore: must_be_immutable
class SectionLeaveHistory extends StatelessWidget {
  SectionLeaveHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeavesBloc, LeavesState>(
      builder: (context, state) {
        if (state.pageLoading) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 220.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                  ),
                ),
              );
            },
          );
        }
        if (state.dataOnly.isEmpty) {
          return const Center(
            child: Text(
              'ไม่พบข้อมูล',
              style: TextStyle(fontSize: 30, color: AppColors.softBlue),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: state.dataOnly.length,
            itemBuilder: (context, index) {
              return Container(
                // height: 220,
                margin: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                child: Slidable(
                  key: const ValueKey(0),
                  enabled: (state.dataOnly[index].status == 'Pending') ? true : false,
                  closeOnScroll: true,
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    openThreshold: 0.1,
                    extentRatio: 0.33,
                    children: [
                      const SizedBox(width: 10),
                      SidePane(
                        onTap: () {
                          print(state.dataOnly[index].id);
                          KonAlert().alert(
                            context: context,
                            onConfirm: () {
                              context.read<LeavesBloc>().add(CancelLeave(
                                    context: context,
                                    id: state.dataOnly[index].id.toString(),
                                  ));
                            },
                            title: "ต้องการยกเลิก ?",
                            titleColor: AppColors.red,
                            textConfirmColor: Colors.white,
                            backgroundConfirmColor: Colors.green,
                            textCancelColor: Colors.grey,
                            backgroundCancelColor: Colors.grey.shade200,
                          );
                        },
                        title: "ยกเลิก",
                        color: AppColors.red,
                        iconImage: AppIcons.close,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: (state.dataOnly[index].images.length == 0)
                        ? null
                        : () {
                            showDocument(context: context, images: state.dataOnly[index].images);
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          const BoxShadow(
                            color: Color.fromRGBO(195, 219, 226, 0.30),
                            offset: Offset(3, 3),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 25, 20, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.dataOnly[index].mode}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 17, 52, 137), fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.calendar_month, size: 18),
                                    Text(
                                      " : " + state.dataOnly[index].date,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.access_time, size: 18),
                                    Text(
                                      " : " + state.dataOnly[index].type,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const ImageIcon(AssetImage(AppIcons.commentDot), size: 18),
                                    Text(
                                      " : " + state.dataOnly[index].reason,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    (state.dataOnly[index].images.length == 0)
                                        ? Container()
                                        : const Row(
                                            children: [
                                              Text(
                                                "ดูเอกสารเพิ่มเติม ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_sharp,
                                                size: 14,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                    KonButton(
                                      onpressed: () {},
                                      bgColor: (state.dataOnly[index].status == 'Approve')
                                          ? const Color.fromARGB(255, 231, 246, 228)
                                          : (state.dataOnly[index].status == 'Pending')
                                              ? const Color.fromARGB(255, 250, 237, 220)
                                              : (state.dataOnly[index].status == "Reject")
                                                  ? Colors.red.shade100
                                                  : Colors.grey.shade300,
                                      width: 100,
                                      height: 30,
                                      title: state.dataOnly[index].status,
                                      titleStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: (state.dataOnly[index].status == 'Approve')
                                            ? const Color.fromARGB(255, 46, 172, 40)
                                            : (state.dataOnly[index].status == 'Pending')
                                                ? const Color.fromARGB(255, 220, 145, 43)
                                                : (state.dataOnly[index].status == "Reject")
                                                    ? AppColors.red
                                                    : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 80,
                              height: 80,
                              child: Image.asset(
                                state.dataOnly[index].mode == "ลาป่วย"
                                    ? AppImages.cardSick
                                    : state.dataOnly[index].mode == "พักร้อน"
                                        ? AppImages.cardHoliday
                                        : state.dataOnly[index].mode == "ลากิจ"
                                            ? AppImages.cardWork
                                            : AppImages.cardSpacial,
                                fit: BoxFit.scaleDown,
                                height: 80,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class SidePane extends StatelessWidget {
  const SidePane({super.key, required this.onTap, required this.title, required this.color, this.icon, this.iconImage});
  final Function() onTap;
  final String title;
  final Color color;
  final IconData? icon;
  final String? iconImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 220,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(22.0),
              bottomRight: Radius.circular(22.0),
              topLeft: Radius.circular(22.0),
              bottomLeft: Radius.circular(22.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: Colors.white,
                  size: 33,
                ),
              if (iconImage != null)
                ImageIcon(
                  AssetImage(iconImage!),
                  color: Colors.white,
                  size: 33,
                ),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showDocument({required BuildContext context, required List images}) {
  double w = MediaQuery.of(context).copyWith().size.width;
  double h = MediaQuery.of(context).copyWith().size.height;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        titlePadding: EdgeInsets.zero,
        title: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.red),
          ),
        ),
        content: Container(
          width: h,
          height: w,
          child: ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    RouteSide.scalUp(
                      HeroPhotoViewRouteWrapper(
                        index: index.toString(),
                        imageProvider: NetworkImage(images[index]),
                      ),
                    )),
                child: Container(
                  width: w,
                  constraints: const BoxConstraints(minHeight: 200),
                  padding: const EdgeInsets.all(4),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.green,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
