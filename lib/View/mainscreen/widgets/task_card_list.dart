import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todowithapi/View/mainscreen/widgets/task_card.dart';
import 'package:todowithapi/ViewModel/pi_view_model.dart';
import 'package:todowithapi/services/api_handler.dart';

class TaskCardList extends StatelessWidget {
  const TaskCardList({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    List data = Provider.of<ApiViewModel>(context).allToDo;
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskCard(index: index);
      },
    );
  }
}
