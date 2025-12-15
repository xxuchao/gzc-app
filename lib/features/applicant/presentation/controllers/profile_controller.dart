import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/net_client.dart';

class ApplicantProfileState {
  final bool isLoading;
  final String errorMessage;
  final Map<String, dynamic> userProfile;

  const ApplicantProfileState({
    required this.isLoading,
    required this.errorMessage,
    required this.userProfile,
  });

  factory ApplicantProfileState.initial() => const ApplicantProfileState(
        isLoading: false,
        errorMessage: '',
        userProfile: {},
      );

  ApplicantProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? userProfile,
  }) {
    return ApplicantProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}

final applicantProfileProvider =
    NotifierProvider<ApplicantProfileNotifier, ApplicantProfileState>(
  ApplicantProfileNotifier.new,
);

class ApplicantProfileNotifier extends Notifier<ApplicantProfileState> {
  final NetClient _dioClient = NetClient();

  @override
  ApplicantProfileState build() {
    fetchProfile();
    return ApplicantProfileState.initial();
  }

  Future<void> fetchProfile() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');

      await Future.delayed(const Duration(seconds: 1));

      const profileData = {
        'id': '1',
        'name': '张三',
        'email': 'zhangsan@example.com',
        'phone': '13800138000',
        'avatar': 'https://via.placeholder.com/100',
        'department': '技术部',
        'position': '高级工程师',
      };

      state = state.copyWith(userProfile: profileData);
    } catch (e) {
      state = state.copyWith(errorMessage: '获取个人信息失败: ${e.toString()}');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateProfile(Map<String, dynamic> updateData) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');

      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        userProfile: Map<String, dynamic>.from(state.userProfile)..addAll(updateData),
        errorMessage: '更新成功',
      );
    } catch (e) {
      state = state.copyWith(errorMessage: '更新个人信息失败: ${e.toString()}');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
