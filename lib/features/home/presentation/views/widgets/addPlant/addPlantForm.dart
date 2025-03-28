import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/customFormButton.dart';
import 'package:riwaa/core/components/customTextField.dart';
import 'package:riwaa/core/components/fancyDropdown.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/data/models/addPlantDroplist.dart';
import 'package:riwaa/features/home/presentation/manager/addPlant/addPlantCubit.dart';
import 'package:riwaa/features/home/presentation/manager/addPlant/addPlantStates.dart';
import 'package:riwaa/features/home/presentation/manager/home/homeCubit.dart';

class AddPlantForm extends StatefulWidget {
  const AddPlantForm({required this.hash, super.key});
  final String hash;

  @override
  State<AddPlantForm> createState() => _AddPlantFormState();
}

class _AddPlantFormState extends State<AddPlantForm> {
  DropdownItem<String>? selectedItem;
  final _formKey = GlobalKey<FormState>();
  bool dropdownNullIndicator = false;
  bool isPlantExisted = true; // to hide the form until the plant is checked
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPlantCubit, AddPlantStates>(
      listener: (context, state) async{
        if (state is AddPlantFailure) {
          GoRouter.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
        // if (state is AddPlantSuccess) {
        //   print(state.message);
        // }
        if (state is AddPlantSuccess) {
          Navigator.pop(context);
          BlocProvider.of<HomeCubit>(context).getHomeData();
        }
        if (state is AddPlantCheck) {
          if (state.isPlantExisted) {
            await BlocProvider.of<AddPlantCubit>(context).addPlant(
              name: '', 
              type: '', 
              uId: widget.hash, 
              isPlantExisted: true
            );
            
          } else {
            isPlantExisted = false;
          }
          
        }
      },
      builder: (context, state) {
        if ((isPlantExisted && (state is AddPlantLoading || state is AddPlantCheck))) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else {
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
                const SizedBox(
                  height: 20,
                ),
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
                dropdownNullIndicator
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'اختار نوع النبتة',
                              style: AppStyles.paragraphSmall
                                  .copyWith(color:  Colors.red, fontSize: 12),
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                state is! AddPlantLoading ? CustomFormButton(
                    onTap: () {
                      setState(() {
                        selectedItem != null
                            ? dropdownNullIndicator = false
                            : dropdownNullIndicator = true;
                      });
                      if (_formKey.currentState!.validate() &&
                          !dropdownNullIndicator) {
                        BlocProvider.of<AddPlantCubit>(context).addPlant(
                          name: nameController.text,
                          type: selectedItem!.value,
                          uId: widget.hash,
                          isPlantExisted: false
                        );
                      }
                    },
                    text: 'إضافة النبتة'
                  ) : const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
              ],
            ),
          ),
        );
        }
      },
    );
  }
}