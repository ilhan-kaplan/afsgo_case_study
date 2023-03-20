import 'dart:convert';

import 'package:afsgo_case_study/helper/request_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../constant/constants.dart';
import '../model/Todo.dart';
import '../provider/provider_data.dart';

//

class HelperMethods {

  static Future<String> bringTasks(context) async {

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return 'failed';
    }
    String url = Constants.api_main_link + '/bring_tasks.php';


    var response = await RequestHelper.postBringTasks(url,context);
    print('response code: ${response}');
    if (response != 'failed') {
      return 'success';
    } else {
      return 'failed';
    }

  }

  static Future<String> addTask(String title,String des,context) async {

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return 'failed';
    }
    String url = Constants.api_main_link + '/add_task.php';
    var response = await RequestHelper.postAddTask(url,title,des,context);

    if (response != 'failed') {
      return 'success';
    } else {
      return 'failed';
    }

  }

  static Future<String> editTask(String title,String des,String id,context) async {

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return 'failed';
    }
    String url = Constants.api_main_link + '/edit_task.php';
    var response = await RequestHelper.postEditTask(url,title,des,id,context);

    if (response != 'failed') {
      return 'success';
    } else {
      return 'failed';
    }

  }

  static Future<String> deleteTask(String id,context) async {

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return 'failed';
    }
    String url = Constants.api_main_link + '/delete_task.php';
    var response = await RequestHelper.postDeleteTask(url,id,context);

    if (response != 'failed') {
      return 'success';
    } else {
      return 'failed';
    }

  }

  /*static Future<dynamic> updateTask(context,String musteri,String sifre) async {

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return  'failed';
    }
    String url = Constants.api_main_link + '/updateTask';//'/musteri_kayit_guncelle_json.php';

    var response = await RequestHelper.postUpdateTask(url, context, musteri,sifre);
    //print('Response: ${response.statusCode.toString()}');
    //print('Response: ${response.body.toString()}');
    //print('herper: $response');
    if (response != 'failed') {
      return 'basarili';
    } else {
      return 'failed';
    }

  }

  static Future<String> deleteTask(context, int adres) async {

    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.mobile && result != ConnectivityResult.wifi){
      return 'failed';
    }
    String url = Constants.api_main_link + '/deleteTask';

    var response = await RequestHelper.postDeleteTask(url,adres,context);
    print('response kode: ${response.statusCode}');
    if (response.statusCode == 200) {
      //print(response.body);
     String cevap = response.body;
     print('response body: ${response.body}');
      //List<Address> adres_liste = Addresses.fromJson(json.decode(cevap)).adres_listesi;
      //Provider.of<AppData>(context,listen:false).uptadeAddresses(adres_liste);
      return 'basarili';
    } else {
      return 'failed';
    }
  }*/

}
