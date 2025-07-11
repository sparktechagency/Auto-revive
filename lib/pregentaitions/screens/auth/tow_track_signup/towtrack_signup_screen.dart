import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../widgets/custom_text.dart';

class TowTrackSignupScreen extends StatefulWidget {
  const TowTrackSignupScreen({super.key});

  @override
  State<TowTrackSignupScreen> createState() => _TowTrackSignupScreenState();
}


class _TowTrackSignupScreenState extends State<TowTrackSignupScreen> {

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  RxBool isMatched = false.obs;
  RxBool isObscureConfirmPassword = true.obs;
  toggleIsObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }
  ismMatchedColor() {isMatched.value = !isMatched.value;}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: CustomText(text: "As a Tow truck Owner", fontsize: 18.h),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48.h),

                ///<<<=============>>> Name Filed <<<===============>>>

                CustomText(
                    text: "Your Name",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),
                CustomTextField(controller: nameCtrl, hintText: "Enter your name"),

                ///<<<=============>>> Email Filed <<<===============>>>

                CustomText(
                    text: "E-mail",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),
                CustomTextField(controller: emailCtrl, hintText: "Enter your e-mail"),

                ///<<<=============>>> PASSWORD Filed <<<===============>>>

                CustomText(
                    text: "Password",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),
                CustomTextField(controller: passwordCtrl, hintText: "Enter your password", prefixIcon: Assets.icons.key.svg(), isPassword: true),

                ///<<<=============>>>CONFIRM PASSWORD Filed <<<===============>>>

                CustomText(
                    text: "Confirm Password",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),
                CustomTextField(
                  controller: confirmPasswordCtrl,
                  hintText: "Re-enter your password",
                  prefixIcon: Assets.icons.key.svg(),
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      Future.delayed(Duration.zero, () => isMatched.value = false);
                      return "Please enter your confirm password";
                    } else if (passwordCtrl.text == value) {
                      Future.delayed(Duration.zero, () => isMatched.value = true);
                      return null;
                    } else {
                      Future.delayed(Duration.zero, () => isMatched.value = false);
                      return "Password Not Matching";
                    }
                  },
                  onChanged: (value) {
                    isMatched.value = passwordCtrl.text == value;
                  },
                ),
                Obx(() => Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:  EdgeInsets.only(top: 15.h),
                      child: CustomText(text: isMatched.value ? "Password Matched" : "",color: Colors.green,fontsize: 14.sp,),
                    ))),

                SizedBox(height: 200.h),
                Obx(()=>
                    CustomButton(
                      loading: authController.mechanicSignUpLoading.value,
                      title: "Sign Up",
                      onpress: () {
                        if(fromKey.currentState!.validate()){
                          authController.mechanicHandleSignUp(
                            context: context,
                            name: nameCtrl.text,
                            email: emailCtrl.text,
                            password: passwordCtrl.text.trim(),
                            confirmPassword: confirmPasswordCtrl.text.trim(),
                          );
                        }
                      },),
                ),
                SizedBox(height: 70.h)
              ],
            ),
          ),
        ),
      ),
    );

  }



}
