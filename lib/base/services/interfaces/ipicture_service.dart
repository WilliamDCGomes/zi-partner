import '../../models/userPictures/user_pictures.dart';

abstract class IPictureService {
  Future<bool> createPicture(UserPictures userPictures);

  Future<bool> updatePicture(UserPictures userPictures);

  Future<List<UserPictures>?> getAll(String userId);

  Future<bool> deletePicture(String pictureId);

  Future<bool> deleteAllPictureOfUser(String userId);
}
