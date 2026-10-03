import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:glass_calculator/features/calculator/logic/calculator_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class CalcWidget extends StatelessWidget {
  const CalcWidget({super.key, required this.controller});
  final CalculatorController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28.0, sigmaY: 28.0),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              color: Colors.white.withValues(alpha: 0.08),
              border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
            ),
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, _) => Column(
                mainAxisSize: .max,
                crossAxisAlignment: .end,
                children: [
                  Gap(68.h),
                  SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        controller.expressionText.isEmpty
                            ? ' '
                            : controller.expressionText,
                        maxLines: 1,
                        style: GoogleFonts.jetBrainsMono(
                          color: Colors.white.withValues(alpha: 0.55),
                          letterSpacing: 0.45,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Gap(8.h),
                  SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        controller.resultText,
                        maxLines: 1,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 56.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.4,
                          color: controller.hasError
                              ? const Color(0xFFFF6B6B)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
