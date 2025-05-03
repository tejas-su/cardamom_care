import 'package:cardamom_care/blocs/web_view_bloc/web_view_bloc.dart';
import 'package:cardamom_care/blocs/web_view_bloc/web_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisualizationScreen extends StatelessWidget {
  const VisualizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WebViewBloc, WebViewState>(
          builder: (context, state) {
            return switch (state) {
              WebViewLoadingState() => Center(
                  child: CircularProgressIndicator(),
                ),
              WebViewLoadedState() =>
                WebViewWidget(controller: state.controller),
              WebViewErrorState() =>
                Center(child: Text('Looks like something went wrong')),
            };
          },
        ),
      ),
    );
  }
}
