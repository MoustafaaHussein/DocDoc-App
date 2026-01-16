import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String imageUrl;

  const CustomHeader({
    super.key,
    required this.userName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat.yMMMMd('en_US').format(now);
    bool isPro = false;

    return BlocListener<SubscriptionCubit, SubscriptionState>(
      listener: (context, state) {
        if (state is SubscriptionActive) {
          isPro = true;
        }
      },
      child: Container(
        width: double.infinity,
        height: preferredSize.height,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 46, 46, 61),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Row(
              children: [
                Icon(IconlyLight.calendar, size: 15.sp, color: Colors.grey),
                SizedBox(width: 6.w),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: AssetImage(imageUrl),
                ),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hi,",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),

                    isPro == true
                        ? Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF2F4EA),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1234),
                                ),
                              ),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    spacing: 4,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 25,
                                        child: Icon(
                                          IconlyLight.star,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      Text(
                                        'Pro Member',
                                        style: TextStyle(
                                          color: Color(0xFF9BB068),
                                          fontSize: 12,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SizedBox(height: 8.h)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(200.h);
}
