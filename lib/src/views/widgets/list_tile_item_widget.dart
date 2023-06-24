import 'package:flutter/material.dart';

class ListTileItemWidget extends StatelessWidget {
  final IconData iconName;
  final String kKey;
  final String kName;
  const ListTileItemWidget(this.iconName, this.kKey, this.kName, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 10.0,
      horizontalTitleGap: 5,
      // leading: Icon(iconName, color: Theme.of(context).primaryColor),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(kKey),
          ),
          Flexible(
            child: Text(
              kName, //put your own long text here.
              textAlign: TextAlign.end,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
