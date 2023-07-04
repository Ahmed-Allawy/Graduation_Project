import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';

import '../../shared/component/components.dart';

class PicScreen extends StatelessWidget {
  const PicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 105, 116, 235),
            centerTitle: true,
            title: const Text("Adding Face pic"),
          ),
          body: Center(
            child: defaultTextButton(
                text: "Take Photo",
                onpressed: () {
                  SearchCubit.get(context).pickImageCamera();
                }),
          ),
        );
      },
    );
  }
}
