import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CalcWidget extends StatelessWidget {
  const new({super.key});

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
            child: Column(
              mainAxisSize: .max,
              crossAxisAlignment: .end,
              children: [
                Gap(68.h),
                Text(
                  '6,000 ÷ 2 + 3,227 × 2',
                  style: GoogleFonts.jetBrainsMono(
                    color: Colors.white.withValues(alpha: 0.55),
                    letterSpacing: 0.45,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(8.h),
                Text(
                  '12,454',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 56.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1.4,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
