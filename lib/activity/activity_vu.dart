import 'package:activity_example/activity/activity_vm.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ActivityScreen extends ViewModelBuilderWidget<ActivityViewModel> {
  const ActivityScreen({super.key});
  
  @override
  Widget builder(BuildContext context, ActivityViewModel viewModel, Widget? child) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Activity Recognition'),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: viewModel.events.length,
              reverse: true,
              itemBuilder: (_, int idx) {
                final activity = viewModel.events[idx];
                return ListTile(
                  leading: viewModel.activityIcon(activity.type),
                  title: Text(
                      '${activity.type.toString().split('.').last} (${activity.confidence}%)'),
                  trailing: Text(activity.timeStamp
                      .toString()
                      .split(' ')
                      .last
                      .split('.')
                      .first),
                );
              }),
        ),
      
    );
  
  }
  
  @override
  ActivityViewModel viewModelBuilder(BuildContext context) {
    return ActivityViewModel();
  }

  
}