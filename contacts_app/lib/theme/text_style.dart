
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_resources.dart';
import 'dimensions.dart';

TextStyle h1 = GoogleFonts.inter(
  fontSize: 32,
  fontWeight: FontWeight.w700,
);

TextStyle inter27 = GoogleFonts.inter(
  fontSize: 27,
  fontWeight: FontWeight.w700,
);
TextStyle h2 = GoogleFonts.inter(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

TextStyle h3 = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

TextStyle heading1 = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

TextStyle heading2 = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w700,
);
TextStyle body1 = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

TextStyle body1poppins = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);
TextStyle body2 = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);
TextStyle inter12500 = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

TextStyle body8 = GoogleFonts.inter(
  fontSize: 8,
  fontWeight: FontWeight.w400,
);
TextStyle subHeading = GoogleFonts.inter(
  fontSize: 10,
  fontWeight: FontWeight.w700,
);

TextStyle subText = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

//
TextStyle display = GoogleFonts.inter(
  fontSize: 40,
  fontWeight: FontWeight.w800,
);

// TextStyle h1 = GoogleFonts.inter(
//   fontSize: 60,
//   fontWeight: FontWeight.w500,
// );
// TextStyle h2 = GoogleFonts.inter(
//   fontSize: 30,
//   fontWeight: FontWeight.w500,
// );
// TextStyle h3 = GoogleFonts.inter(
//   fontSize: 24,
//   fontWeight: FontWeight.w700,
// );
TextStyle h4 = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w700,
);
TextStyle h5 = GoogleFonts.inter(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);
TextStyle h6 = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
TextStyle subHeading1 = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
TextStyle subHeading2 = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);
TextStyle font14W500 = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);
TextStyle font14W400 = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

TextStyle caption = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);
TextStyle captionMedium = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w500,
);
TextStyle buttonText = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

TextStyle body1Medium = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
TextStyle body1Medium600 = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
TextStyle body2Medium = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);
// TextStyle body1 = GoogleFonts.inter(
//   fontSize: 16,
//   fontWeight: FontWeight.w400,
// );

// TextStyle body2 = GoogleFonts.inter(
//   fontSize: 14,
//   fontWeight: FontWeight.w400,
// );
TextStyle inter = GoogleFonts.inter(
  fontSize: 25,
  fontWeight: FontWeight.w600,
);

const EdgeInsets pagePadding =
    EdgeInsets.symmetric(horizontal: paddingLarge, vertical: paddingXL);
const EdgeInsets pagePaddingXL = EdgeInsets.symmetric(horizontal: paddingXL);

extension TextStyleExtensions on TextStyle {
  TextStyle get primary => copyWith(color: ColorResources.PRIMARY);
  TextStyle get border => copyWith(color: ColorResources.BORDER);
  TextStyle get borderShade => copyWith(color: ColorResources.BORDER_SHADE);
  TextStyle get green => copyWith(color: ColorResources.GREEN);
  TextStyle get grey => copyWith(color: ColorResources.GREY);
  TextStyle get grey1 => copyWith(color: ColorResources.GREY1);
  TextStyle get grey2 => copyWith(color: ColorResources.GREY2);
  TextStyle get placeholder => copyWith(color: ColorResources.PLACEHOLDER);
  TextStyle get red => copyWith(color: ColorResources.RED);
  TextStyle get yellow => copyWith(color: ColorResources.YELLOW);
  TextStyle get secondary => copyWith(color: ColorResources.SECONDARY);
  TextStyle get text1 => copyWith(color: ColorResources.TEXT1);
  TextStyle get text2 => copyWith(color: ColorResources.TEXT2);
  TextStyle get blackgrey => copyWith(color: ColorResources.BLACKGREY);

  TextStyle get black => copyWith(color: ColorResources.BLACK);

  TextStyle get white => copyWith(color: ColorResources.WHITE);

  TextStyle get s12 => copyWith(fontSize: 12.0);
  TextStyle get s14 => copyWith(fontSize: 14.0);
  TextStyle get s16 => copyWith(fontSize: 16.0);
  TextStyle get s18 => copyWith(fontSize: 18.0);
  TextStyle get s25 => copyWith(fontSize: 25.0);
  TextStyle get s30 => copyWith(fontSize: 30.0);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
}
