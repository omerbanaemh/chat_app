import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver{
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if(!kReleaseMode){
      debugPrint("onChange -- ${bloc.runtimeType}, $change");
    }
  }
}