// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:training_magang/repository/repo_meal.dart';
// import 'package:training_magang/res/res_get_meal.dart';

// part 'meal_state.dart';

// class MealCubit extends Cubit<MealState> {
//   MealCubit() : super(MealInitial());

//   RepoMeal repo = RepoMeal();
//   ResGetMeal? resGetMeal;

//   Future<void> getDataMeal() async {
//     try {
//       emit(MealLoading());
//       ResGetMeal? res = await repo.getMeal();
//       if (res != null) {
//         resGetMeal = res;
//         emit(MealSuccess(resGetMeal));
//       } else {
//         log('error');
//         emit(MealError('error'));
//       }
//     } catch (e) {
//       log('error');
//       emit(MealError(e.toString()));
//     }
//   }
// }
