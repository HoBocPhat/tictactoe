import 'package:caro_game/app/cubit/app_cubit.dart';
import 'package:caro_game/commons/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextInput extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  const TextInput({Key? key, required this.labelText, required this.controller}) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    final AppCubit appCubit = context.read<AppCubit>();
    return TextFormField(
      style: appCubit.styles.defaultTextStyle(),
      controller: widget.controller,
      cursorColor: AppColors.green,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: AppColors.green),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.green
          )
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.green
            )
        ),
      ),

    );
  }
}
