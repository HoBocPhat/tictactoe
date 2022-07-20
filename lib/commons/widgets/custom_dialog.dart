import 'package:caro_game/app/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDialog extends StatelessWidget {
  final String name;
  const CustomDialog({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = context.read<AppCubit>();
    return Dialog(
      backgroundColor: appCubit.styles.themeData?.backgroundColor,
      elevation: 12,
      child: SizedBox(
        height: 100,
        child: Center(
          child: Text(
              "$name WIN", style: appCubit.styles.defaultHeadlineStyle()),
        ),
      ),
    );
  }
}
