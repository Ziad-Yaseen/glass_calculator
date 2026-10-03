import 'package:flutter/material.dart';

enum KeyType { number, operations1, operations2, ac, equal }

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double gap = 12.0;

    return const Expanded(
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _KeyboardKey(label: 'AC', type: KeyType.ac),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(
                    icon: Icons.backspace_outlined,
                    type: KeyType.operations1,
                  ),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '%', type: KeyType.operations1),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '÷', type: KeyType.operations2),
                ),
              ],
            ),
          ),
          SizedBox(height: gap),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _KeyboardKey(label: '7', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '8', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '9', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '×', type: KeyType.operations2),
                ),
              ],
            ),
          ),
          SizedBox(height: gap),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _KeyboardKey(label: '4', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '5', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '6', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '−', type: KeyType.operations2),
                ),
              ],
            ),
          ),
          SizedBox(height: gap),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _KeyboardKey(label: '1', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '2', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '3', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _KeyboardKey(label: '+', type: KeyType.operations2),
                ),
              ],
            ),
          ),
          SizedBox(height: gap),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: _KeyboardKey(label: '0', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  flex: 1,
                  child: _KeyboardKey(label: '.', type: KeyType.number),
                ),
                SizedBox(width: gap),
                Expanded(
                  flex: 1,
                  child: _KeyboardKey(label: '=', type: KeyType.equal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyboardKey extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final KeyType type;

  const _KeyboardKey({this.label, this.icon, required this.type});

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
      onTap: () {},
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
