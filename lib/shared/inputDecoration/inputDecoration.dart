import 'package:debate/shared/themes/themes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomInputDecoration extends InputDecoration {
  final String text;
  final BuildContext context;

  var contentPadding;
  var hintStyle;
  var errorBorder;
  var enabledBorder;
  var disabledBorder;
  var border;
  var isDense;
  var hintText;
  var floatingLabelBehavior;
  var isCollapsed;
  var label;
  var labelText;
  var prefixIcon;
  var fillColor;
  var focusedBorder;
  var filled;
  var prefixIconConstraints;
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
      :
        this.errorBorder = OutlineInputBorder(
          borderSide: new BorderSide(color: redVarient),
          borderRadius: new BorderRadius.circular(radius),
        ),
        this.focusedBorder = OutlineInputBorder(
          borderSide: new BorderSide(color: focusedBorderColor),
          borderRadius: new BorderRadius.circular(radius),
        ),
        this.enabledBorder = OutlineInputBorder(
          borderSide: new BorderSide(color: seperator.withOpacity(borderOpacity), width: .7),
          borderRadius: new BorderRadius.circular(radius),
        ),
        this.disabledBorder = InputBorder.none,
        this.border = OutlineInputBorder(
          borderSide: new BorderSide(color: seperator),
          borderRadius: new BorderRadius.circular(radius),
        ),
        this.prefixIconConstraints = BoxConstraints(minHeight: 27, minWidth: 27, maxHeight: 45, maxWidth: 45),
        this.isDense = false,
        this.hintText = text,
        this.isCollapsed = true,
        this.filled = true,
        // fillColor = ,
        this.floatingLabelBehavior = FloatingLabelBehavior.never;
}
