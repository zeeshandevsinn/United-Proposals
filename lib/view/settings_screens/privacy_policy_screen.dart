import 'package:flutter/material.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import '../../utils/height_widths.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static String route = "/PrivacyPolicyScreen";
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.appBar('Privasy Policy'),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.start,
                'This privacy statement explains our practices for gathering, using, and disclosing personal data about you when you use the service. It also informs you of your legal rights and privacy protections. Your personal information is used by us to deliver and enhance the service. You consent to the collection and use of information in line with this privacy policy by using the service. The privacy policy template was utilized in the creation of this policy. \n\n	For the purposes of this privacy statement: ',
                // style: AppTextStyles.poppinsRegular(),
              ),
              h2,
              const Text(
                  textAlign: TextAlign.start,
                  '•	Individual account set up to enable you to use all or some of our services "Application" refers to the United Proposals software that you downloaded from the  Companys website onto any electronic device\n•  In this agreement, "Company" (sometimes referred to as "the Company," "We," "Us," or "Our") means Pakistan.\n•	Any device, including a computer, smartphone, or tablet, that is able to access the Service.\n•  Any individual or organization that handles data processing on behalf of the company is referred to as a service provider. It refers to other businesses or people who work for the firm and are contracted to provide the service, offer it on the companys behalf, or carry out related services or to assist the company in analysing how the services is used.\n•Any website or social network website that allows a user to register or create an account in order to access the service is referred to as a third-party social media service.\n•The term "usage data" describes information that is automatically gathered, either from the service infrastructure itself or as a result of using the service (such as the length of a page visit).\n•The individuals accessing or using the Service, or the Company, or any legal entity on behalf of whom such individuals is accessing or using the service, as applicable.'),
              h3,
              Text(
                textAlign: TextAlign.start,
                'Use of Your Personal Date',
                style: AppTextStyles.poppinsRegular(),
              ),
              h2,
              const Text(
                  textAlign: TextAlign.start,
                  'The following uses of personal data by the company are possible: \n•  To deliver and maintain our service, including keeping an eye on how it is being used. To oversee your account registration as a service user. Your personal information may allow you to access certain features of the service that are available to you as a registered user.\n•  For the fulfilment of a contract: creation, observance, and execution of the purchase agreement for the goods, services, or other things you have acquired, as well as any other agreements you may have with us via the Service.\n• When it is necessary or reasonable for their implementation, to get in touch with you via email, phone calls, SMS, or other comparable electronic communication channels, like push notifications on a mobile application, with updates or informative messages about the features, goods, or services you have contracted for, including security updates.\n• With regard to marriage bureaus, it is the duty of the marriage bureaus to secure clients agreement before disclosing personal information.'),
          
          
          
          
          
                   h3,
              Text(
                textAlign: TextAlign.start,
                'Legal Requirements ',
                style: AppTextStyles.poppinsRegular(),
              ),
              h2,
              const Text(
                  textAlign: TextAlign.start,
                  'Your personal information may be disclosed by the Company if it has a good faith belief that doing so is required to:\n•  Adhere to legal requirements;\n• Safeguard the Companys rights and property;\n• Stop or look into potential wrongdoing related to the Service;\n• Preserve the publics or Service Users personal safety;\n• Protect against legal liability'), 
                  h3,
              Text(
                textAlign: TextAlign.start,
                'Children Privacy',
                style: AppTextStyles.poppinsRegular(),
              ),
              h2,
              const Text(
                  textAlign: TextAlign.start,
                  'Those under the age of eighteen are not served by our service. We donot intentionally gather personally identifying data from those who are younger than eighteen. Please get in touch with us if you are a parent or guardian and you know that your child has given us personal information.\nWe take action to delete personal data from our server if we discover that we have obtained it from anyone under the age of 18 without getting their consent.\nWe may need your parents approval before collecting and using your information if we must depend on consent as a legal basis for processing it and your country demands parental consent.'), 
                
                  h3,
              Text(
                textAlign: TextAlign.start,
                'Contact Us',
                style: AppTextStyles.poppinsRegular(),
              ),
              h2,
              const Text(
                  textAlign: TextAlign.start,
                  'If you have any questions about this Privacy Policy, you can contact us:'),
              Row(children: [
                Text(
                  textAlign: TextAlign.start,
                  '•	By email:'),
                  TextButton(onPressed: (){
          
                  }, child: Text(
                    style: TextStyle(color: AppColors.blue),
                  textAlign: TextAlign.start,
                  'info@unitedproposals.com'),)
              ],),
               Row(children: [
                Text(
                  textAlign: TextAlign.start,
                  '•	By visiting the page on our website:'),
                  TextButton(onPressed: (){
          
                  }, child: Text(
                    style: TextStyle(color: AppColors.blue),
                  textAlign: TextAlign.start,
                  'www.unitedproposals.com'),),h2
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
