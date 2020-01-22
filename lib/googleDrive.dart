
import 'dart:convert';
import 'dart:io';
import 'package:flutterdrive/secureStorage.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'JsonData.dart';


const _clientId="792701028781-0us3631n30s40vimafjp4oqc3tasvotb.apps.googleusercontent.com";
const _clientSecret="lVyVPQrkzTCL6lgEO6k7Tiq6";
const _scopes=[ga.DriveApi.DriveFileScope];

class GoogleDrive{
  List<JsonData> list = List();

  final _securestorage= SecureStorage();

//Get Authenticate Http Client
Future<http.Client> getHttpClient() async{
  var credentials = await _securestorage.getCredentials();
  if(credentials == null){
    var authClient= await clientViaUserConsent(ClientId(_clientId, _clientSecret), _scopes, (url){
      //Open Url in browser
      launch(url);
    });
    return authClient;
  }
  else{

    return authenticatedClient(http.Client(),AccessCredentials(AccessToken(credentials["type"],credentials["data"],DateTime.parse(credentials["expiry"])),credentials["refreshToken"],_scopes));
  }
  }



  Future<File> googleFile() async {
    String url = "https://drive.google.com/file/d/152bvDxiX4NvWfREC1CBaCxwvKddtprZ5/view";
    String filename="DummyJson.json";
    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(url));
    var bytes = req.bodyBytes;
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    //String dir = (await getExternalStorageDirectory()).path;
    File file = new File('$tempPath/$filename');
    await file.writeAsString(req.body);
    var data=file.readAsString() ;
    String variable= data.toString();
    print("List of File"+req.body.toString());
    return file;
}





//Upload FIle
    Future upload(File file) async{
      var client= await getHttpClient();
      var drive =ga.DriveApi(client);

      var response= await drive.files.create(ga.File()..name=path.basename(file.absolute.path),uploadMedia: ga.Media(file.openRead(),file.lengthSync()));

      print(response.toJson());

    }


}