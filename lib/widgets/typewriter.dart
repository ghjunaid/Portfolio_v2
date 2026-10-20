import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_theme.dart';
import '../utils/reduced_motion.dart';

/// Types each word, pauses, deletes it, then moves to the next. Screen
/// readers get the whole list once instead of the flickering text.
class Typewriter extends StatefulWidget {
  const Typewriter({super.key, required this.words, this.style});

  final List<String> words;
  final TextStyle? style;

  @override
  State<Typewriter> createState() => _TypewriterState();
}

class _TypewriterState extends State<Typewriter> {
  Timer? _timer;
  bool _reduce = false;
  bool _started = false;
  int _word = 0;
  int _chars = 0;
  bool _deleting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduce = prefersReducedMotion(context);
    if (_reduce) {
      _timer?.cancel();
    } else if (!_started) {
      _started = true;
      _schedule(const Duration(milliseconds: 500));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _schedule(Duration delay) => _timer = Timer(delay, _tick);

  void _tick() {
    if (!mounted || widget.words.isEmpty) return;
    final word = widget.words[_word];
    setState(() {
      if (!_deleting) {
        if (_chars < word.length) {
          _chars++;
          _schedule(const Duration(milliseconds: 70));
        } else {
          _deleting = true;
          _schedule(const Duration(milliseconds: 1800));
        }
      } else if (_chars > 0) {
        _chars--;
        _schedule(const Duration(milliseconds: 35));
      } else {
        _deleting = false;
        _word = (_word + 1) % widget.words.length;
        _schedule(const Duration(milliseconds: 300));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.words.isEmpty) return const SizedBox.shrink();
    final vibe = Vibe.of(context);
    final style = widget.style ?? DefaultTextStyle.of(context).style;
    final shown = _reduce
        ? widget.words.first
        : widget.words[_word].substring(0, _chars);

    return Semantics(
      label: widget.words.join(', '),
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(shown, style: style)),
            if (!_reduce)
              Container(
                    width: 3,
                    height: (style.fontSize ?? 16) * 1.2,
                    margin: const EdgeInsets.only(left: 2),
                    color: vibe.accent,
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .fade(begin: 1, end: 0, duration: 500.ms),
          ],
        ),
      ),
    );
  }
}
