import '../models/matchOrDislike/match_or_dislike.dart';
import '../models/person/person.dart';
import 'base/base_service.dart';
import 'interfaces/imatch_or_dislike_service.dart';

class MatchOrDislikeService extends BaseService implements IMatchOrDislikeService {
  @override
  Future<bool> createMatchOrDislike(MatchOrDislike matchOrDislike) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}MatchOrDislike/CreateMatchOrDislike';
      final response = await super.post(url, matchOrDislike.toJson(), headers: {"Authorization": 'Bearer $token'});
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
  Future<bool> removeMatchOrDislike(MatchOrDislike matchOrDislike) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}MatchOrDislike/RemoveMatchOrDislike';
      final response = await super.put(url, matchOrDislike.toJson(), headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> checkIfItsAMatch(String otherUserId) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}MatchOrDislike/CheckIfItsAMatch';
      final response = await super.get(url, query: {"OtherUserId": otherUserId}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<MatchOrDislike>?> getAllMatchsOrDislikes() async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}MatchOrDislike/GetAllMatchsOrDislikes';
      final response = await super.get(url, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => MatchOrDislike.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Person>?> getNext7PeopleFromMatchs(int skip) async {
    try {
      final token = await getToken();
      httpClient.timeout = const Duration(seconds: 60);
      final url = '${baseUrlApi}MatchOrDislike/GetNext7PeopleFromMatchs';
      final response = await super.get(url, query: {"Skip": skip.toString()}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();

      var peopleList = (response.body as List).map((e) => Person.fromJson(e)).toList();
      peopleList.sort((a, b) {
        if(a.lastMessage != null && a.lastMessage!.inclusion != null && b.lastMessage != null && b.lastMessage!.inclusion != null) {
          return b.lastMessage!.inclusion!.compareTo(a.lastMessage!.inclusion!);
        }
        return peopleList.length - 1;
      });
      return peopleList;
    } catch (_) {
      return null;
    }
  }
}