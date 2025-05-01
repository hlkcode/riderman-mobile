import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/common.dart';
import 'package:riderman/shared/constants.dart';

import '../controllers/main_controller.dart';

class CompanyChooserPage extends StatelessWidget {
  static const String routeName = '/CompanyChooserPage';
  final MainController mainController = Get.find();

  CompanyChooserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPurpleLightColor,
      appBar: AppBar(
        title: Text('Companies'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: mainController.companies.length,
        itemBuilder: (ctx, index) {
          var item = mainController.companies[index];
          return ListTile(
            leading: RoundedText(
              text: item.name.toInitials(),
              borderColor: kPurpleColor,
              radius: 42,
              backgroundColor: Colors.white,
              textStyle: kPurpleTextStyle.copyWith(
                // fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(item.email),
            trailing: item.isActive
                ? Icon(Icons.check_circle, color: kPurpleColor)
                : Icon(Icons.block_rounded, color: Colors.grey),
            onTap: item.isActive
                ? () async {
                    // Action
                    await storage.write(Constants.COMPANY_DATA, item.toMap());
                  }
                : null,
          );
        },
      ).marginAll(12),
    );
  }
}
