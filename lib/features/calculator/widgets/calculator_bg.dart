import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculatorBG extends StatelessWidget {
  const CalculatorBG({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
              colors: [Color(0xFF000000), Color(0xFF0B0621), Color(0xFF241571)],
            ),
          ),
          child: Stack(
            alignment: .center,
            children: [
              Positioned(
                top: -64.h,
                left: -64.w,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 54.0, sigmaY: 54.0),
                  child: Container(
                    width: 256.w,
                    height: 256.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF8A2BE2).withValues(alpha: 0.45),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 157.h,
                left: 274.66.w,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
                  child: Container(
                    width: 288.w,
                    height: 288.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFF1F7A).withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 444.h,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 68.0, sigmaY: 68.0),
                  child: Container(
                    width: 320.w,
                    height: 320.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF007FFF).withValues(alpha: 0.45),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 620.h,
                left: 150.w,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                  child: Container(
                    width: 240.w,
                    height: 240.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFF5A3C).withValues(alpha: 0.45),
                    ),
                  ),
                ),
              ),

              child
            ],
          ),
        ),
      ),
    );
  }
}
