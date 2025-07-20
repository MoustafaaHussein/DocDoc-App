import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuoteCard extends StatelessWidget {
  final String quote;

  const QuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 324.w,
      height: 79.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 21.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F6F6),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFF4F4F4),
          width: 1.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              quote,
              style: TextStyle(
                color: const Color(0xFF6F6F6F),
                fontSize: 14.sp,
                fontFamily: 'Epilogue',
                fontWeight: FontWeight.w400,
                height: 1.43,
                letterSpacing: -0.14.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Transform.rotate(
            angle: 3.14, // 180 درجة
            child: Icon(
              Icons.format_quote,
              size: 20.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
