import 'package:debate/shared/themes/themes.dart';
import 'package:flutter/material.dart';

// ignore_for_file: annotate_overrides, overridden_fields, prefer_typing_uninitialized_variables, unnecessary_this
// ignore: must_be_immutable
class CustomInputDecoration extends InputDecoration {
  final String text;
  final BuildContext context;

  var contentPadding, hintStyle, errorBorder, enabledBorder, disabledBorder, border, isDense;
  var hintText, floatingLabelBehavior, isCollapsed, label, labelText, prefixIcon, fillColor;
  var focusedBorder, filled, prefixIconConstraints;

  double radius;

  final double borderOpacity;
  final Color focusedBorderColor;

  CustomInputDecoration(this.text, this.context,
      {this.prefixIcon,
      this.contentPadding = const EdgeInsets.only(left: 15, top: 15, bottom: 15),
      this.radius = 50,
      this.fillColor = backgroundColour,
      this.focusedBorderColor = blueVarient,
      this.borderOpacity = .7})
      : this.errorBorder = OutlineInputBorder(
            borderSide: BorderSide(color: redVarient), borderRadius: BorderRadius.circular(radius)),
        this.focusedBorder = OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor), borderRadius: BorderRadius.circular(radius)),
        this.enabledBorder = OutlineInputBorder(
            borderSide: BorderSide(color: seperator.withOpacity(borderOpacity), width: .7),
            borderRadius: BorderRadius.circular(radius)),
        this.disabledBorder = InputBorder.none,
        this.border = OutlineInputBorder(
            borderSide: BorderSide(color: seperator), borderRadius: BorderRadius.circular(radius)),
        this.prefixIconConstraints =
            const BoxConstraints(minHeight: 27, minWidth: 27, maxHeight: 45, maxWidth: 45),
        this.isDense = false,
        this.hintText = text,
        this.isCollapsed = true,
        this.filled = true,
        // fillColor = ,
        this.floatingLabelBehavior = FloatingLabelBehavior.never;
}
