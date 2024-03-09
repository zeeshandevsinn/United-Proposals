import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/models/category_model.dart';
import 'package:united_proposals_app/models/selection_model.dart';
import 'package:united_proposals_app/view/affiliate_program_widget/affiliate_program_widget.dart';
import '../controller/provider/affiliate_provider.dart';
import '../models/affiliate_program_model.dart';
import '../utils/app_colors.dart';
import '../utils/height_widths.dart';
import '../utils/text_style.dart';

class AffiliateProgramScreen extends StatefulWidget {
  static String route = "/AffiliateProgramScreen";
  const AffiliateProgramScreen({super.key});

  @override
  State<AffiliateProgramScreen> createState() => _AffiliateProgramScreenState();
}

class _AffiliateProgramScreenState extends State<AffiliateProgramScreen> {
  SelectionModel? tabModel;
  bool isAll = true;
  final searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
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

      setState(() {});
    });
    context.read<AffiliateProvider>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AffiliateProvider>(builder: (context, vm, _) {
      return SafeArea(
          child: Scaffold(
              appBar: GlobalWidgets.appBar('Affiliate Program'),
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
                      // CustomTextFormField(
                      //   controller: searchController,
                      //   hintText: 'Search Here',
                      //   suffixIcon: const Icon(Icons.search),
                      // ),
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

                      // Consumer<AffiliateProvider>(
                      //   builder: (context, provider, child) {
                      //     // debugger();
                      //     if (vm.isAll) {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ...List.generate(
                      //             provider.userList.length,
                      //             (index) => AffiliateProgramWidget(
                      //               model: AffilateProgramModel(
                      //                 profileImage:
                      //                     provider.userList[index].profileImage,
                      //                 phoneNumber:
                      //                     provider.userList[index].phoneNumber,
                      //                 email: provider.userList[index].email,
                      //                 about: provider.userList[index].about,
                      //                 // city: provider.userList.('city'),
                      //                 location:
                      //                     provider.userList[index].location,
                      //                 // country: provider.userList.('country'),
                      //                 fullName:
                      //                     provider.userList[index].fullName,
                      //                 category:
                      //                     provider.userList[index].category,
                      //                 // state: provider.userList.('state'),
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       );
                      //     } else if (vm.categoryCategoryModel!.name ==
                      //         "Marriage Halls") {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ...List.generate(provider.userList.length,
                      //               (index) {
                      //             if (provider.userList[index].category ==
                      //                 "Marriage_Halls") {
                      //               var i = 0;
                      //               i++;
                      //               return AffiliateProgramWidget(
                      //                 model: AffilateProgramModel(
                      //                   profileImage: provider
                      //                       .userList[index].profileImage,
                      //                   phoneNumber: provider
                      //                       .userList[index].phoneNumber,
                      //                   email: provider.userList[index].email,
                      //                   about: provider.userList[index].about,
                      //                   // city: provider.userList.('city'),
                      //                   location:
                      //                       provider.userList[index].location,
                      //                   // country: provider.userList.('country'),
                      //                   fullName:
                      //                       provider.userList[index].fullName,
                      //                   category:
                      //                       provider.userList[index].category,
                      //                   // state: provider.userList.('state'),
                      //                 ),
                      //               );
                      //             } else if (1 > 0) {
                      //               return Container();
                      //             }
                      //             return Text("No Data");
                      //           })
                      //         ],
                      //       );
                      //     } else if (vm.categoryCategoryModel!.name ==
                      //         "Marquee") {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ...List.generate(provider.userList.length,
                      //               (index) {
                      //             if (provider.userList[index].category ==
                      //                 "Marquee") {
                      //               return AffiliateProgramWidget(
                      //                 model: AffilateProgramModel(
                      //                   profileImage: provider
                      //                       .userList[index].profileImage,
                      //                   phoneNumber: provider
                      //                       .userList[index].phoneNumber,
                      //                   email: provider.userList[index].email,
                      //                   about: provider.userList[index].about,
                      //                   // city: provider.userList.('city'),
                      //                   location:
                      //                       provider.userList[index].location,
                      //                   // country: provider.userList.('country'),
                      //                   fullName:
                      //                       provider.userList[index].fullName,
                      //                   category:
                      //                       provider.userList[index].category,
                      //                   // state: provider.userList.('state'),
                      //                 ),
                      //               );
                      //             } else if (1 > 0) {
                      //               return Container();
                      //             }
                      //             return Text("No Data");
                      //           })
                      //         ],
                      //       );
                      //     } else if (vm.categoryCategoryModel!.name ==
                      //         "Jewellers") {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ...List.generate(provider.userList.length,
                      //               (index) {
                      //             if (provider.userList[index].category ==
                      //                 "Jewellers") {
                      //               return AffiliateProgramWidget(
                      //                 model: AffilateProgramModel(
                      //                   profileImage: provider
                      //                       .userList[index].profileImage,
                      //                   phoneNumber: provider
                      //                       .userList[index].phoneNumber,
                      //                   email: provider.userList[index].email,
                      //                   about: provider.userList[index].about,
                      //                   // city: provider.userList.('city'),
                      //                   location:
                      //                       provider.userList[index].location,
                      //                   // country: provider.userList.('country'),
                      //                   fullName:
                      //                       provider.userList[index].fullName,
                      //                   category:
                      //                       provider.userList[index].category,
                      //                   // state: provider.userList.('state'),
                      //                 ),
                      //               );
                      //             } else if (1 > 0) {
                      //               return Container();
                      //             }
                      //             return Text("No Data");
                      //           })
                      //         ],
                      //       );
                      //     } else if (vm.categoryCategoryModel!.name ==
                      //         "Caterers") {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ...List.generate(provider.userList.length,
                      //               (index) {
                      //             if (provider.userList[index].category ==
                      //                 "Caterers") {
                      //               return AffiliateProgramWidget(
                      //                 model: AffilateProgramModel(
                      //                   profileImage: provider
                      //                       .userList[index].profileImage,
                      //                   phoneNumber: provider
                      //                       .userList[index].phoneNumber,
                      //                   email: provider.userList[index].email,
                      //                   about: provider.userList[index].about,
                      //                   // city: provider.userList.('city'),
                      //                   location:
                      //                       provider.userList[index].location,
                      //                   // country: provider.userList.('country'),
                      //                   fullName:
                      //                       provider.userList[index].fullName,
                      //                   category:
                      //                       provider.userList[index].category,
                      //                   // state: provider.userList.('state'),
                      //                 ),
                      //               );
                      //             } else if (1 > 0) {
                      //               return Container();
                      //             }
                      //             return Text("No Data");
                      //           })
                      //         ],
                      //       );
                      //     } else if (vm.categoryCategoryModel!.name ==
                      //         "Car Rental Service") {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ...List.generate(provider.userList.length,
                      //               (index) {
                      //             if (provider.userList[index].category ==
                      //                 "Car_Rental_Service") {
                      //               return AffiliateProgramWidget(
                      //                 model: AffilateProgramModel(
                      //                   profileImage: provider
                      //                       .userList[index].profileImage,
                      //                   phoneNumber: provider
                      //                       .userList[index].phoneNumber,
                      //                   email: provider.userList[index].email,
                      //                   about: provider.userList[index].about,
                      //                   // city: provider.userList.('city'),
                      //                   location:
                      //                       provider.userList[index].location,
                      //                   // country: provider.userList.('country'),
                      //                   fullName:
                      //                       provider.userList[index].fullName,
                      //                   category:
                      //                       provider.userList[index].category,
                      //                   // state: provider.userList.('state'),
                      //                 ),
                      //               );
                      //             } else if (1 > 0) {
                      //               return Container();
                      //             }
                      //             return Text("No Data");
                      //           })
                      //         ],
                      //       );
                      //     } else if (vm.categoryCategoryModel!.name ==
                      //         "Decoration") {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ...List.generate(provider.userList.length,
                      //               (index) {
                      //             if (provider.userList[index].category ==
                      //                 "Decoration") {
                      //               return AffiliateProgramWidget(
                      //                 model: AffilateProgramModel(
                      //                   profileImage: provider
                      //                       .userList[index].profileImage,
                      //                   phoneNumber: provider
                      //                       .userList[index].phoneNumber,
                      //                   email: provider.userList[index].email,
                      //                   about: provider.userList[index].about,
                      //                   // city: provider.userList.('city'),
                      //                   location:
                      //                       provider.userList[index].location,
                      //                   // country: provider.userList.('country'),
                      //                   fullName:
                      //                       provider.userList[index].fullName,
                      //                   category:
                      //                       provider.userList[index].category,
                      //                   // state: provider.userList.('state'),
                      //                 ),
                      //               );
                      //             } else if (1 > 0) {
                      //               return Container();
                      //             }
                      //             return Text("No Data");
                      //           })
                      //         ],
                      //       );
                      //     } else if (vm.categoryCategoryModel!.name ==
                      //         "Nikah khawan") {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ...List.generate(provider.userList.length,
                      //               (index) {
                      //             // debugger();
                      //             if (provider.userList[index].category ==
                      //                 "Nikah_Khawan") {
                      //               return AffiliateProgramWidget(
                      //                 model: AffilateProgramModel(
                      //                   profileImage: provider
                      //                       .userList[index].profileImage,
                      //                   phoneNumber: provider
                      //                       .userList[index].phoneNumber,
                      //                   email: provider.userList[index].email,
                      //                   about: provider.userList[index].about,
                      //                   // city: provider.userList.('city'),
                      //                   location:
                      //                       provider.userList[index].location,
                      //                   // country: provider.userList.('country'),
                      //                   fullName:
                      //                       provider.userList[index].fullName,
                      //                   category:
                      //                       provider.userList[index].category,
                      //                   // state: provider.userList.('state'),
                      //                 ),
                      //               );
                      //             } else if (1 > 0) {
                      //               return Container();
                      //             }
                      //             return Text("No Data");
                      //           })
                      //         ],
                      //       );
                      //     } else if (vm.categoryCategoryModel!.name ==
                      //         "Event Planner") {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ...List.generate(provider.userList.length,
                      //               (index) {
                      //             // debugger();
                      //             if (provider.userList[index].category ==
                      //                 "Event_Planner") {
                      //               return AffiliateProgramWidget(
                      //                 model: AffilateProgramModel(
                      //                   profileImage: provider
                      //                       .userList[index].profileImage,
                      //                   phoneNumber: provider
                      //                       .userList[index].phoneNumber,
                      //                   email: provider.userList[index].email,
                      //                   about: provider.userList[index].about,
                      //                   // city: provider.userList.('city'),
                      //                   location:
                      //                       provider.userList[index].location,
                      //                   // country: provider.userList.('country'),
                      //                   fullName:
                      //                       provider.userList[index].fullName,
                      //                   category:
                      //                       provider.userList[index].category,
                      //                   // state: provider.userList.('state'),
                      //                 ),
                      //               );
                      //             } else if (1 > 0) {
                      //               return Container();
                      //             }
                      //             return Text("No Data");
                      //           })
                      //         ],
                      //       );
                      //     } else if (vm.categoryCategoryModel!.name ==
                      //         "Boutique") {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //          ...List.generate(provider.userList.length,
                      //               (index) {
                      //             // debugger();
                      //             if (provider.userList[index].category ==
                      //                 "Boutique") {
                      //               return AffiliateProgramWidget(
                      //                 model: AffilateProgramModel(
                      //                   profileImage: provider
                      //                       .userList[index].profileImage,
                      //                   phoneNumber: provider
                      //                       .userList[index].phoneNumber,
                      //                   email: provider.userList[index].email,
                      //                   about: provider.userList[index].about,
                      //                   // city: provider.userList.('city'),
                      //                   location:
                      //                       provider.userList[index].location,
                      //                   // country: provider.userList.('country'),
                      //                   fullName:
                      //                       provider.userList[index].fullName,
                      //                   category:
                      //                       provider.userList[index].category,
                      //                   // state: provider.userList.('state'),
                      //                 ),
                      //               );
                      //             } else if (1 > 0) {
                      //               return Container();
                      //             }
                      //             return Text("No Data");
                      //           })

                      //         ],
                      //       );
                      //     } else
                      //       return Center(child: Text("No Data"));
                      //   },
                      // ),
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
    } else {
      return Center(child: Text("No Data"));
    }
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
}
