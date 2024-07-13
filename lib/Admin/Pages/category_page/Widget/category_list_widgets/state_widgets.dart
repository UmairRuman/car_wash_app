import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceDataIntialStateWidget extends ConsumerWidget {
  const ServiceDataIntialStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text("No Service Found"),
    );
  }
}

class ServiceDataLoadingStateWidget extends StatelessWidget {
  const ServiceDataLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ServiceDataErrorStateWidget extends StatelessWidget {
  final String error;
  const ServiceDataErrorStateWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
