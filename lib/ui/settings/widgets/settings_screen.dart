// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:foodbank_app/ui/core/ui/fb_scaffold.dart';
// import 'package:foodbank_app/ui/settings/view_models/settings_view_model.dart';
//
// class SettingsScreen extends ConsumerWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final viewModel = ref.read(settingsViewModelProvider);
//
//     return FbScaffold(
//       title: 'Settings',
//       provider: settingsViewModelProvider,
//       onLoad: () {},
//       child: ElevatedButton(
//         onPressed: viewModel.dropDatabase,
//         child: Text('Clear Database'),
//       ),
//     );
//   }
// }
