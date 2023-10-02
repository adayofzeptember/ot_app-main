import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ot_app/utils/app_color.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ot_app/utils/app_image.dart';

import '../../blocs/check_in_out/check_in_out_bloc.dart';

class PageScan extends StatefulWidget {
  const PageScan({Key? key}) : super(key: key);

  @override
  State<PageScan> createState() => _PageScanState();
}

class _PageScanState extends State<PageScan> {
  late MobileScannerController cameraController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraController = MobileScannerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            // fit: BoxFit.contain,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              // final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
                context.read<CheckInOutBloc>().add(ScanQrCode(scanText: "${barcode.rawValue}"));
              }
              // print('barcode.image ${image}');
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.scanQr,
                    fit: BoxFit.fitWidth,
                    color: Colors.black54,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<CheckInOutBloc, CheckInOutState>(
                    builder: (context, state) {
                      if (state.scanText != "") {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Text(
                            state.scanText,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                cameraController.toggleTorch();
              },
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 80),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.white,
                ),
                child: ValueListenableBuilder(
                  valueListenable: cameraController.torchState,
                  builder: (context, state, child) {
                    switch (state as TorchState) {
                      case TorchState.off:
                        return const Icon(Icons.flashlight_off_outlined, size: 50, color: Colors.grey);
                      case TorchState.on:
                        return const Icon(Icons.flashlight_on_outlined, size: 50, color: Colors.yellow);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'iconScan',
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(20)),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close, color: AppColors.red, size: 33),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
