import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  final String userName;
  final int streak;
  final int totalScore;
  final DateTime? lastOpenDate;

  const UserProfile({
    this.userName = 'Student',
    this.streak = 0,
    this.totalScore = 0,
    this.lastOpenDate,
  });

  UserProfile copyWith({
    String? userName,
    int? streak,
    int? totalScore,
    DateTime? lastOpenDate,
  }) {
    return UserProfile(
      userName: userName ?? this.userName,
      streak: streak ?? this.streak,
      totalScore: totalScore ?? this.totalScore,
      lastOpenDate: lastOpenDate ?? this.lastOpenDate,
    );
  }
}
