import 'package:bloc/bloc.dart';
import 'package:bookia_app/feature/profile/data/models/response/show_profile_response_model/show_profile_response_model.dart';
import 'package:bookia_app/feature/profile/data/repo/profile.dart';
part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()){
    on<ShowProfileEvent>(show_profile);
    on<LogoutEvent>(logout);
  }
ShowProfileResponseModel? showProfileResponseModel;

// ignore: non_constant_identifier_names
Future<void> show_profile(
    ShowProfileEvent event, Emitter<ProfileState> emit) async {
  emit(ProfileLoadingState());
  //api
  await ProfileRepo.showProfile().then((value) {
    if(value !=null){
      showProfileResponseModel=value;
      emit(ProfileLoadedState());
    }else{
      emit(ProfileErrorState());
    }
  },);
}
Future<void> logout(
    LogoutEvent event, Emitter<ProfileState> emit) async {
  emit(LogoutLoadingState());
  //api
  await ProfileRepo.logoutProfile().then((value) {
    if(value){
       emit(LogoutLoadedState());
    }else{
      emit(LogoutErrorState());
    }
  },);
}
}