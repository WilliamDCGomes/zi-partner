import '../models/userPictures/user_pictures.dart';
import 'base/base_service.dart';
import 'interfaces/ipicture_service.dart';

class PictureService extends BaseService implements IPictureService {
  @override
  Future<bool> createPicture(UserPictures userPictures) async {
    try {
      final url = '${baseUrlApi}Picture/CreatePicture';
      final response = await super.post(url, userPictures.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updatePicture(UserPictures userPictures) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Picture/UpdatePicture';
      final response = await super.put(url, userPictures.toJson(), headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<UserPictures>?> getAll() async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Picture/GetAll';
      final response = await super.get(url, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => UserPictures.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> deletePicture(String pictureId) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Picture/DeletePicture';
      final response = await super.delete(url, query: {"PictureId": pictureId}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteAllPictureOfUser() async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Picture/DeleteAllPictureOfUser';
      final response = await super.delete(url, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }
}