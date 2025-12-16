// import 'package:docdoc_app/core/routes/app_routes.dart';
// import 'package:docdoc_app/core/widgets/successfull_dialog.dart';
// import 'package:docdoc_app/features/payment/presentation/manger/bloc/payment_bloc.dart';
// import 'package:docdoc_app/features/payment/presentation/views/widgets/add_payment_method_view_body.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class AddPaymentBlocConsumer extends StatelessWidget {
//   const AddPaymentBlocConsumer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<PaymentBloc, PaymentState>(
//       listener: (context, state) {
//         if (state is AddPaymentMethodSuccess) {
//           showDialog(
//             context: context,
//             builder:
//                 (context) => SuccessDialogWidget(
//                   onSubmit:
//                       () =>
//                           GoRouter.of(context).push(AppRouter.kPaymentMethods),
//                   titileText: 'payment_added'.tr(),
//                   subTittle: '',
//                 ),
//           );
//         }
//       },
//       builder: (context, state) {
//         return const AddPaymentMethodViewBody();
//       },
//     );
//   }
// }
