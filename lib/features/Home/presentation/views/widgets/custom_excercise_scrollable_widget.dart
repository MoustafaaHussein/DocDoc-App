import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/customTypes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class CustomExcersicesScrollableWidget extends StatelessWidget {
  const CustomExcersicesScrollableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).push(AppRouter.kRecomendation);
        },
        child: Row(
          children: [
            CustomJournalTile(
              title: 'exercise'.tr(),
              icon: IconlyLight.activity,
            ),
            CustomJournalTile(
              title: 'meditation'.tr(),
              icon: Icons.self_improvement,
            ),
            CustomJournalTile(
              title: 'mental'.tr(),
              icon: Ionicons.bonfire_outline,
            ),
            CustomJournalTile(
              title: 'self_care'.tr(),
              icon: Ionicons.moon_outline,
            ),
          ],
        ),
      ),
    );
  }
}
