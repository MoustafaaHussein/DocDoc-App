// import 'package:docdoc_app/features/payment/presentation/views/widgets/pro_membership_widget.dart';
// import 'package:flutter/material.dart';

// class PageViewSlideDemo extends StatefulWidget {
//   @override
//   _PageViewSlideDemoState createState() => _PageViewSlideDemoState();
// }

// class _PageViewSlideDemoState extends State<PageViewSlideDemo> {
//   bool showPageView = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("PageView Slide Animation")),
//       body: Stack(
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   showPageView = !showPageView;
//                 });
//               },
//               child: const Text("Toggle PageView"),
//             ),
//           ),
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 400),
//             curve: Curves.easeInOut,
//             bottom: showPageView ? 0 : -400, // slide in/out
//             left: 0,
//             right: 0,
//             height: 300,
//             child: const Material(
//               elevation: 8,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//               child: const ProMembershipWidget(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
