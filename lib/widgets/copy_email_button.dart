import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/constant.dart';

/// Copies the email address to the clipboard and briefly confirms it.
class CopyEmailButton extends StatefulWidget {
  const CopyEmailButton({super.key, required this.email});

  final String email;

  @override
  State<CopyEmailButton> createState() => _CopyEmailButtonState();
}

class _CopyEmailButtonState extends State<CopyEmailButton> {
  bool _copied = false;
  Timer? _reset;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.email));
    if (!mounted) return;
    setState(() => _copied = true);
    _reset?.cancel();
    _reset = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: OutlinedButton.icon(
        onPressed: _copy,
        icon: Icon(_copied ? Icons.check : Icons.copy_outlined, size: 20),
        label: Text(_copied ? ui.copied : ui.copyEmail),
      ),
    );
  }
}
