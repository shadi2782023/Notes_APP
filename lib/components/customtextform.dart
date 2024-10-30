import 'package:flutter/material.dart';

class CustomTextFormLogin extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData icondata;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscuretext;
  final void Function()? onTapIcon;
  const CustomTextFormLogin({
    super.key,
    required this.hinttext,
    required this.labeltext,
    required this.icondata,
    required this.mycontroller,
    required this.valid,
    required this.isNumber,
    this.obscuretext,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        // ignore: unrelated_type_equality_checks
        obscureText: obscuretext == null || obscuretext == false ? false : true,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            suffixIcon: InkWell(
              onTap: onTapIcon,
              child: Icon(
                icondata,
                color: Colors.yellow.shade800,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            label: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                labeltext,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow.shade800,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.yellow.shade800,
            )),
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }
}
