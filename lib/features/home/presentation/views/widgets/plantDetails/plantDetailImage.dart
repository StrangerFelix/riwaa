import 'package:flutter/widgets.dart';
import 'package:riwaa/core/utilities/appAssets.dart';

class PlantDetailImage extends StatelessWidget {
  const PlantDetailImage({required this.potType,super.key});
  final String? potType;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Image(
        image: AssetImage(AppAssets.potImage(potType ?? "other")),
        fit: BoxFit.cover,
      ),
    );
  }
}