import 'package:flutter/cupertino.dart';
import 'package:united_proposals_app/admin/verified_person_screen.dart';
import 'package:united_proposals_app/resources/app_decoration.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/admin/update_panal_screen.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/models/category_model.dart';
import 'package:united_proposals_app/models/selection_model.dart';
import 'package:united_proposals_app/view/affiliate_program_widget/affiliate_program_widget.dart';
import '../controller/provider/affiliate_provider.dart';
import '../models/affiliate_program_model.dart';
import '../utils/app_colors.dart';
import '../utils/height_widths.dart';
import '../utils/text_style.dart';

final searchController = TextEditingController();

class DashboardViewAdmin extends StatefulWidget {
  static String route = "/dashboardViewAdmin";
  const DashboardViewAdmin({super.key});

  @override
  State<DashboardViewAdmin> createState() => _DashboardViewAdminState();
}

class _DashboardViewAdminState extends State<DashboardViewAdmin> {
  SelectionModel? tabModel;
  ScrollController scrollController = ScrollController();
  bool isAll = true;
  FocusNode searchFN = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var vm = Provider.of<AffiliateProvider>(context, listen: false);

      scrollController.animateTo(
        (vm.selectedCategoryIndex * 30).toDouble(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      context.read<AffiliateProvider>().fetchUserData();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AffiliateProvider>(builder: (context, vm, _) {
      return SafeArea(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // Navigate to the other page

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdatePanalScreen(),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
                backgroundColor: AppColors.blue, // Customize button color
                elevation: 2.0, // Add elevation
                tooltip: 'Go to Second Page', // Add a tooltip
              ),
              appBar: GlobalWidgets.appBar('ADMIN PANAL',
                  showbackButton: false,
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      VerifiedProfileAdmin()));
                        },
                        child: Text("Verified Profiles"))
                  ]),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h2,
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              vm.isAll = true;
                              vm.categoryCategoryModel = null;
                              scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeInOut,
                              );
                              vm.update();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8.sp),
                              padding: EdgeInsets.all(8.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: vm.isAll
                                    ? AppColors.blue
                                    : AppColors.grey.withOpacity(.6),
                              ),
                              child: Text(
                                "All",
                                style: AppTextStyles.poppinsMedium(
                                  fontSize: 12.sp,
                                  color: vm.isAll
                                      ? AppColors.white
                                      : AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          w1,
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: scrollController,
                              child: Row(
                                children: List.generate(
                                  vm.categoryList.length,
                                  (index) => catoegoryWidget(
                                      vm.categoryList[index], vm, index),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      h3,
                      searchField(),
                      h3,
                      Consumer<AffiliateProvider>(
                        builder: (context, provider, child) {
                          if (vm.isAll) {
                            return buildAffiliateProgramList(provider.userList);
                          } else {
                            String? categoryName =
                                vm.categoryCategoryModel!.name;
                            if (categoryName == "Marriage Halls") {
                              categoryName = "Marriage_Halls";
                            } else if (categoryName == "Car Rental Service") {
                              categoryName = "Car_Rental_Service";
                            } else if (categoryName == "Event Planner") {
                              categoryName = "Event_Planner";
                            } else if (categoryName == "Nikah khawan") {
                              categoryName = "Nikah_khawan";
                            }
                            List<AffilateProgramModel> filteredList = provider
                                .userList
                                .where((user) => user.category == categoryName)
                                .toList();

                            return buildAffiliateProgramList(
                                filteredList.cast<AffilateProgramModel>());
                          }
                        },
                      )
                    ],
                  ),
                ),
              )));
    });
  }

  Widget buildAffiliateProgramList(List<AffilateProgramModel> userList) {
    if (userList.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: userList.map((user) {
          return AffiliateProgramWidget(
            model: AffilateProgramModel(
              profileImage: user.profileImage,
              phoneNumber: user.phoneNumber,
              email: user.email,
              about: user.about,
              location: user.location,
              fullName: user.fullName,
              category: user.category,
            ),
          );
        }).toList(),
      );
    } else if (userList.isEmpty) {
      return Center(child: Text("No Data"));
    } else
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
  }

  Widget catoegoryWidget(CategoryModel model, AffiliateProvider vm, var index) {
    return InkWell(
      onTap: () {
        vm.isAll = false;
        vm.categoryCategoryModel = model;
        scrollController.animateTo(
          (index * 30).toDouble(),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        vm.update();
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.sp),
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: vm.categoryCategoryModel == model
              ? AppColors.blue
              : AppColors.grey.withOpacity(.6),
        ),
        child: Text(
          model.name.toString(),
          style: AppTextStyles.poppinsMedium(
            fontSize: 12.sp,
            color: vm.categoryCategoryModel == model
                ? AppColors.white
                : AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget searchField() {
    return TextFormField(
        focusNode: FocusNode(),
        controller: searchController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          debugPrint('Search term changed: $value');
        },
        onTap: () {
          debugPrint('Search field tapped');
        },
        onFieldSubmitted: (value) {
          debugPrint('Search submitted: $value');
        },
        decoration: AppDecoration.fieldDecoration(
          hintText: "Search",
          preIcon: Icon(
            Icons.search,
            color: FocusNode().hasFocus ? AppColors.primary : Colors.grey,
          ),
        ));
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   searchController.dispose();
  // }
}
