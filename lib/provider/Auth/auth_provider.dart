import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoginOpenProvider = StateProvider<bool>((ref) => true);

void changeIsLoginOpen(WidgetRef ref, val) {
  // toggle the state
  ref.read(isLoginOpenProvider.notifier).state = val;
}
