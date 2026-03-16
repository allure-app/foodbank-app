import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodbank_app/ui/core/ui/empty_screen.dart';
import 'package:foodbank_app/ui/core/ui/error_screen.dart';

abstract class HasIsEmpty {
  bool get isEmpty;
}

class FbScaffold<T> extends ConsumerWidget {
  const FbScaffold({
    super.key,
    required this.title,
    required this.builder,
    required this.provider,
    required this.onLoad,
    this.onAdd,
  });

  final String title;
  final Widget Function(T state) builder;
  final AsyncNotifierProvider<AsyncNotifier<T>, T> provider;
  final Function()? onAdd;
  final Function() onLoad;

  bool _isEmpty(T data) {
    if (data is Iterable) {
      return data.isEmpty;
    } else if (data is HasIsEmpty) {
      return data.isEmpty;
    }

    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    final widget = state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorScreen(error: error.toString(), onReload: onLoad),
      data: (data) => _isEmpty(data)
          ? EmptyScreen(label: 'items', onReload: onLoad)
          : builder(data),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: SafeArea(child: widget),
      floatingActionButton: state.error == null && onAdd != null
          ? FloatingActionButton(onPressed: onAdd, child: Icon(Icons.add))
          : SizedBox.shrink(),
    );
  }
}
