import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/helpers/toast_message_helper.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_two_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/customer/customer_booking_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../helpers/quick_alert.dart';
import '../../services/vibration_service.dart';

class BookingCardCustomer extends StatelessWidget {
  BookingCardCustomer(
      {super.key,
      this.rating,
      this.buttonLabel,
      this.onTapDetails,
      required this.name,
      this.title,
      this.money,
      required this.image,
      this.isNextPay = false,
      this.isHistory = false,
      this.btnVisible = true,
      this.status,
      this.historyButtonAction,
      this.buttonColor,
      this.onTap,
      this.nextPayCardBtnOnTap,
      this.certificates,
      this.acceptCancelBtnName,
      this.isNextPaySection=false,
      this.id,
      this.isBtnNeed = false,
      this.address = ''});

  final int? rating;
  final String? buttonLabel;
  final VoidCallback? onTapDetails;
  final VoidCallback? onTap;
  final VoidCallback? nextPayCardBtnOnTap;
  final String name;
  final String? title;
  final String image;
  final String? money;
  final bool isNextPay;
  final bool isHistory;
  final bool btnVisible;
  final bool isNextPaySection;
  final bool isBtnNeed;
  final String? status;
  final String? address;
  final String? id;
  final List? certificates;
  final List? acceptCancelBtnName;
  final VoidCallback? historyButtonAction;
  final Color? buttonColor;




  Color getStatusColor(String? status) {
    switch (status) {
      case 'requested':
      case 'rejected':
      case 'request-canceled':
      case 'denied':
      case 'service-rejected':
      case 'canceled':
        return AppColors.cancelButtonColor;
      case 'accepted':
      case 'confirmed':
      case 'serviced':
      case 'paid':
      // case 'completed':
      case 'process':
        return AppColors.primaryColor;
      case 'active':
        return AppColors.activeColor;
      case 'complete':
      case 'completed':
      return Colors.green;
      default:
        return AppColors.primaryShade300;
    }
  }

  CustomerBookingController bookingController =
      Get.find<CustomerBookingController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, left: 18.w, right: 18.w),
      child: GestureDetector(
        onTap: onTap,
        child: CustomContainer(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 13,
            ),
          ],
          radiusAll: 14.r,
          paddingAll: 20.r,
          color: AppColors.bgColorWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isHistory) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: historyButtonAction,
                      child: CustomText(
                        text: status ?? '',
                        fontsize: 11.sp,
                        color: getStatusColor(status),
                      )

                      // CustomText(
                      //   text: status ?? '',
                      //   fontsize: 10.sp,
                      //   color: status == 'Cancel'
                      //       ? AppColors.cancelButtonColor
                      //       : AppColors.primaryColor,
                      // ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
              GestureDetector(
                onTap: onTapDetails,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImageAvatar(
                      radius: 32.r,
                      image: image,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: name,
                            fontsize: 20.sp,
                            maxline: 1,
                          ),
                          SizedBox(height: 4.h),
                          if (title != null)
                            CustomText(
                                text: title!,
                                fontsize: 14.sp,
                                color: Colors.black),
                          SizedBox(height: 4.h),
                          if (rating != null)
                            Row(
                              children: [
                                ...List.generate(5, (index) {
                                  return Icon(
                                    index < rating!
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 14.r,
                                    color: Colors.amber,
                                  );
                                }),
                                SizedBox(width: 4.w),
                                CustomText(
                                  text: '($rating.0)',
                                  fontsize: 10.sp,
                                ),
                              ],
                            ),
                          if (money != null) ...[
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                Assets.icons.meneyIcon
                                    .svg(width: 14.w, height: 14.h),
                                SizedBox(width: 4.w),
                                CustomText(
                                  text: money!,
                                  fontsize: 12.sp,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                          SizedBox(height: 8.h),
                          address == ""
                              ? Wrap(
                                  spacing: 10.w,
                                  runSpacing: 6.h,
                                  children: List.generate(certificates!.length,
                                      (index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7.w,
                                        vertical: 3.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFE6E6),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: CustomText(
                                        text: certificates![index].toString(),
                                        fontsize: 10.sp,
                                      ),
                                    );
                                  }),
                                )
                              : Row(
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                        size: 16.r),
                                    Expanded(
                                        child: CustomText(
                                            text: "$address",
                                            textAlign: TextAlign.start)),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isHistory) ...[
                SizedBox(height: 16.h),
                isBtnNeed
                    ? const SizedBox.shrink()
                    : isNextPay
                        ? CustomButton(
                            title: "${buttonLabel}",
                            onpress: nextPayCardBtnOnTap ?? () {},
                            height: 39.h,
                            borderRadius: 10)
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: CustomTwoButon(
                              btnVisible: btnVisible,
                              width: 130.w,
                              btnNameList: acceptCancelBtnName,
                              leftBtnOnTap: btnVisible
                                  ? () async {

                                if(isNextPaySection){
                                  onTap?.call();
                                }else{
                                  onTap?.call();
                                  // var response = await bookingController.customerInitBooking(
                                  //     status: "accepted",
                                  //     id: id.toString(),
                                  //     isToast: false);
                                  //
                                  // if (response == "completed") {
                                  //   VibrationService.vibrateForDuration(
                                  //       2500);
                                  //   QuickAlertHelper.showSuccessAlert(
                                  //       context,
                                  //       "Your initial payment has been successfully processed.");
                                  // } else if (response == "fail") {
                                  //   VibrationService.vibrateForDuration(
                                  //       2500);
                                  //   QuickAlertHelper.showErrorAlert(context,
                                  //       "Sorry, something went wrong \n Please Try Again");
                                  // }
                                }


                                    }
                                  : () {
                                      ToastMessageHelper.showToastMessage(
                                          "You all ready requested for response",
                                          title: "Information");
                                    },
                              rightBtnOnTap: btnVisible
                                  ? () {
                                      bookingController.customerInitBooking(
                                          status: isNextPaySection ? "service-rejected" : "request-canceled" ,
                                          id: id.toString());
                                    }
                                  : () {
                                      ToastMessageHelper.showToastMessage(
                                          "Your request is being processed.\nPlease with for service provider response",
                                          title: "Information");
                                    },
                            ),
                          ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
