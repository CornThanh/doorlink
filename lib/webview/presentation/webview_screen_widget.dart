import 'package:doorlink_mobile/webview/presentation/webview_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WebviewScreenWidget extends StatefulWidget {
  const WebviewScreenWidget({super.key, required this.title, this.url});
  final String title;
  final String? url;

  @override
  State<WebviewScreenWidget> createState() => _WebviewScreenWidgetState();
}

class _WebviewScreenWidgetState extends State<WebviewScreenWidget> {
  late WebviewViewModel _viewModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    _viewModel = createModel(context, () => WebviewViewModel());
    
    // Initialize WebViewController with the URL from widget
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    
    // Load the URL from widget or fallback to a default
    final urlToLoad = widget.url ?? 'https://flutter.dev';
    controller.loadRequest(Uri.parse(urlToLoad));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_viewModel.unfocusNode),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: FlutterFlowTheme.of(context).primaryText,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          titleSpacing: 0,
          title: Text(
            widget.title,
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Nunito Sans',
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Nunito Sans'),
                ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
