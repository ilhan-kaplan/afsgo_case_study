import 'package:afsgo_case_study/views/edit_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/constants.dart';
import '../helper/helper_methods.dart';
import '../model/Todo.dart';
import '../provider/provider_data.dart';
import 'add_task.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Todo>? taskList;
  bool taskControl = false;
  bool taskNum = true;

  void bringTasks() async{

    var response = await HelperMethods.bringTasks(context);
 print(response);
    if(response != "failed"){
      taskList = Provider.of<ProviderData>(context,listen: false).bringTasks;
      if(taskList!.length == 0){
        setState(() {
          taskNum = false;
        });
      }else{
        if(taskList![0].id != 'yok'){
          setState(() {
            taskControl = true;
          });
        }

      }
    }else{
      const snackBar =  SnackBar(content: Text('Failed'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  void daleteTask(String id) async{

    var response = await HelperMethods.deleteTask(id,context);
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
    bringTasks();
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
          title:  Center(child: Text('Task List',style: TextStyle(
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
                Expanded(
                  child: taskControl == true ? Container(
                    child: ListView.builder(
                        itemCount: taskList!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: (){
                                  //Navigator.push( context, MaterialPageRoute(builder: (context) => BookPage(haftaninKitaplari[index])));
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          titleText((index+1).toString()),
                                          titleText(taskList![index].title),
                                          const SizedBox(width: 20),
                                        ],
                                      ),
                                    ),
                                    desText(taskList![index].description),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),
                                              foregroundColor: Colors.blue,
                                            ),
                                            onPressed: () {
                                              Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => EditTaskPage(taskList![index])));
                                            },
                                            child: const Text('Edit'),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),
                                              foregroundColor: Colors.red,
                                            ),
                                            onPressed: () {
                                              daleteTask(taskList![index].id);
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: appWidth,
                                height: 1,
                                color: Constants.dividerColor,
                              ),
                            ],
                          );

                        }),
                  ) :
                  taskNum == false ? Container(
                    alignment: Alignment.center,
                    child: Text('Tasks Loading...'),
                  ) : Container(
                    alignment: Alignment.center,
                    child: Text('There is no task.'),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right:20,
              child:GestureDetector(
                onTap: (){
                  Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => AddTaskPage()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                    color: Constants.accentColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child:Text('Add New',style: TextStyle(
                    color: Constants.iconsTextColor,
                    fontWeight: FontWeight.w600,
                  ),),
                ),
              ),
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
}
