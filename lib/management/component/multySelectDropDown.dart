import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';

class GenericMultiSelectDropdown extends StatefulWidget {
  final String hint;
  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onChanged;

  const GenericMultiSelectDropdown({
    super.key,
    required this.hint,
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
  });

  @override
  _GenericMultiSelectDropdownState createState() =>
      _GenericMultiSelectDropdownState();
}

class _GenericMultiSelectDropdownState
    extends State<GenericMultiSelectDropdown> {
  late DropListModel dropListModel; // Model to hold options
  late List<OptionItem> _selectedOptions; // Selected options

  @override
  void initState() {
    super.initState();

    dropListModel = DropListModel(
      widget.options.asMap().entries.map((entry) {
        return OptionItem(
          id: (entry.key + 1).toString(),
          title: entry.value,
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectDropMultipleList(
      defaultText: OptionItem(title: widget.hint),
      dropListModel: dropListModel,
      showIcon: false,
      showBorder: true,
      enable: true,
      paddingTop: 0,
      submitText: "OK",
      onTapCross: (data) {
        if (data) {
          print("List Cleared");
        }
      },
      colorSubmitButton: Colors.green,
      selectedIconWidget: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.green,
        ),
        child: const Icon(
          Icons.done,
          size: 15,
          color: Colors.white,
        ),
      ),
      suffixIcon: Icons.arrow_drop_down,
      containerPadding: const EdgeInsets.all(10),
      icon: const Icon(Icons.person, color: Colors.black),
      onOptionListSelected: (list) {
        _selectedOptions = list;
        widget.onChanged(_selectedOptions.map((item) => item.title).toList());
        // setState(() {});
      },
    );
  }
}
