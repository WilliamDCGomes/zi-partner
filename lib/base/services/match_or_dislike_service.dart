import '../models/matchOrDislike/match_or_dislike.dart';
import 'base/base_service.dart';
import 'interfaces/imatch_or_dislike_service.dart';

class MatchOrDislikeService extends BaseService implements IMatchOrDislikeService {
  @override
  Future<bool> createMatchOrDislike(MatchOrDislike matchOrDislike) async {
    try {
      final url = '${baseUrlApi}MatchOrDislike/CreateMatchOrDislike';
      final response = await super.post(url, matchOrDislike.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updateMatchOrDislike(MatchOrDislike matchOrDislike) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}MatchOrDislike/UpdateMatchOrDislike';
      final response = await super.put(url, matchOrDislike.toJson(), headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<MatchOrDislike>?> getAllMatchsOrDislikes(String userId) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}MatchOrDislike/GetAllMatchsOrDislikes';
      final response = await super.get(url, query: {"UserId": userId}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => MatchOrDislike.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> deleteMatchOrDislike(MatchOrDislike matchOrDislike) async {
    try {
      final url = '${baseUrlApi}MatchOrDislike/DeleteMatchOrDislike';
      final response = await super.delete(url, query: matchOrDislike.toJson());
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }
}