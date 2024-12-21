import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/user_model.dart';
import '../res/app_urls.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> loginApi(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.login, data);
      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString()); // Handle errors
    }
  }

  Future<UserModel> createUser(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.createUser, data);
      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString()); // Handle errors
    }
  }

  Future<UserModel?> getUser(String userIdentifier) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrls.getUser(userIdentifier));
      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
