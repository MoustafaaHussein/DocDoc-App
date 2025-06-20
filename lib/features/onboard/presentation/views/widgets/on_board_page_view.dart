import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/features/onboard/presentation/views/widgets/on_board_page_view_items.dart';
import 'package:flutter/material.dart';

class OnBoardPageView extends StatelessWidget {
  const OnBoardPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      controller: pageController,
      children: const [
        OnBoardPageViewItems(
          image: Images.imagesImagesOnboardImage1,
          title: 'حتى أكثر الأيام ثِقلًا تستحق مكانًا يُشعرك بالسكينة.',
          description:
              'لقد وصلت إلى مساحة مصممة لاحتواء مشاعرك وتخفيف توترك بلُطف، دون أي ضغط.',
        ),
        OnBoardPageViewItems(
          image: Images.imagesImagesOnboardImage2,
          title: 'تنفّس بعمق... تمهّل... نحن هنا لنقودك نحو الهدوء.',
          description:
              'يُقدّم لك هذا التطبيق لحظات تأمّل، عادات مريحة، واستراحات ذهنية تساعدك على استعادة توازنك',
        ),
        OnBoardPageViewItems(
          image: Images.imagesImagesOnboardImage3,
          title: 'من الفوضى إلى الوضوح... ومن التوتر إلى السلام... خطوة بخطوة.',
          description: 'رحلتك نحو شعور أفضل تبدأ من هنا، فقط بخطوة بسيطة',
        ),
      ],
    );
  }
}
