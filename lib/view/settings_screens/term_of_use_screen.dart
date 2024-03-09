import 'package:flutter/material.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import '../../utils/height_widths.dart';
import '../../utils/text_style.dart';

class TermOfUseScreen extends StatelessWidget {
  static String route = "/TermOfUseScreen";
  const TermOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.appBar('Terms of use'),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
        child: SingleChildScrollView(child: 
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.start,
              'Agreement of Term of Use',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'You accept these Terms of Use by creating an account through a computer, mobile device, or mobile application (together, the "Service"). Please do not use the Service if you do not accept and agree to be bound by all of the terms of this Agreement.'),
           
            h3,
            Text(
              textAlign: TextAlign.start,
              'Eligibility',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'If any of the following conditions are not met, you are not permitted to register for an account, access, or use the Service or the systems it is hosted on:\n• You have never been convicted of a crime or an indictable offense;\n• You are at least eighteen years old;\n• You agree to abide by this Agreement and all applicable local, state, federal, and International laws, rules, and regulations'),
                 h3,
            Text(
              textAlign: TextAlign.start,
              'Your Account',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'You are solely accountable for any actions taken using the login credentials you used to register for the United Proposals App, and you are also responsible for keeping them confidential. Kindly get in touch with us right away if you believe someone has gotten access to your account.'),
                 h3,
            Text(
              textAlign: TextAlign.start,
              'Modifying the Services and Termination',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'We have the right to completely suspend the Service, in which case we will provide you advance notice unless there are exceptional circumstances—like safety or security issues—that prohibit us from doing so. You can use the "Settings" section of the service to follow the instructions to cancel your account at any time and for any reason. If United Proposals thinks you have broken this agreement, it may cancel your account at any time and without prior warning.'),
                 h3,
            Text(
              textAlign: TextAlign.start,
              'Safety: Your Interaction with Other Members',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'Even if United Proposals tries to promote a polite member experience, it cannot be held accountable for any members behaviour, especially if you choose to meet in person or speak outside of the service.\nYou alone are in charge of how you communicate with other members. You are aware that United Proposals doesnot investigate members criminal histories or perform any other kind of background investigation. There are no guarantees or promises made by United Proposals regarding member behaviour.'),
                 h3,
            Text(
              textAlign: TextAlign.start,
              'Rights United Proposals Grant You',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'This license is only intended to enable you to use and benefit from the Services as specified by United Proposals and allowed by this agreement. If you do any of the following, this license and any permission to use the service are immediately terminated. \n•	Without our express written approval, use the service or any of its contents for any Commercial endeavours.\n•	Without United Proposals prior written consent, you may not:\n•	Copy, alter, transmit, create any derivative works from, use, or reproduce in any wayany copyrighted material, images, trademarks, trade names, service marks, or other Intellectual property, content, or proprietary information accessible through the Service.\n•	State or indicate that any assertions you make are supported by United Proposals. Falsify headers or alter identifiers in any other way to conceal the source of any data sent to or via the service. \n•	Any portion of the Service may not be framed or mirrored without prior written consent from United Proposal.\n•	Without our express written authorization, use or create any third-party apps that interface with the service, other members content, or information. \n•	Without our express written consent, use, access, or publish the United Proposals application programming interface.\n•	Examine, scan, or test any system or network for vulnerabilities, including our service.\n•	Support or encourage any behaviour that is against the terms of this agreement.  United Proposals may investigate and take any available legal action in response to illegal or unauthorized uses of the services, including termination of your account. \nAny software we give you has the potential to download and install updates, upgrades, and other new features automatically. It is possible that you can modify these automatic downloads via your devices settings.'),
                 h3,
            Text(
              textAlign: TextAlign.start,
              'Other Members Content ',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'The member who publishes such Content is solely responsible for its compliance, and United Proposals cannot guarantee that all Content will comply with this Agreement, even while it reserves the right to evaluate and remove such Content. Please use the services internal reporting system or contact form to report any content that you find violates this agreement.'),


                 h3,
            Text(
              textAlign: TextAlign.start,
              'Third Party Services',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'Links to external websites or resources, as well as advertisements and promotions provided by third parties, may be present in the service. The availability (or unavailability) of these external websites or resources is not United Proposals fault. The terms of any third parties you choose to interact with through our services will control your relationship with them. Such third parties conditions and activities are not under the control or liability of United Proposals. '),
                 h3,
            Text(
              textAlign: TextAlign.start,
              'Governing Law ',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'This agreement shall be governed by Pakistani law, and the only courts with the authority to decide a dispute are those in Lahore. '),
                 h3,
            Text(
              textAlign: TextAlign.start,
              'Indemnity By You',
              style: AppTextStyles.poppinsRegular(),
            ),
            h2,
            const Text(
                textAlign: TextAlign.start,
                'You consent to indemnify, defend, and hold harmless United Proposals, our affiliates, and each of our officers, directors, agents, and employees from and against any and all complaints, demands, claims, damages, losses, costs, liabilities, and expenses, including attorneys fees, resulting from, arising out of, or connected in any way to your access to or use of the Service, your Content, or your violation of this Agreement, to the extent permitted by applicable law.'),h2
          ],
        ),),
      ),
    );
  }
}
