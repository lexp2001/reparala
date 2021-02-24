import 'package:flutter/material.dart';

class InputWithIcon extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;

  final ValueChanged<String> onChanged;

  final TextEditingController controller;
  final void Function(String value) validator;

  const InputWithIcon({
    Key key,
    this.icon,
    this.hint,
    this.obscure,
    this.onChanged,
    this.controller,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Color(0xFFBFF4949),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 21),
            child: Icon(icon),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: hint),
              onChanged: onChanged,
            ),
          )
        ],
      ),
    );
  }
}
