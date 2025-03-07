import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:agranom_ai/data/models/get_history_dto.dart';
import 'package:agranom_ai/data/repositories/history_repository.dart';

part 'history_bloc.freezed.dart';
part 'history_event.dart';
part 'history_state.dart';


class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository _repository;

  HistoryBloc(this._repository) : super(const HistoryState.initial()) {
    on<FetchHistory>(_onFetchHistory);
  }

  Future<void> _onFetchHistory(
    FetchHistory event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      emit(const HistoryState.loading());
      final response = await _repository.getHistory();
      emit(HistoryState.loaded(response.data ?? []));
    } catch (e) {
      emit(HistoryState.error(e.toString()));
    }
  }
}
