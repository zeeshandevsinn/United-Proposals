import 'dart:developer';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:united_proposals_app/admin/dashboard_view.dart';
import 'package:united_proposals_app/admin/enums.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/common-widgets/phone_number_field.dart';
import 'package:united_proposals_app/constants/enums.dart';
import 'package:united_proposals_app/controller/provider/affiliate_provider.dart';
import 'package:united_proposals_app/controller/provider/auth_provider.dart';
import 'package:united_proposals_app/controller/provider/root_provider.dart';
import 'package:united_proposals_app/models/selection_model.dart';
import 'package:united_proposals_app/resources/app_decoration.dart';
import 'package:united_proposals_app/resources/validator.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';

import '../common-widgets/custom_button.dart';
import '../common-widgets/custom_textformfield.dart';
import '../models/how_to_here_model.dart';
import '../utils/app_colors.dart';
import '../utils/height_widths.dart';
import '../utils/text_style.dart';

class UpdatePanalScreen extends StatefulWidget {
  static String route = '/UpdatePanalScreen';
  final bool? isFromLogin;
  UpdatePanalScreen({super.key, this.isFromLogin}) {
    // TODO: implement UpdatePanalScreen
  }

  @override
  State<UpdatePanalScreen> createState() => _DashboardViewAdminState();
}

class _DashboardViewAdminState extends State<UpdatePanalScreen> {
  File? profileImage;
  double height = 150;
  String profileImageUrl = "";
  String location = "";
  // ignore: unused_field
  Position? _currentPosition;
  FocusNode fullNameF = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode locationF = FocusNode();
  FocusNode religionF = FocusNode();
  FocusNode genderFn = FocusNode();
  FocusNode categoryFn = FocusNode();

  final auth = FirebaseAuth.instance;

  TextEditingController fullNameCon = TextEditingController();
  TextEditingController phoneNO = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController religionCon = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  DateTime? selectedDate;
  FocusNode dateFocus = FocusNode();
  FocusNode aboutFocus = FocusNode();
  FocusNode howDidYouHereFn = FocusNode();

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  DateTime? currentBackPressTime;

  FocusNode numberF = FocusNode();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ZBotToast.showToastError(message: "Click exit again!");
      return Future.value(false);
    }
    return Future.value(true);
  }

  dynamic args;
  bool? isFromLogin;
  geoLocation(context) async {
    try {
      if (!(await Permission.location.isGranted)) {
        await Permission.location.request();
        return;
      }
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true);

      // ignore: unnecessary_null_comparison
      if (position != null) {
        location = _getAddressFromLatLng(context, position);
        return location;
      }
    } catch (e) {
      ZBotToast.showToastError(message: e.toString());
    }
  }

  _getAddressFromLatLng(context, _currentPosition) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];
      // ignore: unnecessary_null_comparison
      if (place != null) {
        var _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        return _currentAddress;
      }
    } catch (e) {
      ZBotToast.showToastError(message: e.toString());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args["isFromLogin"] != null) {
          isFromLogin = args["isFromLogin"];
        }
      }
      setState(() {});
    });
    super.initState();
    // geoLocation(context);
  }

  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  TextEditingController phoneNumberController = TextEditingController();
  Future<String> uploadImageToFirebase(File imageFile) async {
    // Initialize Firebase Storage
    final FirebaseStorage _storage = FirebaseStorage.instance;
    Reference storageReference = _storage
        .ref()
        .child('user_profile/${DateTime.now().microsecondsSinceEpoch}');

    // Upload image to Firebase Storage
    await storageReference.putFile(imageFile);

    // Get the download URL of the uploaded image
    String imageUrl = await storageReference.getDownloadURL();

    return imageUrl;
  }

  Future<Reference> getRootReference() async {
    try {
      return await FirebaseStorage.instance.ref();
    } catch (e) {
      // Handle the exception, e.g., log it or show an error message.
      print('Error getting root reference: $e');
      throw e; // Re-throw the exception to propagate it.
    }
  }

  Future<void> addData(File image) async {
    try {
      debugger();
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = await getRootReference();
      Reference referenceDirImages = referenceRoot.child('user_profile/');
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);

      await referenceImageToUpload.putFile(File(image.path));

      String downloadUrl = await referenceImageToUpload.getDownloadURL();
      profileImageUrl = downloadUrl;
      setState(() {});
      print('Data added to Firestore');
    } catch (e) {
      ZBotToast.showToastError(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthVM, AffiliateProvider>(
      builder: (context, authVm, vm, _) {
        return WillPopScope(
          onWillPop: () async => await onWillPop(),
          child: SafeArea(
            child: Scaffold(
              appBar: GlobalWidgets.appBar(
                (isFromLogin ?? false) ? "Complete Profile" : "Update Profile",
                showbackButton: !(isFromLogin ?? false),
              ),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 11.0, horizontal: 17),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h1,
                    pickImageWidget(),
                    h2,
                    CustomTextFormField(
                      controller: fullNameCon,
                      hintText: 'Enter full Name',
                      focusNode: fullNameF,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.name,
                      validator: FieldValidator.validateEmpty,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    h1,
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Enter Email',
                      focusNode: emailFN,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.name,
                      validator: FieldValidator.validateEmpty,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    PhoneNumberField(
                      fieldTitle: "Phone Number",
                      number: number,
                      nextNode: locationF,
                      numberFN: numberF,
                      phoneNumberController: phoneNumberController,
                      // valueChanged: ,
                    ),
                    h1,
                    CategorySelected(vm: vm),
                    h1,
                    CustomTextFormField(
                      controller: locationController,
                      hintText: 'Enter Location',
                      focusNode: locationF,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      validator: FieldValidator.validateEmpty,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    h1,
                    Container(
                      margin:
                          EdgeInsets.only(left: 4.sp, bottom: 4.sp, top: 6.sp),
                      child: Text("About",
                          style: AppTextStyles.poppinsMedium(
                            fontSize: 11.sp,
                            color: Colors.black,
                          )),
                    ),
                    h1,
                    CustomTextFormField(
                      controller: aboutController,
                      hintText: 'Write here...',
                      focusNode: aboutFocus,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      maxLines: 3,
                    ),
                    h1,
                    CSCPicker(
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.ENABLE,

                      countrySearchPlaceholder: "Country",
                      stateSearchPlaceholder: "State",
                      citySearchPlaceholder: "City",

                      ///labels for dropdown
                      countryDropdownLabel: "Country",
                      stateDropdownLabel: "State",
                      cityDropdownLabel: "City",

                      onCountryChanged: (value) =>
                          setState(() => countryValue = value),
                      onStateChanged: (value) =>
                          setState(() => stateValue = value ?? ""),
                      onCityChanged: (value) =>
                          setState(() => cityValue = value ?? ""),

                      dropdownDialogRadius: 10.0,
                      searchBarRadius: 10.0,

                      dropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: AppColors.primary.withOpacity(.05),
                          border:
                              Border.all(color: AppColors.primary, width: 1)),

                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: AppColors.grey.withOpacity(.25),
                          border: Border.all(
                              color: AppColors.grey.withOpacity(.25))),
                      selectedItemStyle: AppTextStyles.poppinsRegular(
                          color: Colors.black, fontSize: 12.sp),
                      dropdownItemStyle: AppTextStyles.poppinsRegular(
                          color: Colors.black, fontSize: 12.sp),
                      dropdownHeadingStyle: AppTextStyles.poppinsBold(
                          color: AppColors.primary, fontSize: 15.sp),
                    ),
                    h2,
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.all(12.sp),
                child: CustomButton(
                  text: (isFromLogin ?? false) ? "Next" : "Save",
                  tap: () async {
                    ZBotToast.loadingShow();
                    try {
                      debugger();
                      await addData(profileImage!);

                      String useruid =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      debugger();
                      print(useruid);
                      await FirebaseFirestore.instance
                          .collection("admin_users_client")
                          .doc(useruid)
                          .set({
                        "profileImage": profileImageUrl,
                        // printUserDataAsJson()
                        "fullName": fullNameCon.text.toString(),

                        "email": emailController.text.toString(),
                        "Category": selectedCategoryList?.name,
                        "Location": locationController.text,
                        "PhoneNumber": phoneNumberController.text.toString(),
                        "about": aboutController.text,
                        "country": countryValue,
                        "state": stateValue,
                        "city": cityValue,
                      }).then((value) {
                        // debugger();
                        ZBotToast.loadingClose();
                        geoLocation(context);
                        ZBotToast.showToastSuccess(
                            message: "Successfully Data Saved");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DashboardViewAdmin()),
                            (route) => false);
                      }).onError((error, stackTrace) {
                        ZBotToast.showToastError(message: error.toString());
                      });
                    } catch (e) {
                      ZBotToast.showToastError(message: e.toString());
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ReligionEnum? religionSelection;
  SelectionModel? castSelection;
  SelectionModel? cristianSectSelection;
  SelectionModel? sectSelection;
  //GenderEnum? selectedGenderEnum;
  CategroyList? selectedCategoryList;

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

  Widget CategorySelected({required AffiliateProvider vm}) {
    return DropdownButtonFormField<CategroyList>(
      focusNode: categoryFn,
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: CategroyList.values.map((CategroyList m) {
        return DropdownMenuItem<CategroyList>(
          value: m,
          child: Text(
            m.name.capitalizeFirst ?? "",
            style: AppTextStyles.poppinsRegular(
              fontSize: 8.sp,
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
      decoration: AppDecoration.fieldDecoration(hintText: "Category"),
      value: selectedCategoryList,
      onChanged: (CategroyList? newValue) {
        setState(() {
          selectedCategoryList = newValue;
        });
      },
    );
  }

  Widget pickImageWidget() {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () async {
        var imagePicker = ImagePicker();
        var image = await imagePicker.pickImage(source: ImageSource.gallery);
        profileImage = File(image!.path);
        setState(() {});
      },
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 50.sp,
            height: 50.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              border: Border.all(width: 3.0, color: AppColors.primary),
            ),
            child: Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue.withOpacity(.08)),
              child: profileImage == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Icon(
                        Icons.add,
                        size: 25.sp,
                        color: AppColors.primary,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.network(
                        profileImage!.path,
                        width: 40.sp,
                        height: 40.sp,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          w4,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Picture',
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinsMedium(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.black,
                  letterSpacing: 0.32,
                ),
              ),
              Text(
                'Click to upload image',
                style: AppTextStyles.poppinsRegular(
                  fontSize: 10.sp,
                  color: AppColors.grey,
                  letterSpacing: -0.012,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget heightSlider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'cm',
                style: AppTextStyles.poppinsMedium(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          // SfSliderTheme(
          //   data: SfSliderThemeData(
          //       tooltipBackgroundColor: AppColors.black,
          //       tooltipTextStyle: AppTextStyles.poppinsRegular(
          //         fontSize: 8.sp,
          //         fontWeight: FontWeight.normal,
          //         color: AppColors.white,
          //       ),
          //       activeLabelStyle: AppTextStyles.poppinsRegular(
          //         fontSize: 8.sp,
          //         fontWeight: FontWeight.normal,
          //         color: AppColors.black,
          //       ),
          //       inactiveLabelStyle: AppTextStyles.poppinsRegular(
          //         fontSize: 8.sp,
          //         fontWeight: FontWeight.normal,
          //         color: AppColors.black,
          //       ),
          //       labelOffset: const Offset(0, 14)),
          //   child: SfSlider(
          //     min: 100,
          //     max: 200,
          //     value: height,
          //     showTicks: false,
          //     showLabels: false,
          //     enableTooltip: true,
          //     activeColor: AppColors.primary,
          //     inactiveColor: AppColors.grey,
          //     tooltipShape: const SfPaddleTooltipShape(),
          //     tooltipTextFormatterCallback:
          //         (dynamic actualValue, String formattedText) {
          //       return formattedText;
          //     },
          //     stepSize: 1,
          //     labelFormatterCallback:
          //         (dynamic actualValue, String formattedText) {
          //       return formattedText;
          //     },
          //     thumbIcon: DecoratedBox(
          //       decoration: BoxDecoration(
          //           border: Border.all(color: AppColors.primary),
          //           color: AppColors.white,
          //           shape: BoxShape.circle),
          //     ),
          //     minorTicksPerInterval: 1,
          //     onChanged: (value) {
          //       setState(() {
          //         height = value;
          //       });
          //     },
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '200',
                style: AppTextStyles.poppinsRegular(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(1998),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blue,
              onPrimary: AppColors.white,
              onSurface: AppColors.blue,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateCon.text = "${picked.month}/${picked.day}/${picked.year}";
      });
    }
  }

  HowToHereModel? howToHere;

  Widget howToHereDropDown({required RootProvider vm}) {
    return DropdownButtonFormField<HowToHereModel?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.howToHereList
          .map((item) => DropdownMenuItem<HowToHereModel?>(
                value: item,
                child: Text(
                  item.name ?? "",
                  style: AppTextStyles.poppinsRegular(
                      color: AppColors.black, fontSize: 8.sp),
                ),
              ))
          .toList(),
      decoration:
          AppDecoration.fieldDecoration(hintText: "How did you here about us "),
      value: howToHere,
      validator: (value) {
        if (value == null) {
          return "required";
        }
        return null;
      },
      onChanged: (value) {
        howToHere = value;
        setState(() {});
      },
    );
  }

  GenderModel? genderSelection;

  Widget genderDropDown({required RootProvider vm}) {
    return DropdownButtonFormField<GenderModel?>(
      borderRadius: BorderRadius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: vm.genderList
          .map((item) => DropdownMenuItem<GenderModel?>(
                value: item,
                child: Text(
                  item.name ?? "",
                  style: AppTextStyles.poppinsRegular(
                      color: AppColors.black, fontSize: 8.sp),
                ),
              ))
          .toList(),
      decoration: AppDecoration.fieldDecoration(hintText: "Gender"),
      value: genderSelection,
      validator: (value) {
        if (value == null) {
          return "required";
        }
        return null;
      },
      onChanged: (value) {
        genderSelection = value;
        setState(() {});
      },
    );
  }

// Add this method to your _SignupScreenState class
  // void printUserDataAsJson() {
  //   final userData = {
  //     "firstName": firstNameCon.text,
  //     "lastName": lastNameCon.text,
  //     "maritalStatus": selectedMaritalStatus?.name,
  //     "color": colorCon.text,
  //     "height": height,
  //     "religion": religionSelection?.name,
  //     "dateOfBirth": dateCon.text,
  //     "gender": genderSelection?.name,
  //     "howDidYouHearAboutUs": howToHere?.name,
  //     "about": aboutController.text,
  //     "country": countryValue,
  //     "state": stateValue,
  //     "city": cityValue,
  //   };

  //   if (religionSelection == ReligionEnum.chritian) {
  //     userData["christianSect"] = cristianSectSelection?.name;
  //   } else {
  //     userData["sect"] = sectSelection?.name;
  //     userData["cast"] = castSelection?.name;
  //   }

  //   final jsonUserData = jsonEncode(userData);
  //   debugPrint(jsonUserData);
  // }
}
