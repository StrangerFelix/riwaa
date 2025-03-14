import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/presentation/views/widgets/addPlant/addPlantAppBar.dart';


class AddPlantScanViewBody extends StatefulWidget {
  const AddPlantScanViewBody({super.key});

  @override
  State<AddPlantScanViewBody> createState() => _AddPlantScanViewBodyState();
}

class _AddPlantScanViewBodyState extends State<AddPlantScanViewBody> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.pauseCamera();
    controller?.dispose();
    super.dispose();
  }
  @override
  void reassemble() {
    super.reassemble();
    controller?.dispose();
    controller = null;
  }

  bool isValidHash(String hash) {
    return hash.length == 37 && hash.startsWith("riwaa");
  }
  void _onQRViewCreated(QRViewController controller) {
    
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller.pauseCamera();
        // ignore: use_build_context_synchronously
        GoRouter.of(context).pushReplacement(
          AppRouter.addPlant,
          extra: isValidHash(scanData.code!) ? scanData.code!.substring(5) : "wrong"
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          // QR Scanner with no overlay
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: null, // No built-in overlay
          ),
          
          const AddPlantAppBar(),
          // Custom SVG overlay
          Opacity(
            opacity: 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.qrcode,
                  width: MediaQuery.sizeOf(context).width
                ),
                Text(
                  'صور الـQR Code الموجود على علبة جهاز رِواء',
                  style: AppStyles.paragraphMedium.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),
          ),   
        ],
      );
  }
}

