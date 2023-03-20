import 'package:afsgo_case_study/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/constants.dart';
import '../helper/helper_methods.dart';
import '../model/Todo.dart';
import '../provider/provider_data.dart';

class AddTaskPage extends StatefulWidget {

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String warningText = '';

  List<Todo>? taskList;
  bool taskControl = false;
  bool taskNum = true;

  void addTask(String title, String des) async{

    var response = await HelperMethods.addTask(title, des,context);
 print(response);
    if(response != "failed"){
      Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => HomePage()));
    }else{
      const snackBar =  SnackBar(content: Text('Failed'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Constants.primaryDarkColor,
          title:  Center(child: Text('Add Task',style: TextStyle(
            color: Constants.iconsTextColor,
            fontSize: 16,
          ),)),
          actions: [
            /*IconButton(
              icon: Icon(Icons.person,color: Colors.white,),
              onPressed: () {
                //Navigator.pop(context);
                //Navigator.push( context, MaterialPageRoute(builder: (context) => BottomNavBarPage(3)));
                //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a snackbar')));
              },
            ),*/
          ]),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 30),
                titleText('Add Task Form'),
                SizedBox(height: 15),
                textFieldLogin('Title', 'Please enter a title',titleController),
                SizedBox(height: 10),
                textFieldDesLogin('Description','Please enter a description',descriptionController),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Constants.primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        String one = titleController.text;
                        String two = descriptionController.text;
                        if (one != '' && two != '') {
                          one = titleController.text.trim();
                          two = descriptionController.text.trim();
                          addTask(one,two);
                        } else {
                          warningText = 'Please fill all fields.';
                        }
                      });
                    },
                    child: Text('ADD TASK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                desText(warningText),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Padding desText(String des) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(des,style: TextStyle(
         fontWeight: FontWeight.w500,
         fontSize: 14,
         color: Constants.secondaryTextColor,
       ),
      ),
    );
  }

  Text titleText(String title) {
    return Text(title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Constants.primaryTextColor,
      ),
    );
  }

  Padding textFieldLogin(String labelT, String hintT,TextEditingController controller) {
    return Padding(
      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        height: 50,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Constants.primaryTextColor,),
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //borderSide: BorderSide(color: Constants.colorFont,),
              ),
              labelText: labelT,
              hintText: hintT),
        ),
      ),
    );
  }

  Padding textFieldDesLogin(String labelT, String hintT,TextEditingController controller) {
    return Padding(
      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        height: 160,
        child: TextField(
          maxLines: 8,
          controller: controller,
          decoration: InputDecoration(
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Constants.primaryTextColor,),
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //borderSide: BorderSide(color: Constants.colorFont,),
              ),
              labelText: labelT,
              hintText: hintT),
        ),
      ),
    );
  }

}
