import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(String) onChanged;
  final bool obscureText;
  final TextInputType textInputType;

  const CustomTextFormField({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.onChanged,
    this.obscureText = false,
    this.textInputType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * .140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        // textInputAction: TextInput,
        obscureText: obscureText,
        keyboardType: textInputType,

        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
