// webview_state.dart
import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

sealed class WebViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WebViewLoadingState extends WebViewState {}

final class WebViewLoadedState extends WebViewState {
  final WebViewController controller;

  WebViewLoadedState({required this.controller});

  @override
  List<Object?> get props => [controller];
}

final class WebViewErrorState extends WebViewState {
  final String errorMessage;
  WebViewErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
