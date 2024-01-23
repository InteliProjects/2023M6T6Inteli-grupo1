import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmall10_1 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmallGray400 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray400,
        fontSize: 10.fSize,
      );
  static get bodySmallMontserrat =>
      theme.textTheme.bodySmall!.montserrat.copyWith(
        fontSize: 10.fSize,
      );
  // Cabin text style
  static get cabinBluegray100 => TextStyle(
        color: appTheme.blueGray100,
        fontSize: 5.fSize,
        fontWeight: FontWeight.w400,
      ).cabin;
  static get cabinBluegray100Bold => TextStyle(
        color: appTheme.blueGray100,
        fontSize: 5.fSize,
        fontWeight: FontWeight.w700,
      ).cabin;
  // Display text style
  static get displaySmallAmber300 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.amber300,
      );
  static get displaySmallBlueA400 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.blueA400,
      );
  static get displaySmallGreen500 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.green500,
      );
  static get displaySmallGreenA700 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.greenA700,
      );
  static get displaySmallIndigoA400 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.indigoA400,
      );
  static get displaySmallYellowA400 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.yellowA400,
      );
  // Label text style
  static get labelLargeCabinBluegray100 =>
      theme.textTheme.labelLarge!.cabin.copyWith(
        color: appTheme.blueGray100,
      );
}

extension on TextStyle {
  TextStyle get cabin {
    return copyWith(
      fontFamily: 'Cabin',
    );
  }

  TextStyle get rawline {
    return copyWith(
      fontFamily: 'Rawline',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }
}
