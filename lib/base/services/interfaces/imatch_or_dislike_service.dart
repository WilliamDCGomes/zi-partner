import 'package:zi_partner/base/models/matchOrDislike/match_or_dislike.dart';

abstract class IMatchOrDislikeService {
  Future<bool> createMatchOrDislike(MatchOrDislike matchOrDislike);

  Future<bool> updateMatchOrDislike(MatchOrDislike matchOrDislike);

  Future<List<MatchOrDislike>?> getAllMatchsOrDislikes(String userId);

  Future<bool> deleteMatchOrDislike(MatchOrDislike matchOrDislike);
}
