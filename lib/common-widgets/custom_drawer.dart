import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import '../constants/enums.dart';
import '../controller/provider/auth_provider.dart';
import '../controller/provider/root_provider.dart';
import '../models/gender_model.dart';
import '../models/martial_status_model.dart';
import '../models/selection_model.dart';
import '../resources/app_decoration.dart';
import '../utils/height_widths.dart';
import '../utils/text_style.dart';
import 'custom_button.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  List<GenderModelDrawer> genders = [
    GenderModelDrawer(value: 'male', label: 'Male'),
    GenderModelDrawer(value: 'female', label: 'Female'),
    GenderModelDrawer(value: 'other', label: 'Other'),
  ];

  List<MaritalStatusModel> maritalStatuses = [
    MaritalStatusModel(value: 'single', label: 'Single'),
    MaritalStatusModel(value: 'married', label: 'Married'),
  ];

  String selectedGender = 'male';
  String selectedMaritalStatus = 'single';

  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  bool isSingle = false;
  bool isMale = false;

  RangeValues values = const RangeValues(18, 35);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthVM, RootProvider>(builder: (context, authVm, vm, _) {
      return Drawer(
        child: DrawerHeader(
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Filter Options',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Age',
                style: AppTextStyles.poppinsSemiBold(fontSize: 12.sp),
              ),
              RangeSlider(
                activeColor: AppColors.primary,
                values: values,
                min: 0,
                max: 90,
                divisions: 90,
                labels: RangeLabels(
                  values.start.toInt().toString(),
                  values.end.toInt().toString(),
                ),
                onChanged: (RangeValues newValue) {
                  setState(() {
                    values = newValue;
                  });
                },
              ),
              h2,
              Text(
                'Gender',
                style: AppTextStyles.poppinsSemiBold(fontSize: 12.sp),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        addRadioButton(genders, selectedGender, (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              h2,
              Text(
                'Martial Status',
                style: AppTextStyles.poppinsSemiBold(fontSize: 12.sp),
              ),
              Row(
                children: <Widget>[
                  addMartialStatus(maritalStatuses, selectedMaritalStatus,
                      (value) {
                    setState(() {
                      selectedMaritalStatus = value;
                    });
                  }),
                ],
              ),
              h2,
              religionDropDown(vm: vm),
              h1,
              if (religionSelection == ReligionEnum.chritian)
                cristianSectDropDown(vm: vm)
              else
                sectDropDown(vm: vm),
              if (religionSelection != ReligionEnum.chritian) h1,
              if (religionSelection != ReligionEnum.chritian)
                castDropDown(vm: vm),
              h1,
              h2,
              buttons(),
            ]),
          ),
        ),
      );
    });
  }

  Row addRadioButton(List<GenderModelDrawer> options, String selectedValue,
      Function(String) onValueChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: options.map((option) {
        return Row(
          children: <Widget>[
            Radio(
              activeColor: AppColors.primary,
              value: option.value,
              groupValue: selectedValue,
              onChanged: (value) {
                onValueChanged(value as String);
              },
            ),
            Text(option.label)
          ],
        );
      }).toList(),
    );
  }

  Row addMartialStatus(List<MaritalStatusModel> options, String selectedValue,
      Function(String) onValueChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: options.map((option) {
        return Row(
          children: <Widget>[
            Radio(
              activeColor: AppColors.primary,
              value: option.value,
              groupValue: selectedValue,
              onChanged: (value) {
                onValueChanged(value as String);
              },
            ),
            Text(option.label)
          ],
        );
      }).toList(),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: CustomButton(
          color: AppColors.blue,
          text: "Reset",
          tap: () {
            resetFilters();
          },
          textColor: AppColors.white,
        )),
        w2,
        Expanded(
            child: CustomButton(
          color: AppColors.primary,
          text: "Apply",
          tap: () {
            printSelectedValues();
          },
          textColor: AppColors.white,
        )),
      ],
    );
  }

  ReligionEnum? religionSelection;
  SelectionModel? castSelection;
  SelectionModel? cristianSectSelection;
  SelectionModel? sectSelection;

  Widget religionDropDown({required RootProvider vm}) {
    return DropdownButtonFormField<ReligionEnum?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.religionList
          .map((item) => DropdownMenuItem<ReligionEnum?>(
                value: item,
                child: Text(
                  item.name,
                  style: AppTextStyles.poppinsRegular(
                      color: AppColors.black, fontSize: 8.sp),
                ),
              ))
          .toList(),
      decoration: AppDecoration.fieldDecoration(hintText: "Religion"),
      value: religionSelection,
      validator: (value) {
        if (value == null) {
          return "required";
        }
        return null;
      },
      onChanged: (value) {
        religionSelection = value;

        setState(() {});
        debugPrint(" religionSelection $religionSelection");
        debugPrint(" castSelection ${castSelection?.name}");
        debugPrint(" cristianSectSelection ${cristianSectSelection?.name}");
        debugPrint(" sectSelection ${sectSelection?.name}");
      },
    );
  }

  Widget sectDropDown({required RootProvider vm}) {
    return DropdownButtonFormField<SelectionModel?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.sectList
          .map((item) => DropdownMenuItem<SelectionModel?>(
                value: item,
                child: Text(
                  item.name ?? "",
                  style: AppTextStyles.poppinsRegular(
                      color: AppColors.black, fontSize: 8.sp),
                ),
              ))
          .toList(),
      decoration: AppDecoration.fieldDecoration(hintText: "Sect"),
      value: sectSelection,
      validator: (value) {
        if (value == null) {
          return "required";
        }
        return null;
      },
      onChanged: (value) {
        sectSelection = value;
        setState(() {});
      },
    );
  }

  Widget castDropDown({required RootProvider vm}) {
    return DropdownButtonFormField<SelectionModel?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.castList
          .map((item) => DropdownMenuItem<SelectionModel?>(
                value: item,
                child: Text(
                  item.name ?? "",
                  style: AppTextStyles.poppinsRegular(
                      color: AppColors.black, fontSize: 8.sp),
                ),
              ))
          .toList(),
      decoration: AppDecoration.fieldDecoration(hintText: "Cast"),
      value: castSelection,
      validator: (value) {
        if (value == null) {
          return "required";
        }
        return null;
      },
      onChanged: (value) {
        castSelection = value;
      },
    );
  }

  Widget cristianSectDropDown({required RootProvider vm}) {
    return DropdownButtonFormField<SelectionModel?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.cristianSectList
          .map((item) => DropdownMenuItem<SelectionModel?>(
                value: item,
                child: Text(
                  item.name ?? "",
                  style: AppTextStyles.poppinsRegular(
                      color: AppColors.black, fontSize: 8.sp),
                ),
              ))
          .toList(),
      decoration: AppDecoration.fieldDecoration(hintText: "Sect"),
      value: cristianSectSelection,
      validator: (value) {
        if (value == null) {
          return "required";
        }
        return null;
      },
      onChanged: (value) {
        cristianSectSelection = value;
        setState(() {});
      },
    );
  }

  void resetFilters() {
    setState(() {
      selectedGender = 'male';
      selectedMaritalStatus = 'single';
      // Reset other selected values as needed
      religionSelection = null;
      castSelection = null;
      sectSelection = null;
      cristianSectSelection = null;
      // Reset age values, if applicable
      values = const RangeValues(20, 25);
    });
  }

  void printSelectedValues() {
    // print("Selected Gender: $selectedGender");
    // print("Selected Marital Status: $selectedMaritalStatus");
    // // Print other selected values as needed
    // print("Selected Religion: ${religionSelection?.name}");
    // print("Selected Sect: ${sectSelection?.name}");
    // print("Selected Cast: ${castSelection?.name}");
    // print("Selected Cristian Sect: ${cristianSectSelection?.name}");
    // // Print age values, if applicable
    // print("Selected Age Range: ${values.start}-${values.end}");
  }
}
