import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todowithapi/View/add_task/add_task.dart';
import 'package:todowithapi/View/mainscreen/widgets/profile_pic.dart';
import 'package:todowithapi/View/mainscreen/widgets/task_card.dart';
import 'package:todowithapi/View/mainscreen/widgets/task_card_list.dart';
import 'package:todowithapi/ViewModel/pi_view_model.dart';
import 'package:todowithapi/services/api_handler.dart';
import 'package:todowithapi/shared/appstyle.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
@override
  void initState() {
  Provider.of<ApiViewModel>(context,listen: false).getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfilePic(),
              const SizedBox(height: 8,),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffD9D9D9),
                ),
                child: Text(
                  DateFormat.yMMMMEEEEd().format(
                    DateTime.now(),
                  ),
                ),
              ),
              const SizedBox(height: 5,),

              Text(
                "Good evening , user ",
                style: appTextStyle(FontWeight.bold, 14),
              ),
              const SizedBox(height: 5,),

              Text(
                "Tasks",
                style: appTextStyle(FontWeight.bold, 16),
              ),
              const SizedBox(height: 5,),
              context.watch<ApiViewModel>().isLoading?const Expanded(
                child: Center(child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: Color(0xffDFBD43),
                )),
              ):
              context.watch<ApiViewModel>().allToDo.isEmpty?Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/images/notask.png"),
                    Text("Nothing here yet...",style: appTextStyle(FontWeight.bold , 12),)
                  ],
                ),
              ):const Expanded(
                child: TaskCardList(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xffDFBD43),
                    child: const Icon(
                      Icons.add,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  AddTasks(isEdit: false,),));
                    },
                  ),
                ),
              ),
             /* Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xffDFBD43),
                    child: const Icon(
                      Icons.remove,
                      size: 40,
                    ),
                    onPressed: () async {
                     await  ApiHandler.getData();
                    },
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}


