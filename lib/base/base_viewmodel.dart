import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_state.dart';

class BaseViewModel<T> extends StateNotifier<BaseViewState<T>> {
  BaseViewModel(BaseViewState<T> viewState) : super(viewState);

  set data(T data) => state = state.copyWith(data: data, isSuccess: true);

  set isLoading(bool isLoading) => state = state.copyWith(isLoading: isLoading);

  set error(BaseError error) => state = state.copyWith(error: error);
}
//done