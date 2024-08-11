import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/material.dart';

class BooleanDropdown extends StatefulWidget {
  final String hint; 
  final bool? value; // לבדוק אם צריך
  final ValueChanged<bool?> onChanged; 


  const BooleanDropdown({super.key, 
    required this.hint,
    this.value,
    required this.onChanged,
  });

  @override
  _BooleanDropdownState createState() => _BooleanDropdownState();
}

class _BooleanDropdownState extends State<BooleanDropdown> {
  late DropListModel dropListModel; 
  late OptionItem optionItemSelected; 

  @override
  void initState() {
    super.initState();

    dropListModel = DropListModel([
      OptionItem( title: 'Yes', data: "true"),
      OptionItem( title: 'No', data: "false"),
    ]);


    optionItemSelected = widget.value == true
        ? dropListModel.listOptionItems[0]
        : widget.value == false
            ? dropListModel.listOptionItems[1]
            : OptionItem(id: '', title: widget.hint, data: null);
  }

  @override
  Widget build(BuildContext context) {
    return SelectDropList(
      heightBottomContainer: 100,
      itemSelected: optionItemSelected, 
      dropListModel: dropListModel, 
      showIcon: true, 
      showArrowIcon: true, 
      onOptionSelected: (optionItem) {
        setState(() {
          optionItemSelected = optionItem; 
        });
        widget.onChanged(optionItem.data as bool?); 
      },
    );
  }
}
