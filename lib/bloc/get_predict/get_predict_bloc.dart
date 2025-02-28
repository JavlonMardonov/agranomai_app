// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:developer';
// import 'dart:io';

// import 'package:agranom_ai/common/utils/enums/statuses.dart';
// import 'package:agranom_ai/data/models/get_predict_dto.dart';
// import 'package:agranom_ai/data/repositories/home_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';


// part 'image_upload_bloc.freezed.dart';
// part 'get_predict_event.dart';
// part 'get_predict_state.dart';


// class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
//   final HomeRepo homeRepo;
//   ImageUploadBloc(this.homeRepo) : super(ImageUploadState()) {
//     on(_getMovieSearchs);
//   }

//   Future<void> _getMovieSearchs(_GetUploadEvent event, Emitter emit) async {
//     emit(state.copyWith(status: Statuses.Loading));
//     try {
//       final result = await homeRepo.getImageUrl(imageFile: event.imagefile);
//       log("Keldi search $result");
//       emit(state.copyWith(filePath: result, status: Statuses.Success));
//     } catch (e) {
//       emit(state.copyWith(
//         errorMessage: e.toString(),
//         status: Statuses.Error,
//       ));
//     }
//   }
// }
