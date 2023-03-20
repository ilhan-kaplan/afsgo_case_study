import 'dart:convert';

import 'package:afsgo_case_study/provider/provider_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/Todos.dart';

//
class RequestHelper {

  static Future<dynamic> postBringTasks(String url,context) async {

    String token = 'afsgo1234';

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return 'failed';
    }

    final response = await http.post(
      Uri.parse(url),
      body: {
        'token': token,
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      var taskList = Todos.fromJson(json.decode(data)).todo_list;
      Provider.of<ProviderData>(context,listen: false).taskList(taskList);
      return 'success';
    } else {
      return 'failed';
    }
  }

  static Future<dynamic> postAddTask(String url, String title, String des, context) async {

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return 'failed';
    }


    final response = await http.post(
      Uri.parse(url),
      body: {
        "title":title,
        "des": des,
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      if(decodedData['message'] == 'success'){
        return 'success';
      }else{
        return 'failed';
      }
    } else {
      return 'failed';
    }
  }

  static Future<dynamic> postEditTask(String url, String title, String des, String id, context) async {

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return 'failed';
    }

    print('id: $id');

    final response = await http.post(
      Uri.parse(url),
      body: {
        "id":id,
        "title":title,
        "des": des,
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      if(decodedData['message'] == 'success'){
        return 'success';
      }else{
        return 'failed';
      }
    } else {
      return 'failed';
    }
  }

  static Future<dynamic> postDeleteTask(String url, String id, context) async {

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return 'failed';
    }

    final response = await http.post(
      Uri.parse(url),
      body: {
        "id":id
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      if(decodedData['message'] == 'success'){
        return 'success';
      }else{
        return 'failed';
      }
    } else {
      return 'failed';
    }
  }

}