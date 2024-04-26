import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';

class MultiSelectChipsWidget extends StatefulWidget {
  final List<String> list;
  final Function(Set<int>) onChange;

  MultiSelectChipsWidget({Key? key, required this.list, required this.onChange})
      : super(key: key);

  @override
  State<MultiSelectChipsWidget> createState() => _MultiSelectChipsWidgetState();
}

class _MultiSelectChipsWidgetState extends State<MultiSelectChipsWidget> {
  TextTheme? textTheme;
  Set<int> selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 34,
      child: ListView.builder(
        itemCount: widget.list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (c, i) {
          return MultiSelectChip(
            label: widget.list[i],
            index: i,
            isSelected: selectedIndices.contains(i),
            onTap: () {
              setState(() {
                if (selectedIndices.contains(i)) {
                  selectedIndices.remove(i);
                } else {
                  selectedIndices.add(i);
                }
                widget.onChange(selectedIndices);
              });
            },
          );
        },
      ),
    );
  }
}

class MultiSelectChip extends StatelessWidget {
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const MultiSelectChip({
    Key? key,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primaryColorVariant : midLightGrey,
            ),
            color: isSelected ? primaryColorVariant.withOpacity(0.05) : null,
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
}
