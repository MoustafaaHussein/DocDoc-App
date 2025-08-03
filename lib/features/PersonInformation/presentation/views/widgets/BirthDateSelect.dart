import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BirthDateTile extends StatefulWidget {
  final DateTime? initialDate;
  final void Function(DateTime) onDateSelected;

  const BirthDateTile({
    super.key,
    this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<BirthDateTile> createState() => _BirthDateTileState();
}

class _BirthDateTileState extends State<BirthDateTile> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayText =
        selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
            : 'Select your birth date';

    return GestureDetector(
      onTap: _pickDate,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Birth Date',
              style: TextStyle(
                color: Color(0xFFA2A2A7),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                const Icon(IconlyLight.calendar, size: 20, color: Colors.white),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    displayText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
