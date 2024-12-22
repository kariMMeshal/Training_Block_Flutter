import 'package:basketball_counter_app/cubit/counter_state.dart';
import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(ACounterState());

  int teamAPoint = 0;
  int teamBPoint = 0;

  void incrementPoints({required String team, required int buttonNum}) {
    if (team == "A") {
      teamAPoint += buttonNum;
      emit(ACounterState());
    } else {
      teamBPoint += buttonNum;
      emit(BCounterState());
    }
  }

  void resetPoints() {
    teamAPoint = 0;
    teamBPoint = 0;
    emit(ACounterState());
  }
}
