import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_calculator/features/calculator/widgets/rounded_circular_container_with_icon.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28.0, sigmaY: 28.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white.withValues(alpha: 0.08),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
          ),
          child: Row(
            children: [
              const RoundedCircularContainerWithIcon(icon: Icons.history),
              const Spacer(),
              Text(
                'CALCULATOR',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
              const Spacer(),
              const RoundedCircularContainerWithIcon(
                icon: Icons.sunny,
                iconCOlor: Color(0xFF52E8FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
