import 'package:store_demo/core/services/local_storage.dart';
import 'package:store_demo/core/utils/constants/key_storage.dart';
import 'package:store_demo/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> saveUserInformation(String params);

  Future<UserModel> getUserInformation();

  Future<bool> saveToken(String params);

  Future<String> getToken();

  Future<bool> saveRefreshToken(String params);

  Future<String> getRefreshToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final TLocalStorage _localStorage;

  AuthLocalDataSourceImpl(this._localStorage);

  @override
  Future<UserModel> getUserInformation() async {
    final userJson = await _localStorage.readValue(TKeyStorage.user);
    return UserModel.deserialize(userJson);
  }

  @override
  Future<bool> saveUserInformation(String params) async {
    await _localStorage.setValue(TKeyStorage.user, params);
    return true;
  }

  @override
  Future<bool> saveToken(String params) async {
    return await _localStorage.setValue(TKeyStorage.token, params);
  }

  @override
  Future<String> getToken() async {
    return await _localStorage.readValue(TKeyStorage.token);
  }

  @override
  Future<String> getRefreshToken() async {
    return await _localStorage.readValue(TKeyStorage.refreshToken);
  }

  @override
  Future<bool> saveRefreshToken(String params) async {
    return await _localStorage.setValue(TKeyStorage.refreshToken, params);
  }
}
