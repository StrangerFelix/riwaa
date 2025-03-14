import 'package:flutter/material.dart';
import 'package:riwaa/core/components/customFormButton.dart';
import 'package:riwaa/core/components/customTextField.dart';
import 'package:riwaa/core/components/fancyDropdown.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/data/models/addPlantDroplist.dart';

class AddPlantForm extends StatefulWidget {
  const AddPlantForm({required this.hash,super.key});
  final String hash;

  @override
  State<AddPlantForm> createState() => _AddPlantFormState();
}

class _AddPlantFormState extends State<AddPlantForm> {
  DropdownItem<String>? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const CustomTextField(hintText: 'اسم النبتة'),
              const CustomTextField(
                hint: 'تسمية النبتة',
              ),
              const SizedBox(height: 20,),
              FancyDropdown<String>(
                items: items,
                value: selectedItem,
                hint: 'نوع النبتة',
                onChanged: (item) {
                  setState(() {
                    selectedItem = item;
                  });
                },
                accentColor: kPrimaryColor,
                backgroundColor: Colors.white,
                showSearchBox: true,
                searchHint: 'بحث...',
              ),
              const SizedBox(height: 20,),
              CustomFormButton(onTap: () {}, text: 'إضافة النبتة'),
            ],
          ),
        );
  }
}