import 'package:flutter/material.dart';

/// Centralized spacing, padding, margin, radius, and sizing constants.
abstract final class AppDimensions {
  // ── Raw Spacing Values ─────────────────────────────────────────────
  static const double none = 0.0;
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 48.0;

  // ── EdgeInsets: Insets & Margins ───────────────────────────────────
  static const EdgeInsets paddingZero = EdgeInsets.zero;
  static const EdgeInsets paddingAllXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingAllSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingAllMd = EdgeInsets.all(md);
  static const EdgeInsets paddingAllLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingAllXl = EdgeInsets.all(xxl);

  static const EdgeInsets paddingScreen = EdgeInsets.symmetric(horizontal: lg, vertical: sm);
  static const EdgeInsets paddingScreenAll = EdgeInsets.all(lg);
  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets paddingCard = EdgeInsets.all(md);
  static const EdgeInsets paddingCardSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingButton = EdgeInsets.symmetric(horizontal: xxl, vertical: md);

  // ── Border Radii ───────────────────────────────────────────────────
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  static const Radius radiusCircularSm = Radius.circular(radiusSm);
  static const Radius radiusCircularMd = Radius.circular(radiusMd);
  static const Radius radiusCircularLg = Radius.circular(radiusLg);

  static const BorderRadius borderRadiusSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius borderRadiusMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius borderRadiusLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius borderRadiusXl = BorderRadius.all(Radius.circular(radiusXl));
  static const BorderRadius borderRadiusFull = BorderRadius.all(Radius.circular(radiusFull));

  // ── Component Dimensions ───────────────────────────────────────────
  static const double buttonHeight = 50.0;
  static const double buttonMinHeight = 44.0;
  static const double heroCardHeight = 130.0;
  static const double progressIndicatorSize = 200.0;
  static const double progressStrokeWidth = 16.0;

  static const double iconXs = 14.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
  static const double iconHero = 60.0;

  static const double gradeBadgeSize = 32.0;
  static const double gradeBadgeLarge = 40.0;
  static const double heroCircleSize = 100.0;
}

