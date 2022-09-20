import 'dart:async';
import 'dart:io';
import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class ActivityViewModel extends BaseViewModel{
  StreamSubscription<ActivityEvent>? activityStreamSubscription;
  final List<ActivityEvent> events = [];
  ActivityEvent event = ActivityEvent(ActivityType.UNKNOWN, 90);
  ActivityRecognition activityRecognition = ActivityRecognition();


  ActivityViewModel(){
        startTracking();
  }

  void startTracking() async{
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.request().isGranted) {
        await onStream();
        events.add(ActivityEvent.unknown());
        notifyListeners();
      }else{
       await onStream();
       events.add(ActivityEvent.unknown());
       notifyListeners();
      }
    }
    
  }

  onStream(){
    setBusy(true);
    activityStreamSubscription = activityRecognition
        .activityStream(runForegroundService: true)
        .listen(onData, onError: onError);
        setBusy(false);
  }

  void onData(ActivityEvent activityEvent) {
    debugPrint(activityEvent.toString());
    event = activityEvent;
      events.add(activityEvent);
      notifyListeners();
  }

  void onError(Object error) {
    debugPrint('ERROR - $error');
  }

  Icon activityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.WALKING:
        return const Icon(Icons.directions_walk);
      case ActivityType.IN_VEHICLE:
        return const Icon(Icons.car_rental);
      case ActivityType.ON_BICYCLE:
        return const Icon(Icons.pedal_bike);
      case ActivityType.ON_FOOT:
        return const Icon(Icons.directions_walk);
      case ActivityType.RUNNING:
        return const Icon(Icons.run_circle);
      case ActivityType.STILL:
        return const Icon(Icons.cancel_outlined);
      case ActivityType.TILTING:
        return const Icon(Icons.redo);
      default:
        return const Icon(Icons.device_unknown);
    }
  }
  @override
  void dispose() {
    activityStreamSubscription?.cancel();
    super.dispose();
  }
}