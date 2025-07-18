import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/view_more_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecomendantionCard extends StatelessWidget {
  const RecomendantionCard({
    super.key,
    required this.titile,
    required this.diffucltyLevel,
    required this.discreption,
    required this.timeRemaining,
    required this.instructions,
    required this.ratting,
  });
  final String titile,
      diffucltyLevel,
      discreption,
      timeRemaining,
      instructions,
      ratting;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: AppContainersStyle.recomendadtionCardStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  titile,
                  style: AppStyles.styleMedium18(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
              Spacer(),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  diffucltyLevel,
                  style: AppStyles.styleMedium13(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  softWrap: true,
                  maxLines: 2,
                  discreption,
                  style: AppStyles.styleMedium16(
                    context,
                  ).copyWith(color: Colors.grey),
                ),
              ),
              Spacer(),
              SvgPicture.asset(
                Images.imagesImagesTime,
                fit: BoxFit.scaleDown,
                height: 20,
                width: 20,
              ),
              SizedBox(width: 2),
              Text(
                "$timeRemaining min",
                style: AppStyles.styleMedium13(
                  context,
                ).copyWith(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber),
              SizedBox(width: 10),
              Text(ratting, style: AppStyles.styleMedium13(context)),
            ],
          ),
          SizedBox(height: 20),
          Center(child: ViewMoreButton(onPressed: () {})),
          Text('Instruction'),
          SizedBox(height: 20),
          Text(instructions),
        ],
      ),
    );
  }
}
