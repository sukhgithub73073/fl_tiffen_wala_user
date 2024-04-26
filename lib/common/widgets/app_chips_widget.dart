import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';


class AppChipsWidget extends StatefulWidget {
  final List<String> list;
  var onChange ;

  AppChipsWidget({Key? key, required this.list ,required this.onChange}) : super(key: key);

  @override
  State<AppChipsWidget> createState() => _AppChipsWidgetState();
}

class _AppChipsWidgetState extends State<AppChipsWidget> {
  TextTheme? textTheme;
  int propertyindex = 0;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return SizedBox(
        height: 34,
        child: ListView.builder(
            itemCount: widget.list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (c, i) {
              return AppChipsWidget(label: widget.list[i], index: i);
            }));
  }

  Widget AppChipsWidget({
    required String label,
    required int index,
  }) =>
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.onChange(index) ;
              propertyindex = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    propertyindex == index ? primaryColorVariant : midLightGrey,
              ),
              color: propertyindex == index
                  ? primaryColorVariant.withOpacity(0.05)
                  : null,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: textTheme?.labelSmall,
            ),
          ),
        ),
      );
}
