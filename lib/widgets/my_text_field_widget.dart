import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  bool? obsecureText =false;
  IconButton? suffixIcon;
  IconButton? prefixIcon;
  final ValueChanged<String>? onChanged;
  String? Function(String?)? validator;
  Function? onEditingComplete;
  GestureTapCallback? onTap;
  bool? enabled=true;
  int? maxLines;
  String? hintText;
  TextInputType? keyboardType;
  bool? autoFocus;
  double? height;
  double? width;
  int? maxLength;
  FocusNode? focusNode;
  bool? phoneNumber=false;
  bool? disableborder=false;
  double?borderRadiusCircular;
  Color?fillColor;
  Color? borderColor;
  Color? labelTextColor;
  Color? textInputColor;
  Color? cursorColor;

  ///Constructor
  MyTextField({
    @required this.controller,
    @required this.label,
    this.obsecureText,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.onEditingComplete,
    this.enabled,
    this.onTap,
    this.maxLines,
    this.hintText,
    this.keyboardType,
    this.autoFocus,
    this.height,
    this.width,
    this.maxLength,
    this.focusNode,
    this.phoneNumber,
    this.disableborder,
    this.borderRadiusCircular,
    this.fillColor,
    this.borderColor,
    this.labelTextColor,
    this.validator,
    this.textInputColor,
    this.cursorColor
  });

  @override
  Widget build(BuildContext context) {
    bool _passwordVisible = false;
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          validator: validator,
          focusNode: focusNode,
          maxLength: maxLength,
          autofocus: autoFocus??false,
          keyboardType: keyboardType,
          maxLines: maxLines??1,
          enabled: enabled,
          onTap: onTap,
          onEditingComplete: (){ onEditingComplete!(); },
          expands: false,
          onChanged: onChanged,
          controller: controller,
          obscureText: obsecureText??false,
          cursorColor: cursorColor??Colors.black,
          style: phoneNumber??false
            ? const TextStyle(fontSize: 16,)
            : TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: textInputColor??Colors.grey.shade600),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            fillColor: fillColor??Colors.white,
            filled: true,
            focusColor: Colors.grey.shade600,
            hoverColor: Colors.black,
            labelText: label,
            hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
            labelStyle: TextStyle(color: labelTextColor??Colors.black, fontSize: 16,),
            errorStyle: const TextStyle(color: Colors.red, fontSize: 16,),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor??Colors.transparent,),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor??Colors.transparent,),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor??Colors.transparent,),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            border:  OutlineInputBorder(
              borderSide: BorderSide(color: borderColor??Colors.transparent,),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
          )
        ),
      ),
    );
  }
}
