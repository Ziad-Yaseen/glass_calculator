import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:glass_calculator/features/calculator/widgets/calc_widget.dart';
import 'package:glass_calculator/features/calculator/widgets/calculator_bg.dart';
import 'package:glass_calculator/features/calculator/widgets/custom_app_bar.dart';
import 'package:glass_calculator/features/calculator/widgets/keyboard_widget.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorBG(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const CustomAppBar(),
              Gap(16.h),
              const CalcWidget(),
              Gap(14.h),
              const KeyboardWidget(),
              SizedBox(
                height: 44.h,
                child: InkWell(
                  onTap: () {
                    print('top');
                  },
                  child: Center(
                    child: Container(
                      width: 128.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999.r),
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
