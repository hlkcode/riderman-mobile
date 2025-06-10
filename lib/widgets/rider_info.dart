import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';

import '../models/core_models.dart';
import '../shared/constants.dart';
import 'labeled_widgets.dart';

class RiderInfo extends StatelessWidget {
  final Rider? rider;
  const RiderInfo({super.key, this.rider});

  @override
  Widget build(BuildContext context) {
    return rider != null
        ? Container(
            color: kPurpleLightColor.withOpacity(.2),
            child: SingleChildScrollView(
              child: Column(
                spacing: getHeight(0.02),
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(0.02),
                  ProfileDetail(
                    name: rider!.fullName,
                    phoneNumber: rider!.phoneNumber,
                    photoUrl: rider!.photoUrl,
                    title: 'Rider\'s Details',
                  ),
                  verticalSpace(0.02),
                  ...rider!.guarantors.mapIndexed(
                    (index, item) => ProfileDetail(
                      name: item.fullName,
                      phoneNumber: item.phoneNumber,
                      photoUrl: item.photoUrl,
                      title: 'Guarantor #${index + 1}',
                    ),
                  ),
                  verticalSpace(0.02),
                ],
              ),
            ),
          )
        : NoItemLoader(message: 'Sorry no Rider info found');
  }
}

class ProfileDetail extends StatelessWidget {
  final String title;
  final String name;
  final String phoneNumber;
  final String? photoUrl;

  const ProfileDetail({
    super.key,
    required this.title,
    required this.name,
    required this.phoneNumber,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: getHeight(0.02),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: kPurpleTextStyle),
        CachedNetworkImage(
          fit: BoxFit.fill,
          width: getDisplayWidth(),
          height: 200,
          filterQuality: FilterQuality.high,
          imageUrl: getString(photoUrl),
          // progressIndicatorBuilder: (context, url, progress) => Center(
          //   child: CircularProgressIndicator(),
          // ),
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: kErrorColor,
          ),
        ),

        LabeledTextField(
          title: 'Name',
          inputType: TextInputType.text,
          readOnly: true,
        ),
        // verticalSpace(0.02),
        LabeledTextField(
          readOnly: true,
          title: 'Phone number',
          inputType: TextInputType.numberWithOptions(decimal: true),
        ),
        // verticalSpace(0.02),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
