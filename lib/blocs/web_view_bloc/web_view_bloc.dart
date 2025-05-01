import 'dart:ui';

import 'package:cardamom_care/blocs/web_view_bloc/web_view_event.dart';
import 'package:cardamom_care/blocs/web_view_bloc/web_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  late WebViewController _webViewController;

  WebViewBloc() : super(WebViewLoadingState()) {
    initWebView();
    on<WebViewLoadEvent>(_onLoad);
    on<WebViewRefreshEvent>(_onRefresh);
  }

  initWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..loadRequest(Uri.parse(
          'https://cardamomvisualisation-npdssk6eafnruxa6rj4ssu.streamlit.app/'));
  }

  //Load the page
  _onLoad(WebViewLoadEvent event, Emitter<WebViewState> emit) {
    emit(WebViewLoadedState(controller: _webViewController));
  }

  //Refresh the page
  Future<void> _onRefresh(
      WebViewRefreshEvent event, Emitter<WebViewState> emit) async {
    emit(WebViewLoadingState());
    try {
      await _webViewController.reload();
      emit(WebViewLoadedState(controller: _webViewController));
    } catch (e) {
      emit(WebViewErrorState(errorMessage: e.toString()));
    }
  }
}
