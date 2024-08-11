import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StepsInput extends StatefulWidget {
  final ValueChanged<int>? onStartNumberChanged;
  final ValueChanged<int>? onEndNumberChanged;

  StepsInput({
    required this.onStartNumberChanged,
    required this.onEndNumberChanged,
  });

  @override
  _StepsInputState createState() => _StepsInputState();
}

class _StepsInputState extends State<StepsInput> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: NumberInputField(
                  controller: _startController,
                  hintText: 'Enter start Value',
                  onChanged: (text) {
                    final intValue = int.tryParse(text) ?? 0;
                    if (widget.onStartNumberChanged != null) {
                      widget.onStartNumberChanged!(intValue);
                    }
                  },
                ),
              ),
              SizedBox(width: 35),
              Expanded(
                child: NumberInputField(
                  controller: _endController,
                  hintText: 'Enter end Value',
                  onChanged: (text) {
                    final intValue = int.tryParse(text) ?? 0;
                    if (widget.onEndNumberChanged != null) {
                      widget.onEndNumberChanged!(intValue);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NumberInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;

  NumberInputField(
      {required this.controller, required this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onChanged: onChanged,
    );
  }
}
