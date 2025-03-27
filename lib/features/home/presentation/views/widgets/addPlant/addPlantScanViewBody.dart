import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
  final MobileScannerController controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode], // Restrict to QR codes only
    detectionSpeed: DetectionSpeed.noDuplicates, // Balance between speed and resource usage
    facing: CameraFacing.back, // Use back camera
    torchEnabled: false, // Flash off by default
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isValidHash(String hash) {
    return hash.length == 37 && hash.startsWith("riwaa");
  }
  // riwaa8261debcdc7c973faeb787f1946f5272
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // QR Scanner with no overlay
        MobileScanner(
          controller: controller,
          scanWindow: Rect.largest,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              if (barcode.rawValue != null) {
                controller.stop();
                // Navigate to the next screen
                GoRouter.of(context).pushReplacement(
                  AppRouter.addPlant,
                  extra: isValidHash(barcode.rawValue!) 
                      ? barcode.rawValue!.substring(5) 
                      : "wrong"
                );
                break;
              }
            }
          },
        ),
        
        // App Bar
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