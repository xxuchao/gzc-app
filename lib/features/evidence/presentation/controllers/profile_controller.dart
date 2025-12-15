import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/net_client.dart';

class EvidenceProfileState {
  final bool isLoading;
  final String errorMessage;
  final Map<String, dynamic> userProfile;

  const EvidenceProfileState({
    required this.isLoading,
    required this.errorMessage,
    required this.userProfile,
  });

  factory EvidenceProfileState.initial() => const EvidenceProfileState(
        isLoading: false,
        errorMessage: '',
        userProfile: {},
      );

  EvidenceProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? userProfile,
  }) {
    return EvidenceProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}

final evidenceProfileProvider =
    NotifierProvider<EvidenceProfileNotifier, EvidenceProfileState>(
  EvidenceProfileNotifier.new,
);

class EvidenceProfileNotifier extends Notifier<EvidenceProfileState> {
  final NetClient _dioClient = NetClient();

  @override
  EvidenceProfileState build() {
    fetchProfile();
    return EvidenceProfileState.initial();
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
