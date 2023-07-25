import 'package:zi_partner/base/models/matchOrDislike/match_or_dislike.dart';
import '../../models/person/person.dart';

abstract class IMatchOrDislikeService {
  Future<bool> createMatchOrDislike(MatchOrDislike matchOrDislike);

  Future<bool> updateMatchOrDislike(MatchOrDislike matchOrDislike);

  Future<bool> checkIfItsAMatch(String otherUserId);

  Future<List<MatchOrDislike>?> getAllMatchsOrDislikes();

  Future<List<Person>?> getNext7PeopleFromMatchs(int skip);

  Future<bool> removeMatchOrDislike(MatchOrDislike matchOrDislike);
}
