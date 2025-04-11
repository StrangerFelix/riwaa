import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/customFormButton.dart';
import 'package:riwaa/core/components/customTextField.dart';
import 'package:riwaa/core/components/fancyDropdown.dart';
import 'package:riwaa/core/components/fancySlider.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/data/models/addPlantDroplist.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/presentation/manager/editPlantDetails/editPlantDetailsCubit.dart';
import 'package:riwaa/features/home/presentation/manager/editPlantDetails/editPlantDetailsStates.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsBloc.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsEvents.dart';

class EditPlantDetailsForm extends StatefulWidget {
  const EditPlantDetailsForm({required this.plant, super.key});
  final Plant plant;
  @override
  State<EditPlantDetailsForm> createState() => _EditPlantDetailsFormState();
}

class _EditPlantDetailsFormState extends State<EditPlantDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  bool minMoistureChange = false;
  bool maxMoistureChange = false;
  bool nameChange = false;
  bool typeChange = false;
  bool dropdownNullIndicator = false;
  DropdownItem<String>? selectedItem;
  double? minMoisture;
  double? maxMoisture;
  int getIndexByValue(String value) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].value == value) {
        return i;
      }
    }
    // Return -1 if the value isn't found
    return -1;
  }
  
  @override
  void initState() {
    minMoisture = (widget.plant.settings?.moistureMin ?? 35.0).toDouble();
    maxMoisture = (widget.plant.settings?.moistureMax ?? 75.0).toDouble();
    int index = getIndexByValue(widget.plant.type ?? 'other');
    selectedItem = index != -1 ? items[index] : null;
    nameController.text = widget.plant.name ?? '';
    nameController.addListener(_onTextChanged);
    super.initState();

  }
  void _onTextChanged() {
    if (nameController.text != widget.plant.name) {
      setState(() {
        nameChange = true;
      });
    } else {
      setState(() {
        nameChange = false;
      });
    }
  }
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Center(
        child: Padding(
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
                      if (item?.value == widget.plant.type) {
                        typeChange = false;
                      } else {
                        typeChange = true;
                      }
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
                                  .copyWith(color: Colors.red, fontSize: 12),
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                FancySlider(
                    value: minMoisture ?? 35.0,
                    activeColor: kPrimaryColor,
                    label: 'اقل نسبة رطوبة:',
                    min: 30,
                    max: 50,
                    onChanged: (val) {
                      setState(() {
                        minMoistureChange = true;
                        minMoisture = val;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                FancySlider(
                    activeColor: kPrimaryColor,
                    value: maxMoisture ?? 75.0,
                    min: 70,
                    max: 85,
                    label: 'اكبر نسبة رطوبة:',
                    onChanged: (val) {
                      setState(() {
                        maxMoistureChange = true;
                        maxMoisture = val;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<EditPlantDetailsCubit, EditPlantDetailsStates>(
                  listener: (context, state) {
                    if (state is EditPlantDetailsSuccess) {
                      GoRouter.of(context).pop();
                      context.read<PlantDetailsBloc>().add(GetPlantDetailsEvent(plantId: widget.plant.uId!, changed: true));
                      // context.read<PlantDetailsCubit>().getPlant(widget.plant.uId!);
                      // BlocProvider.of<PlantDetailsCubit>(context).getPlant(widget.plant.uId!);
                    }
                  },
                  builder: (context, state) {
                    if (state is EditPlantDetailsLoading) {
                      return const Center(child: CircularProgressIndicator(color: kPrimaryColor,),);
                    } else {
                      return CustomFormButton(
                        isDisabled: (!minMoistureChange && !maxMoistureChange && !nameChange && !typeChange),
                        onTap: () {
                          setState(() {
                            selectedItem != null ? dropdownNullIndicator = false : dropdownNullIndicator = true;
                          });
                          if (_formKey.currentState!.validate() && !dropdownNullIndicator && (minMoistureChange || maxMoistureChange || nameChange || typeChange) ) {
                            BlocProvider.of<EditPlantDetailsCubit>(context).editPlant(
                              name: nameController.text,
                              type: selectedItem!.value,
                              minMoisture: minMoisture!,
                              maxMoisture: maxMoisture!,
                              uId: widget.plant.uId
                            );
                          }
                        },
                        text: 'تعديل'
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
