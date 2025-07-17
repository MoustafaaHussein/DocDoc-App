import 'package:flutter/material.dart';

class ExpiryDatePicker extends StatefulWidget {
  final void Function(String month, String year) onChanged;
  const ExpiryDatePicker({super.key, required this.onChanged});

  @override
  State<ExpiryDatePicker> createState() => _ExpiryDatePickerState();
}

class _ExpiryDatePickerState extends State<ExpiryDatePicker> {
  String? selectedMonth;
  String? selectedYear;

  final months = List.generate(12, (i) => (i + 1).toString().padLeft(2, '0'));
  final years = List.generate(15, (i) => (DateTime.now().year + i).toString());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedMonth,
            hint: const Text('Month'),
            decoration: _boxDecoration(),
            items:
                months
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
            onChanged: (val) {
              setState(() => selectedMonth = val);
              _notifyChange();
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedYear,
            hint: const Text('Year'),
            decoration: _boxDecoration(),
            items:
                years
                    .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                    .toList(),
            onChanged: (val) {
              setState(() => selectedYear = val);
              _notifyChange();
            },
          ),
        ),
      ],
    );
  }

  InputDecoration _boxDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  void _notifyChange() {
    if (selectedMonth != null && selectedYear != null) {
      widget.onChanged(selectedMonth!, selectedYear!);
    }
  }
}
