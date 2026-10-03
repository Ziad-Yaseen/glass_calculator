import 'package:flutter/foundation.dart';

class CalculatorController extends ChangeNotifier {
  static const int _maxDigits = 15;
  static const String _ops = '+−×÷';

  String _expr = '';
  String _result = '0';
  bool _justEvaluated = false;
  bool _hasError = false;

  String get expressionText => _formatExpression(_expr);

  String get resultText => _result;

  bool get hasError => _hasError;

  void input(String key) {
    if (_hasError) _resetAll();

    if (_isDigit(key)) {
      _digit(key);
    } else if (key == '.') {
      _dot();
    } else if (_ops.contains(key)) {
      _operator(key);
    } else if (key == '%') {
      _percent();
    }
    _updatePreview();
    notifyListeners();
  }

  void backspace() {
    if (_hasError) {
      _resetAll();
    } else if (_justEvaluated) {
      _justEvaluated = false;
      if (_expr.isNotEmpty) _expr = _expr.substring(0, _expr.length - 1);
    } else if (_expr.isNotEmpty) {
      _expr = _expr.substring(0, _expr.length - 1);
    }
    _updatePreview();
    notifyListeners();
  }

  void clear() {
    _resetAll();
    notifyListeners();
  }

  void equals() {
    if (_expr.isEmpty) return;
    final value = _evaluate(_expr);
    if (value == null) {
      _hasError = true;
      _result = 'Error';
    } else {
      _result = _formatNumber(value);
      _expr = _rawNumber(value);
      _justEvaluated = true;
    }
    notifyListeners();
  }

  void _resetAll() {
    _expr = '';
    _result = '0';
    _justEvaluated = false;
    _hasError = false;
  }

  bool _isDigit(String s) => s.length == 1 && '0123456789'.contains(s);
  bool _isOp(String s) => s.isNotEmpty && _ops.contains(s);

  String get _last => _expr.isEmpty ? '' : _expr[_expr.length - 1];

  String get _currentNumber {
    var i = _expr.length;
    while (i > 0 && !_isOp(_expr[i - 1])) {
      i--;
    }
    return _expr.substring(i);
  }

  void _digit(String d) {
    if (_justEvaluated) {
      _expr = '';
      _justEvaluated = false;
    }
    if (_last == '%') return;
    final cur = _currentNumber;
    if (cur.replaceAll('.', '').length >= _maxDigits) return;
    if (cur == '0') {
      _expr = _expr.substring(0, _expr.length - 1) + d;
    } else {
      _expr += d;
    }
  }

  void _dot() {
    if (_justEvaluated) {
      _expr = '';
      _justEvaluated = false;
    }
    if (_last == '%') return;
    final cur = _currentNumber;
    if (cur.contains('.')) return;
    _expr += cur.isEmpty ? '0.' : '.';
  }

  void _operator(String op) {
    _justEvaluated = false;
    if (_expr.isEmpty) {
      if (op == '−') _expr = '−';
      return;
    }
    if (_expr == '−') return;
    if (_isOp(_last)) {
      final withoutLast = _expr.substring(0, _expr.length - 1);
      if (withoutLast.isEmpty) return;
      _expr = withoutLast + op;
    } else {
      if (_last == '.') _expr = _expr.substring(0, _expr.length - 1);
      _expr += op;
    }
  }

  void _percent() {
    _justEvaluated = false;
    if (_expr.isEmpty || _isOp(_last) || _last == '.') return;
    _expr += '%';
  }

  void _updatePreview() {
    if (_expr.isEmpty) {
      _result = '0';
      return;
    }
    if (_justEvaluated) return;
    final value = _evaluate(_expr);
    if (value != null) _result = _formatNumber(value);
  }

  double? _evaluate(String raw) {
    var s = raw;
    while (s.isNotEmpty && _isOp(s[s.length - 1])) {
      s = s.substring(0, s.length - 1);
    }
    if (s.isEmpty || s == '−') return null;
    try {
      final p = _Parser(s);
      final v = p.parse();
      if (v.isNaN || v.isInfinite) return null;
      return v;
    } catch (_) {
      return null;
    }
  }

  String _rawNumber(double v) {
    if (v == 0) return '0'; // avoid "-0"
    var s = v.toStringAsFixed(10);
    if (s.contains('.')) {
      s = s.replaceFirst(RegExp(r'0+$'), '');
      s = s.replaceFirst(RegExp(r'\.$'), '');
    }
    if (s == '-0' || s.isEmpty) s = '0';
    return s.replaceFirst('-', '−');
  }

  String _formatNumber(double v) {
    if (v.abs() >= 1e15) {
      return v.toStringAsExponential(6).replaceFirst('-', '−');
    }
    return _group(_rawNumber(v));
  }

  String _formatExpression(String raw) {
    if (raw.isEmpty) return '';
    final out = StringBuffer();
    final num = StringBuffer();
    void flush() {
      if (num.isNotEmpty) {
        out.write(_group(num.toString()));
        num.clear();
      }
    }

    for (final ch in raw.split('')) {
      if (_isDigit(ch) || ch == '.') {
        num.write(ch);
      } else {
        flush();
        out.write(_isOp(ch) ? ' $ch ' : ch);
      }
    }
    flush();
    return out.toString().trim().replaceAll('  ', ' ');
  }

  String _group(String s) {
    var sign = '';
    var body = s;
    if (body.startsWith('−')) {
      sign = '−';
      body = body.substring(1);
    }
    final parts = body.split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );
    return '$sign$intPart${parts.length > 1 ? '.${parts[1]}' : ''}';
  }
}

class _Parser {
  _Parser(this.s);
  final String s;
  int i = 0;

  double parse() {
    final v = _expr();
    if (i != s.length) throw const FormatException('unexpected input');
    return v;
  }

  double _expr() {
    var v = _term();
    while (i < s.length && (s[i] == '+' || s[i] == '−')) {
      final op = s[i++];
      final r = _term();
      v = op == '+' ? v + r : v - r;
    }
    return v;
  }

  double _term() {
    var v = _factor();
    while (i < s.length && (s[i] == '×' || s[i] == '÷')) {
      final op = s[i++];
      final r = _factor();
      if (op == '×') {
        v *= r;
      } else {
        if (r == 0) throw const FormatException('division by zero');
        v /= r;
      }
    }
    return v;
  }

  double _factor() {
    var negative = false;
    if (i < s.length && s[i] == '−') {
      negative = true;
      i++;
    }
    final start = i;
    while (i < s.length && ('0123456789.'.contains(s[i]))) {
      i++;
    }
    if (start == i) throw const FormatException('number expected');
    var v = double.parse(s.substring(start, i));
    while (i < s.length && s[i] == '%') {
      v /= 100;
      i++;
    }
    return negative ? -v : v;
  }
}
