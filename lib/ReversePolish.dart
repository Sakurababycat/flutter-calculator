import 'package:stack/stack.dart';

class ReversePolish {
  final String src;
  final dst = Stack<String>();
  ReversePolish(this.src) {
    __reverse();
  }
  void __reverse() {
    final tmp = Stack<String>();
    tmp.push('0');
    dst.push('#');
    const map = {
      '#': 0,
      '(': 0,
      ')': 1,
      '+': 2,
      '-': 2,
      '*': 3,
      '/': 3,
      '%': 4
    };
    var num = '';
    var lastItem = '';
    var item = '';
    for (var i = 0; i < src.length; i++) {
      item = src[i];
      if (map.containsKey(item)) {
        if (num.length != 0 && num != '-') {
          tmp.push(num);
          num = '';
        }

        if (item == '-') {
          num = (num == '-') ? '' : '-';
          if (lastItem != '(') {
            item = '+';
          }
        }

        if (item == '(') {
          dst.push(item);
        } else if (item != '-') {
          while ((map[item] ?? 5) <= (map[dst.top()] ?? 0)) {
            tmp.push(dst.pop());
          }
          if (item != ')') {
            dst.push(item);
          } else if (dst.top() == '(') {
            dst.pop();
          }
        }
      } else if (int.tryParse(item) != null || item == '.') {
        num += item;
      }
      lastItem = item;
    }
    if (num.length != 0) {
      tmp.push(num);
    }
    while (tmp.isNotEmpty) {
      dst.push(tmp.pop());
    }
  }

  num getAns() {
    final tmp = Stack();
    final opr = {
      '+': () => num.parse(tmp.pop()) + num.parse(tmp.pop()),
      '-': () => -num.parse(tmp.pop()) + num.parse(tmp.pop()),
      '*': () => num.parse(tmp.pop()) * num.parse(tmp.pop()),
      '/': () => 1 / double.parse(tmp.pop()) * num.parse(tmp.pop()),
      '%': () => double.parse(tmp.pop()) / 100,
    };
    tmp.push('0');

    while (dst.top() != '#') {
      if (opr.containsKey(dst.top())) {
        tmp.push(opr[dst.pop()]!().toString());
      } else {
        tmp.push(dst.pop());
      }
    }

    return num.parse(tmp.pop());
  }
}
