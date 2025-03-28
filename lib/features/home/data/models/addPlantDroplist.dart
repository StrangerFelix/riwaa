import 'package:riwaa/core/components/fancyDropdown.dart';

final List<DropdownItem<String>> items = [
  DropdownItem<String>(
    label: plantNaming['albizia'],
    value: 'albizia',
  ),
  DropdownItem<String>(
    label: plantNaming['gardenia'],
    value: 'gardenia',
  ),
  DropdownItem<String>(
    label: plantNaming['croton'],
    value: 'croton',
  ),
  DropdownItem<String>(
    label: plantNaming['ficus'],
    value: 'ficus',
  ),
  DropdownItem<String>(
    label: plantNaming['pothos'],
    value: 'pothos',
  ),
  DropdownItem<String>(
    label: 'غير ذلك',
    value: 'other',
  ),
];

Map plantNaming = {
  'albizia': 'ألبيزيا',
  'croton': 'كروتون',
  'ficus': 'الفيكس بينجامينا',
  'pothos': 'البوتس',
  'gardenia': 'كاردينيا',
  'other': ''
};