import 'package:caro_game/app/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlankSpace extends StatelessWidget {
  const BlankSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = context.read<AppCubit>();
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 30,
        height: 30,
        color: appCubit.styles.backgroundContainer(),
        //child: Text('.'),
      ),
    );
  }
}
