
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth.dart';

class SecureStorage{

  final _securestorage = FlutterSecureStorage();


  //Save Credentials
  Future  saveCredentials(AccessToken token, String refreshToken) async{
    await _securestorage.write(key: "type", value: token.type);
    await _securestorage.write(key: "data", value: token.data);
    await _securestorage.write(key: "expiry", value: token.expiry.toIso8601String());
    await _securestorage.write(key: "refreshToken", value: refreshToken);

  }


  //Get the credentials
  Future<Map<String,dynamic>> getCredentials() async{
    var result = await _securestorage.readAll();
    if(result.length==0) return null;
    return result;
  }


  //Clear the credentials
  Future clear(){
    return _securestorage.deleteAll();
  }
}