import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Calf Check — net-to-gate calculator.
///
/// Hosts the same self-contained web bundle the Honest Cattle site uses
/// (engine + live Montana market snapshot + UI), loaded from jsDelivr via a
/// small local asset. Because the bundle is CDN-hosted, this screen stays in
/// sync with the website automatically — no app release needed for data
/// refreshes.
class NetToGateView extends StatefulWidget {
  const NetToGateView({super.key});

  @override
  State<NetToGateView> createState() => _NetToGateViewState();
}

class _NetToGateViewState extends State<NetToGateView> {
  static const _asset = 'assets/calculator.html';
  late final WebViewController _controller;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF7F2E7))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _loading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (error) {
            // Only surface failures of the main document; a flaky subresource
            // is handled by the in-page 6s fallback message.
            if (mounted && error.isForMainFrame == true) {
              setState(() {
                _loading = false;
                _error = true;
              });
            }
          },
        ),
      )
      ..loadFlutterAsset(_asset);
  }

  void _reload() {
    setState(() {
      _error = false;
      _loading = true;
    });
    _controller.loadFlutterAsset(_asset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calf Check')),
      body: Stack(
        children: [
          if (!_error) WebViewWidget(controller: _controller),
          if (_loading && !_error)
            const Center(child: CircularProgressIndicator()),
          if (_error) _offline(),
        ],
      ),
    );
  }

  Widget _offline() => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              const Text(
                'Couldn’t load the calculator.\n'
                'Check your connection and try again.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: _reload, child: const Text('Retry')),
            ],
          ),
        ),
      );
}
