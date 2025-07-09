import 'package:flutter/material.dart';
import 'package:flutter_tools/common.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/config.dart';
import 'package:riderman/shared/constants.dart';

import '../controllers/main_controller.dart';
import 'main_page.dart';

class CompaniesPage extends StatelessWidget {
  static const String routeName = '/CompanyChooserPage';
  final MainController mainController = Get.find();

  CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    mainController.getCompanies(loadData: true);
    return Scaffold(
      // backgroundColor: kPurpleLightColor,
      appBar: AppBar(
        title: Text('Companies'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            'Select company/account to proceed',
            style: kPurpleTextStyle,
          ),
          Expanded(
            child: Obx(
              () => mainController.loading.value
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: mainController.companies.length,
                      itemBuilder: (ctx, index) {
                        var item = mainController.companies[index];
                        var isIndividual =
                            item.name.contains(currentUser.phoneNumber) ||
                                item.email.contains(currentUser.phoneNumber);
                        return ListTile(
                          leading: RoundedText(
                            text: isIndividual ? 'PA' : item.name.toInitials(),
                            borderColor: kPurpleColor,
                            radius: 42,
                            backgroundColor: Colors.white,
                            textStyle: kPurpleTextStyle.copyWith(
                              // fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Text(
                            isIndividual ? 'Personal Account' : item.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          // i expect the name to be the phone number for individual account
                          subtitle: Text(isIndividual ? item.name : item.email),
                          trailing: item.isActive
                              ? Icon(Icons.check_circle, color: kPurpleColor)
                              : Icon(Icons.block_rounded, color: Colors.grey),
                          onTap: () async {
                            if (item.isActive == false && currentUser.isOwner) {
                              HlkDialog.showErrorSnackBar(
                                'Action can only be performed on active company',
                                title: 'Alert',
                              );
                              return;
                            }
                            // Action
                            await storage.write(
                                AppConstants.COMPANY_DATA, item.toMap());
                            await mainController.getAccountOverviewData(
                              refresh: true,
                            );
                            Get.offAllNamed(MainPage.routeName);
                          },
                        );
                      },
                    ),
            ),
          )
        ],
      ).marginAll(12),
    );
  }
}
