import 'package:flutter/material.dart';
import '../../core/state/data_state.dart';

class DStateBuilder<T> extends StatelessWidget {
  final DataState<T> state;
  final Widget Function() onInitial;
  final Widget Function() onLoading;
  final Widget Function(T data) onSuccess;
  final Widget Function(String message) onError;
  final Widget Function() onEmpty;

  const DStateBuilder({
    super.key,
    required this.state,
    required this.onLoading,
    required this.onSuccess,
    required this.onError,
    required this.onEmpty,
    Widget Function()? onInitial,
  }) : onInitial = onInitial ?? onLoading;

  @override
  Widget build(BuildContext context) {
    return state.when(initial: onInitial, loading: onLoading, success: onSuccess, error: onError, empty: onEmpty);
  }
}
