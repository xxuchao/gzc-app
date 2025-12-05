import "package:flutter/material.dart";
import "package:get/get.dart";

import 'features/home/presentation/pages/home_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/Evidence/presentation/pages/evidence_page.dart';
import 'features/applicant/presentation/pages/applicant_page.dart';
import 'features/case/presentation/pages/case_page.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;

  // 存储所有页面列表
  final List<Widget> pages = [
    const HomePage(),
    const EvidencePage(),
    const CasePage(),
    const ApplicantPage(),
    const ProfilePage(),
  ];

  // 切换页面
  void changePage(int index) {
    currentIndex.value = index;
  }
}
