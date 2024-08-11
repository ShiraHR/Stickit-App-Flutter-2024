import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';


class GenericDropdown extends StatefulWidget {
  final String hint; 
  final List<String> options;
  final String? selectedOption; 
  final ValueChanged<String?> onChanged; 

  GenericDropdown({
    required this.hint,
    required this.options,
    this.selectedOption,
    required this.onChanged,
  });

  @override
  _GenericDropdownState createState() => _GenericDropdownState();
}

class _GenericDropdownState extends State<GenericDropdown> {
  late DropListModel dropListModel;
  OptionItem? optionItemSelected;

  @override
  void initState() {
    super.initState();
  
    dropListModel = DropListModel(
      widget.options.asMap().entries.map((entry) {
        return OptionItem(
          id: (entry.key + 1).toString(),
          title: entry.value,
          data: '', 
        );
      }).toList(),
    );

 }
  @override
  Widget build(BuildContext context) {
    return SelectDropList(
      heightBottomContainer: 120,
      itemSelected: OptionItem(title: widget.hint),
      dropListModel: dropListModel,
      showIcon: false,
      showArrowIcon: true,
      showBorder: true,
      enable: true,
      paddingTop: 0,
      paddingDropItem: const EdgeInsets.only(
          left: 20, top: 10, bottom: 10, right: 20),
      suffixIcon: Icons.arrow_drop_down,
      containerPadding: const EdgeInsets.all(10),
      icon: const Icon(Icons.person, color: Colors.black),
      onOptionSelected: (optionItem) {
        setState(() {
          optionItemSelected = optionItem;
        });
        widget.onChanged(optionItem.title); 
      },
    );
  }
}
