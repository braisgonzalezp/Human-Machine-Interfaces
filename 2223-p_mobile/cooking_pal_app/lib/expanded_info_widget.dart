
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_data_widget.dart';
import 'models.dart';


class ExpandedInfoWidget extends StatelessWidget {
  final info;
  final String title;
  final int expandedPanel;
  const ExpandedInfoWidget(
      {super.key,
        required this.info,
        required this.title,
        required this.expandedPanel});

  @override
  Widget build(BuildContext context) {
    if (info.length == 0) {
      return Container(
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: ListTile(
            title: Text(
              'No $title for this recipe',
            ),
          ));
    } else {
      return SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            context.read<InfoModel>().setExpanded(!isExpanded, expandedPanel);
          },
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(title),
                );
              },
              body: ListTile(
                title: ListData(
                  info: info,
                  length: info.length,
                ),
              ),
              isExpanded: context.watch<InfoModel>().expanded[expandedPanel],
            )
          ],
        ),
      );
    }
  }
}