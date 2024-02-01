// import 'package:flutter/material.dart';

// class BuildModelBottomSheet extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade200,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20.r),
//                                   topRight: Radius.circular(20.r),
//                                 ),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 16.w, vertical: 8.h),
//                               height: 300.h,
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             top: 8.h, bottom: 16.h),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(8.r),
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary
//                                                 .withOpacity(0.5),
//                                           ),
//                                           height: 5.h,
//                                           width: 32.w,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Expanded(
//                                     child: ListView.separated(
//                                       itemCount:
//                                           cubit.addressesModel!.data.length + 1,
//                                       itemBuilder: ((context, index) {
//                                         if (index ==
//                                             cubit.addressesModel!.data.length) {
//                                           return Padding(
//                                             padding: EdgeInsets.only(top: 16.h),
//                                             child: BuildDefaultButton(
//                                                 onTap: () {
//                                                   HelperFunctions.pushScreen(
//                                                       context,
//                                                       const AddNewAddressScreen());
//                                                 },
//                                                 text: 'Add New Address',
//                                                 elevation: 1,
//                                                 context: context),
//                                           );
//                                         }
//                                         return BuildAddressesItem(
//                                           onTap: () {
//                                             cubit.changeAddressId(cubit
//                                                 .addressesModel!
//                                                 .data[index]
//                                                 .id);
//                                             Navigator.pop(context);
//                                           },
//                                           address:
//                                               cubit.addressesModel!.data[index],
//                                         );
//                                       }),
//                                       separatorBuilder: (_, __) =>
//                                           SizedBox(height: 8.h),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//   }
// }