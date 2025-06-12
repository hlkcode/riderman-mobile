import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/constants.dart';

import 'labeled_widgets.dart';

class RowPair extends StatelessWidget {
  final String title;
  final String value;
  const RowPair({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}

class SelectableCard extends StatelessWidget {
  final bool showSelection;
  final bool isSelected;
  final Function(bool?)? onSelectionChanged;
  final Function()? onSelected;
  final String cardTitle;
  final String actionText;
  final Map<String, String> rows;
  const SelectableCard({
    super.key,
    required this.showSelection,
    this.onSelectionChanged,
    required this.isSelected,
    required this.cardTitle,
    required this.rows,
    required this.actionText,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    var mainContent = Card(
      elevation: 0.0,
      color: Colors.white54,
      child: Column(
        // spacing: getHeight(0.01),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardTitle,
            style: kBlackTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          ...rows.entries
              .map((entry) => RowPair(title: entry.key, value: entry.value)),
          verticalSpace(0.01),
          LoadingButton(
            btnMargin: EdgeInsets.zero,
            // buttonHeight: getHeight(0.04),
            buttonHeight: 36,
            text: actionText,
            isOutlined: true,
            isLoading: false,
            buttonColor: kPurpleColor,
            style: kPurpleTextStyle,
            buttonRadius: 12,
            onTapped: onSelected,
          ),
        ],
      ).paddingAll(12),
    );
    return showSelection
        ? Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: onSelectionChanged,
              ),
              Expanded(child: mainContent),
            ],
          )
        : mainContent;
  }
}

class SelectableListPage extends StatelessWidget {
  final String cardFor;
  final String cardActionText;
  final String submitText;
  final List<Map<String, String>> rowsList;
  final RxList dataList;
  final Function()? onSubmit;

  SelectableListPage({
    super.key,
    required this.cardFor,
    required this.cardActionText,
    required this.rowsList,
    required this.dataList,
    required this.submitText,
    this.onSubmit,
  });

  final RxList<int> _selectedIndexes = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    var list = ListView.separated(
      itemCount: dataList.length,
      itemBuilder: (ctx, index) {
        return Obx(() => SelectableCard(
              actionText: cardActionText,
              showSelection: _selectedIndexes.isNotEmpty,
              isSelected: _selectedIndexes.contains(index),
              cardTitle: '$cardFor #${index + 1}',
              rows: rowsList[index],
              onSelected: () {
                if (!_selectedIndexes.contains(index)) {
                  _selectedIndexes.add(index);
                }
              },
              onSelectionChanged: (selected) {
                _selectedIndexes.addOrRemove(index);
              },
            ));
      },
      separatorBuilder: (BuildContext context, int index) =>
          verticalSpace(0.008),
    );
    return Container(
      color: kPurpleLightColor.withOpacity(.2),
      child: Obx(
        () => _selectedIndexes.isEmpty
            ? list
            : Column(
                // spacing: getHeight(0.008),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // verticalSpace(0.002),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => _selectedIndexes.clear(),
                        icon: Icon(Icons.cancel_outlined, size: 32),
                      ),
                      Text(
                        '${_selectedIndexes.length} Selected',
                        style: kPurpleTextStyle,
                        // style: kBlackTextStyle,
                      ),
                      SizedBox(
                        width: 110,
                        child: LoadingButton(
                          // btnMargin: EdgeInsets.zero,
                          // buttonHeight: getHeight(0.04),
                          buttonHeight: 36,
                          text: submitText,
                          // isOutlined: true,
                          style: kWhiteTextStyle,
                          isLoading: false,
                          buttonColor: kPurpleColor,
                          buttonRadius: 12,
                          onTapped: onSubmit,
                        ),
                      ),
                    ],
                  ),
                  LabeledWidget(
                    title: 'Select All',
                    isVertical: false,
                    widget: Checkbox(
                      value: _selectedIndexes.length == dataList.length,
                      onChanged: (sel) {
                        var limit = dataList.length;
                        _selectedIndexes.value =
                            List<int>.generate(limit, (i) => i);
                      },
                    ),
                  ),
                  Expanded(child: list)
                ],
              ),
      ).marginAll(10),
    );
  }
}
