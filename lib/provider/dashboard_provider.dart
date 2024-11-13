import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider = StateProvider<bool>((ref) {
  return true;
});

void onChangeDashboardProvider(WidgetRef ref, bool val) {
  ref.read(dashboardProvider.notifier).state = val;
}
