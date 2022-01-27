import 'dart:collection';
import 'package:dsa_dart/dsa_dart.dart' as dsa_dart;
import 'package:dsa_dart/stack.dart';

void main(List<String> arguments) {
  const list = ['S', 'M', 'O', 'K', 'E'];
  reverseList(list);
  // final stack = Stack<int>();
  // stack.push(1);
  // stack.push(2);
  // stack.push(3);
  // stack.push(4);

}

void reverseList(List list){
  final start = DateTime.now();
  final stack = Stack.of(list);
  for(final item in list ){
    print(stack.pop());
  }
  final end = DateTime.now();
  final change = end.difference(start);
  print('Time taken: ${change.inMilliseconds} millisecs');
}