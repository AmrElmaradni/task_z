import 'package:flutter/material.dart';

import '../../../helper/networking/api_helper.dart';
import '../custom_button/custom_button.dart';

class ApiResponseWidget extends StatelessWidget {
  final ApiResponse apiResponse;
  final Widget child;
  final bool isEmpty;

  final void Function()? onReload;
  const ApiResponseWidget({
    Key? key,
    required this.apiResponse,
    required this.child,
    required this.onReload,
    required this.isEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (apiResponse.state) {
      case ResponseState.sleep:
        return const SizedBox();
      case ResponseState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ResponseState.complete:
      case ResponseState.pagination:
        if (isEmpty) {
          return const Center(child: Icon(Icons.folder_off_rounded));
        } else {
          return child;
        }
      case ResponseState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error),
              CustomButton(
                text: 'Reload',
                onPressed: onReload,
                width: 100,
              )
            ],
          ),
        );
      case ResponseState.unauthorized:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error),
              CustomButton(
                text: 'Reload',
                onPressed: onReload,
                width: 100,
              )
            ],
          ),
        );
      case ResponseState.offline:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_rounded),
              CustomButton(
                text: 'Reload',
                onPressed: onReload,
                width: 100,
              )
            ],
          ),
        );
    }
  }
}
