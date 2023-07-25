import '../../models/userPictures/user_pictures.dart';

abstract class IPictureService {
  Future<bool> createPicture(UserPictures userPictures);

  Future<bool> updatePicture(UserPictures userPictures);

  Future<List<UserPictures>?> getAll();

  Future<bool> deletePicture(String pictureId);

  Future<bool> deleteAllPictureOfUser();
}
