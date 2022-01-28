import 'package:dsa_dart/linked_list.dart';
import 'package:dsa_dart/stack.dart';

void main(List<String> arguments) {
  final list = LinkedList<int>();
  list.append(1);
  list.append(2);
  list.append(3);

  print('Before: $list');

  final firstNode = list.nodeAt(0)!;
  var removedValue = list.removeAfter(firstNode);

  print('After: $list');
  print('Popped value: $removedValue');
}

// void main(List<String> arguments) {
//   const list = ['S', 'M', 'O', 'K', 'E'];K
//   final string = 'h((e))llo(world)()';
//   print(balanceTheParentheses(string));
//   // final stack = Stack<int>();
//   // stack.push(1);
//   // stack.push(2);
//   // stack.push(3);
//   // stack.push(4);
//
// }
//
// bool balanceTheParentheses(String string) {
//   final parenthesesStack = Stack();
//   final open = '('.codeUnitAt(0);
//   final close = ')'.codeUnitAt(0);
//
//   for(var codeUnit in string.codeUnits) {
//
//     if (codeUnit == open) {
//       parenthesesStack.push(codeUnit);
//     } else if (codeUnit == close) {
//       if (parenthesesStack.isEmpty){
//         return false;
//       } else {
//         parenthesesStack.pop();
//       }
//     }
//   }
//   return parenthesesStack.isEmpty;
// }
//
// void reverseList(List list){
//   final start = DateTime.now();
//   final stack = Stack.of(list);
//   for(final item in list ){
//     print(stack.pop());
//   }
//   final end = DateTime.now();
//   final change = end.difference(start);
//   print('Time taken: ${change.inMilliseconds} millisecs');
// }