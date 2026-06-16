import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

@immutable
class ScoreChangeEvent {
  final int newScore;

  const ScoreChangeEvent(this.newScore);
}

@immutable
class StreakChangeEvent {
  final int newStreak;

  const StreakChangeEvent(this.newStreak);
}

class ProfileService {
  static const String _keyUserName = 'user_name';
  static const String _keyStreak = 'streak';
  static const String _keyTotalScore = 'total_score';
  static const String _keyLastOpenDate = 'last_open_date';

  UserProfile profile = const UserProfile();
  SharedPreferences? _prefs;
  final ValueNotifier<ScoreChangeEvent> scoreNotifier = ValueNotifier(const ScoreChangeEvent(0));
  final ValueNotifier<StreakChangeEvent> streakNotifier = ValueNotifier(const StreakChangeEvent(0));

  static final ProfileService _instance = ProfileService._internal();

  factory ProfileService() => _instance;

  static ProfileService get instance => _instance;

  ProfileService._internal();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await _load();
    await checkAndUpdateStreakForAppOpen();
  }

  Future<void> _load() async {
    final prefs = _prefs!;
    final userName = prefs.getString(_keyUserName) ?? 'Student';
    final streak = prefs.getInt(_keyStreak) ?? 0;
    final totalScore = prefs.getInt(_keyTotalScore) ?? 0;
    final lastOpenMillis = prefs.getInt(_keyLastOpenDate);
    final lastOpenDate =
        lastOpenMillis != null ? DateTime.fromMillisecondsSinceEpoch(lastOpenMillis) : null;

    profile = UserProfile(
      userName: userName,
      streak: streak,
      totalScore: totalScore,
      lastOpenDate: lastOpenDate,
    );

    scoreNotifier.value = ScoreChangeEvent(profile.totalScore);
    streakNotifier.value = StreakChangeEvent(profile.streak);
  }

  Future<void> saveUserName(String userName) async {
    profile = profile.copyWith(userName: userName);
    await _prefs!.setString(_keyUserName, userName);
  }

  Future<void> addScore(int amount) async {
    final newScore = profile.totalScore + amount;
    profile = profile.copyWith(totalScore: newScore);
    await _prefs!.setInt(_keyTotalScore, newScore);
    scoreNotifier.value = ScoreChangeEvent(newScore);
  }

  Future<void> checkAndUpdateStreakForAppOpen() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (profile.lastOpenDate == null) {
      profile = profile.copyWith(streak: 1, lastOpenDate: today);
      await _prefs!.setInt(_keyStreak, 1);
      await _prefs!.setInt(_keyLastOpenDate, today.millisecondsSinceEpoch);
      streakNotifier.value = StreakChangeEvent(1);
      return;
    }

    final last = profile.lastOpenDate!;
    final lastDay = DateTime(last.year, last.month, last.day);
    final difference = today.difference(lastDay).inDays;

    if (difference == 0) {
      return;
    } else if (difference == 1) {
      final newStreak = profile.streak + 1;
      profile = profile.copyWith(streak: newStreak, lastOpenDate: today);
      await _prefs!.setInt(_keyStreak, newStreak);
      streakNotifier.value = StreakChangeEvent(newStreak);
    } else {
      profile = profile.copyWith(streak: 1, lastOpenDate: today);
      await _prefs!.setInt(_keyStreak, 1);
      streakNotifier.value = StreakChangeEvent(1);
    }

    await _prefs!.setInt(_keyLastOpenDate, today.millisecondsSinceEpoch);
  }

  Future<void> persistLastSessionScore(int score) async {
    await _prefs!.setInt('last_session_score', score);
  }

  Future<int> get lastSessionScore async =>
      _prefs?.getInt('last_session_score') ?? 0;
}
