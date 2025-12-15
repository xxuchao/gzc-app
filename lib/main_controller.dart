import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home/presentation/pages/home_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/evidence/presentation/pages/evidence_page.dart';
import 'features/applicant/presentation/pages/applicant_page.dart';
import 'features/case/presentation/pages/case_page.dart';

final mainCurrentIndexProvider =
    NotifierProvider<MainCurrentIndexNotifier, int>(MainCurrentIndexNotifier.new);

class MainCurrentIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}

final mainPagesProvider = Provider<List<Widget>>(
  (ref) => const [
    HomePage(),
    EvidencePage(),
    CasePage(),
    ApplicantPage(),
    ProfilePage(),
  ],
);
