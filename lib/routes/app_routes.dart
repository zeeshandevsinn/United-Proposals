import 'package:get/route_manager.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/view/affiliate_program_screen.dart';
import 'package:united_proposals_app/view/cnic_screen.dart';
import 'package:united_proposals_app/view/contact_us_screen.dart';
import 'package:united_proposals_app/view/favourite_screen.dart';
import 'package:united_proposals_app/view/featured_profile/featured_profiles_view.dart';
import 'package:united_proposals_app/view/login_screen.dart';
import 'package:united_proposals_app/view/notification/view/notification_view.dart';
import 'package:united_proposals_app/view/profile_detail_screen.dart';
import 'package:united_proposals_app/view/root_screen.dart';
import 'package:united_proposals_app/view/settings_screens/about_app.dart';
import 'package:united_proposals_app/view/settings_screens/privacy_policy_screen.dart';
import 'package:united_proposals_app/view/settings_screens/profile_visibility_controls.dart';
import 'package:united_proposals_app/view/settings_screens/term_of_use_screen.dart';
import 'package:united_proposals_app/view/signup_screen.dart';
import 'package:united_proposals_app/view/splash_screen.dart';
import 'package:united_proposals_app/view/update_profile.dart';
import 'package:united_proposals_app/view/visit_screens/detailed_affiliate_screen.dart';

import '../view/chat_work/view/chat_conversation.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: SplashScreen.route, page: () => const SplashScreen()),
    GetPage(name: LoginScreen.route, page: () => const LoginScreen()),
    GetPage(name: SignupScreen.route, page: () => const SignupScreen()),
    GetPage(name: RootScreen.route, page: () => RootScreen()),
    GetPage(
        name: FeaturedProfileScreen.route,
        page: () => const FeaturedProfileScreen()),
    GetPage(name: ProfileDetailScreen.route, page: () => ProfileDetailScreen()),
    GetPage(
        name: AboutApplicationView.route,
        page: () => const AboutApplicationView()),
    GetPage(name: UpdateProfileScreen.route, page: () => UpdateProfileScreen()),
    GetPage(name: CNICScreen.route, page: () => const CNICScreen()),
    GetPage(
        name: DetailedAffiliateScreen.route,
        page: () => 
       DetailedAffiliateScreen()),
    GetPage(name: ChatBetweenUsers.route, page: () => ChatBetweenUsers()),
    GetPage(name: NotificationView.route, page: () => const NotificationView()),
    GetPage(
        name: FavouriteProfileScreen.route,
        page: () => const FavouriteProfileScreen()),
    GetPage(
        name: AffiliateProgramScreen.route,
        page: () => const AffiliateProgramScreen()),
    GetPage(name: TermOfUseScreen.route, page: () => const TermOfUseScreen()),
    GetPage(
        name: PrivacyPolicyScreen.route,
        page: () => const PrivacyPolicyScreen()),
    GetPage(name: ContactUsScreen.route, page: () => const ContactUsScreen()),
    GetPage(
        name: ProfileVisibilityControls.route,
        page: () => const ProfileVisibilityControls()),
  ];
}
