import 'package:flutter/material.dart';
import 'package:glass_calculator/features/calculator/logic/calculator_controller.dart';

enum KeyType { number, operations1, operations2, ac, equal }

class _KeyData {
  const _KeyData({this.label, this.icon, required this.type, this.flex = 1});
  final String? label;
  final IconData? icon;
  final KeyType type;
  final int flex;
}

const _backspaceKey = _KeyData(
  icon: Icons.backspace_outlined,
  type: KeyType.operations1,
);

const List<List<_KeyData>> _rows = [
  [
    _KeyData(label: 'AC', type: KeyType.ac),
    _backspaceKey,
    _KeyData(label: '%', type: KeyType.operations1),
    _KeyData(label: '÷', type: KeyType.operations2),
  ],
  [
    _KeyData(label: '7', type: KeyType.number),
    _KeyData(label: '8', type: KeyType.number),
    _KeyData(label: '9', type: KeyType.number),
    _KeyData(label: '×', type: KeyType.operations2),
  ],
  [
    _KeyData(label: '4', type: KeyType.number),
    _KeyData(label: '5', type: KeyType.number),
    _KeyData(label: '6', type: KeyType.number),
    _KeyData(label: '−', type: KeyType.operations2),
  ],
  [
    _KeyData(label: '1', type: KeyType.number),
    _KeyData(label: '2', type: KeyType.number),
    _KeyData(label: '3', type: KeyType.number),
    _KeyData(label: '+', type: KeyType.operations2),
  ],
  [
    _KeyData(label: '0', type: KeyType.number, flex: 2),
    _KeyData(label: '.', type: KeyType.number),
    _KeyData(label: '=', type: KeyType.equal),
  ],
];

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget({super.key, required this.controller});
  final CalculatorController controller;

  static const double _gap = 12.0;

  void _onKey(_KeyData k) {
    if (k.type == KeyType.ac) {
      controller.clear();
    } else if (identical(k, _backspaceKey)) {
      controller.backspace();
    } else if (k.type == KeyType.equal) {
      controller.equals();
    } else {
      controller.input(k.label!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var r = 0; r < _rows.length; r++) {
      if (r > 0) rows.add(const SizedBox(height: _gap));
      final keys = <Widget>[];
      for (var c = 0; c < _rows[r].length; c++) {
        final k = _rows[r][c];
        if (c > 0) keys.add(const SizedBox(width: _gap));
        keys.add(
          Expanded(
            flex: k.flex,
            child: _KeyboardKey(
              label: k.label,
              icon: k.icon,
              type: k.type,
              onTap: () => _onKey(k),
            ),
          ),
        );
      }
      rows.add(
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: keys,
          ),
        ),
      );
    }
    return Expanded(child: Column(children: rows));
  }
}

class _KeyboardKey extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final KeyType type;
  final VoidCallback onTap;

  const _KeyboardKey({
    this.label,
    this.icon,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color fillColor;
    Color borderColor;
    Color contentColor = Colors.white;
    Gradient? gradient;

    switch (type) {
      case KeyType.ac:
        fillColor = Colors.white.withValues(alpha: .10);
        borderColor = const Color(0xFFEF4444).withValues(alpha: .20);
        contentColor = const Color(0xFFFF6B6B);
        break;
      case KeyType.operations2:
        fillColor = const Color(0xFF007FFF).withValues(alpha: .22);
        borderColor = const Color(0xFF52E8FF).withValues(alpha: .35);
        contentColor = const Color(0xFF52E8FF);
        break;
      case KeyType.number:
        fillColor = const Color(0xFF1C1F26).withValues(alpha: .65);
        borderColor = Colors.white.withValues(alpha: .10);
        contentColor = Colors.white;
        break;
      case KeyType.operations1:
        fillColor = Colors.white.withValues(alpha: .1);
        borderColor = Colors.white.withValues(alpha: .20);

        break;
      case KeyType.equal:
        fillColor = Colors.transparent;
        borderColor = Colors.white.withValues(alpha: .40);
        gradient = const LinearGradient(
          colors: [Color(0xFF52E8FF), Color(0xFF007FFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        break;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: gradient == null ? fillColor : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1),
        ),
        alignment: Alignment.center,
        child: icon != null
            ? Icon(icon, color: contentColor, size: 28)
            : Text(
                label ?? '',
                style: TextStyle(
                  color: contentColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
      ),
    );
  }
}
