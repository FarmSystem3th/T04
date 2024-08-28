import 'package:flutter/material.dart';

class ApplyScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  ApplyScreen({required this.navigatorKey});

  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncNavigator();
    }
  }

  void _syncNavigator() {
    final navigatorState = widget.navigatorKey.currentState;
    if (navigatorState != null && navigatorState.canPop()) {
      navigatorState.popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply'),
      ),
      body: Center(
        child: Text('Apply Screen'),
      ),
    );
  }
}
