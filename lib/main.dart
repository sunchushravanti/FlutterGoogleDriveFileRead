import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterdrive/JsonData.dart';
import 'package:flutterdrive/googleDrive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drive Demo',
      theme: ThemeData(
        fontFamily: 'LiuJianMaoCao',
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list = List();
  TextEditingController _textFieldController = TextEditingController();
  String _displayValue = "";

  _onSubmitted(String value) {
    setState(() => _displayValue = value);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 //   downloadFile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Drive Demo',style: TextStyle(fontFamily: 'LiuJianMaoCao'),),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter a search term'

        ),
          controller: _textFieldController,
          onSubmitted: _onSubmitted,
      ),
           FlatButton(child: Text('Retrieve Google File'),onPressed: () async{
             _writeToFile(_displayValue);
           },
           ),

            new Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 200.0,
                    child: new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new Card(
                        child: new Text(list[index]["name"])

                        );
                      },
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _writeToFile(String text) async {
    // Write the file
    Directory tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir.path;
    String fileName="hello.txt";
    File file = new File('$tempPath/$fileName');

    File result = await file.writeAsString('$text');

    if (result == null ) {
      print("Writing to file failed");
    } else {
      print("Successfully writing to file");

      print("Reading the content of file");
      String readResult = await _readFile();
      print("readResult: " + readResult.toString());
    }
  }

  Future _readFile() async {
    try {
      Directory tempDir = await getExternalStorageDirectory();
      String tempPath = tempDir.path;
      String fileName="hello.txt";
      File file = new File('$tempPath/$fileName');

      // Read the file
      return await file.readAsString();
    } catch (e) {
      // Return null if we encounter an error
      return null;
    }
  }








/*
  Future<String> downloadFile(String value) async {
    */
/*var response=await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts/1"),
        headers: {"Accept":"application/json"}

    );
    print("response List ,${response.body}");

    Map userMap = jsonDecode(response.body);

    var user = JsonData.fromMappedJson(userMap);
    print("User List ,${user.title}");

 //  list = user as List;
    return "Success";
 *//*


    var response=await http.get(
        Uri.encodeFull("https://drive.google.com/file/d/152bvDxiX4NvWfREC1CBaCxwvKddtprZ5/view"),
        headers: {"Accept":"application/json"}

    );
    print("response List ,${response.body}");

    String url = "https://drive.google.com/file/d/1037d06CKDKdWNJ6WWb4RPisA5Ur32mOm/view?usp=sharing";
    String filename="OFL.txt";
    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(url));
    var bytes = req.bodyBytes;
    Directory tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir.path;
    //String dir = (await getExternalStorageDirectory()).path;
    File file = new File('$tempPath/$filename');
    await file.writeAsBytes(bytes);
    String data=await file.readAsString() ;
    print("User List "+data.toString());
    //var user = JsonData.fromMappedJson(data);
   // print("Users List ,${user.name}");


    Map userMap = jsonDecode(data);

    print("User List "+data.toString());
*/
/*
   *//*
*/
/* String variable= data.toString();
    print("List of File"+req.body.toString());
    return file;
  *//*
*/
/*
  *//*
 return "success";

  }
*/

}
