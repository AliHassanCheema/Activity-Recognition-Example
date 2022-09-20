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
          child: viewModel.isBusy ? const CircularProgressIndicator(color: Colors.green,):

          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    viewModel.activityIcon(viewModel.event.type),
                    viewModel.activityText(viewModel.event.type),
                    Text(
                            'Confidence: ${viewModel.event.confidence}%'),
                    Text(viewModel.event.timeStamp
                            .toString()
                            .split(' ')
                            .last
                            .split('.')
                            .first),
                  ],
                ),
              ),
            ),
          )
          
          // ListView.builder(
          //     itemCount: viewModel.events.length,
          //     reverse: true,
          //     itemBuilder: (_, int idx) {
          //       final activity = viewModel.events[idx];
          //       return ListTile(
          //         leading: viewModel.activityIcon(activity.type),
          //         title: Text(
          //             '${activity.type.toString().split('.').last} (${activity.confidence}%)'),
          //         trailing: Text(activity.timeStamp
          //             .toString()
          //             .split(' ')
          //             .last
          //             .split('.')
          //             .first),
          //       );
          //     }),
        ),
      
    );
  
  }
  
  @override
  ActivityViewModel viewModelBuilder(BuildContext context) {
    return ActivityViewModel();
  }

  
}