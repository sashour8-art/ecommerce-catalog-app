import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repositories/firestore_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirestoreRepository _firestoreRepository;

  ProfileCubit({FirestoreRepository? firestoreRepository})
      : _firestoreRepository = firestoreRepository ?? FirestoreRepository(),
        super(ProfileInitial());

  Future<void> fetchUserData(String uid) async {
    emit(ProfileLoading());
    try {
      final user = await _firestoreRepository.getUserData(uid);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}