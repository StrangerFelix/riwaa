import 'package:flutter/material.dart';
import 'package:riwaa/core/components/customFormButton.dart';
import 'package:riwaa/core/components/customTextField.dart';
import 'package:riwaa/core/components/fancyDropdown.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
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
  final _formKey = GlobalKey<FormState>();
  bool dropdownNullIndicator = false;
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const CustomTextField(hintText: 'اسم النبتة'),
                CustomTextField(
                  hint: 'تسمية النبتة',
                  controller: nameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'ادخل اسم النبتة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                FancyDropdown<String>(
                  items: items,
                  value: selectedItem,
                  isNull: dropdownNullIndicator,
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
                dropdownNullIndicator ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5,),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'اختار نوع النبتة',
                        style: AppStyles.paragraphSmall.copyWith(
                          color: Colors.red,
                          fontSize: 12
                        ),
                      ),
                    )
                  ],
                ) : const SizedBox(),
                const SizedBox(height: 20,),
                CustomFormButton(
                  onTap: () {
                    setState(() {
                      selectedItem != null ? dropdownNullIndicator = false : dropdownNullIndicator = true;
                    });
                    if (_formKey.currentState!.validate() && !dropdownNullIndicator) {
                      // Map<String,String?> data = {
                      //   'name': nameController.text,
                      //   'type': selectedItem?.value,
                      //   'hash': widget.hash
                      // };
                    }
                  }, 
                  text: 'إضافة النبتة'
                ),
              ],
            ),
          ),
        );
  }
}