import 'package:bloc/bloc.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_state.dart';
import 'package:majootestcase/bloc/home_bloc/home_event.dart';
import 'package:majootestcase/data/controller/api_service.dart';

class HomeBlocCubit extends Bloc<HomeEvent, HomeBlocState> {
  ApiServices apiServices = ApiServices();
  HomeBlocCubit(this.apiServices);
  @override
  // TODO: implement initialState
  HomeBlocState get initialState => HomeBlocInitialState();

  @override
  Stream<HomeBlocState> mapEventToState(HomeEvent event) async* {
    if (event is HomeStartEvent) {
      yield HomeBlocInitialState();
    } else if (event is HomeLoadingEvent) {
      yield HomeBlocLoadingState();
    } else if (event is HomeLoadedEvent) {
      var data = await apiServices.getMovieList();
      yield HomeBlocLoadedState(data);
    } else {
      yield HomeBlocErrorState(message: "Networking error");
    }
  }
}

HomeBlocCubit homeBlocCubit = HomeBlocCubit(apiServices)..add(HomeStartEvent());
