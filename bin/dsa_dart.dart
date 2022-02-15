import 'dart:isolate';

import 'package:dsa_dart/linked_list.dart';
import 'package:dsa_dart/queue.dart';
import 'package:dsa_dart/stack.dart';
import 'dart:math' as math;
import 'package:async/async.dart';
import 'package:test/test.dart';


var list = List<int>.generate(400000000, (index) {
  return math.Random().nextInt(2000000) - 1000000;
});

void main(List<String> arguments) async {
  var start = DateTime.now();
  var value = getValueClosestZeroLinearTime(list.length, list);
  var end = DateTime.now();

  var linearTimeDiff = end.difference(start);
  print('Main thread output: $value');
  var nLogrithmicTimeDiff = await runningFirstAlgo();
  // var quadraticTimeDiff = await runningSecondAlgo();

  print('Linear Time of algo: ${linearTimeDiff.toString()}');
  print('N-Logarithmic Time of algo: ${nLogrithmicTimeDiff.toString()}');
  // print('Quadratic Time of algo: ${quadraticTimeDiff.toString()}');

  // print('Array: ${list.toString()}');
}

Future<Duration> runningFirstAlgo() async {
  final p = ReceivePort();
  await Isolate.spawn(_runAlgoOne, p.sendPort);
  return await p.first;
}

Future<Duration> runningSecondAlgo() async {
  final p = ReceivePort();
  await Isolate.spawn(_runAlgoTwo, p.sendPort);
  return await p.first;
}


Future _runAlgoOne(SendPort p) async {
  final start = DateTime.now();
  final value = getValueClosestZeroNLogrithmicTime(list.length, list);
  final end = DateTime.now();
  print('first isolate output: $value');
  Isolate.exit(p, end.difference(start));
}

Future _runAlgoTwo(SendPort p) async {
  final start = DateTime.now();
  final value = getValueClosestZeroQuadraticTime(list.length, list);
  final end = DateTime.now();
  print('Second isolate output: $value');
  Isolate.exit(p, end.difference(start));
}

int getValueClosestZeroNLogrithmicTime(int length, List<int> array) {
  var result;
  for(var i = 0; i < length /2; i++) {
    var first = array[i].abs();
    var second = array[length - i -1].abs();
    if (first < second && first < (result ?? length)) {
      result = first;
    } else if (second < first && second < (result ?? length)) {
      result = second;
    }
  }
  return result ?? throwsException;
}

int getValueClosestZeroLinearTime(int length, List<int> array) {
  var result;
  for(var i = 0; i < length; i++) {
    if (array[i].abs() < (result ?? length)) {
      result = array[i].abs();
    }
  }
  return result ?? throwsException;
}

int getValueClosestZeroQuadraticTime(int length, List<int> array) {
  var result;
  for(var i  = 0; i < length /2; i++) {
    for (var j =0; j < length / 2; j++) {
      if (array[j].abs() < result) {
        result = array[j].abs();
      }
    }
  }
  // for (var i = 0; i < length / 2; i++) {
  //   for (var j = length~/2; j< length; j++) {
  //     if (array[i].abs() < array[j].abs() && array[i].abs() < (result ?? length)) {
  //       result = array[i].abs();
  //     } else if (array[j].abs() < array[i].abs() && array[j].abs() < (result ??  length)){
  //       result = array[j].abs();
  //     }
  //   }
  // }
  return result ?? throwsException;
}



// void main(List<String> arguments) {
//   // print(list);
//   // list.reverse();
//   // print(list);
//
//   var raySolutionTime = [];
//   var mySolutionTime = [];
//
//   for (var i = 0; i<5; i++) {
//     final list = LinkedList<int>();
//     list.append(1);
//     list.append(2);
//     list.append(3);
//     list.append(3);
//     list.append(5);
//     list.append(3);
//     list.append(5);
//     final start = DateTime.now();
//     list.removeAll(3);
//     final end = DateTime.now();
//     raySolutionTime.add(end.difference(start).inMicroseconds);
//     print(list);
//   }
//
//   for (var i = 0; i<5; i++) {
//     final list = LinkedList<int>();
//     list.append(1);
//     list.append(2);
//     list.append(3);
//     list.append(3);
//     list.append(5);
//     list.append(3);
//     list.append(5);
//     final start = DateTime.now();
//     list.removeAllOccurrences(3);
//     final end = DateTime.now();
//     mySolutionTime.add(end.difference(start).inMicroseconds);
//     print(list);
//   }
//
//   print('RayWenderlich time: ${raySolutionTime.toString()}');
//   print('My time: ${mySolutionTime.toString()}');
// }



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

// stack challenges
bool balanceTheParentheses(String string) {
  final parenthesesStack = Stack();
  final open = '('.codeUnitAt(0);
  final close = ')'.codeUnitAt(0);

  for (var codeUnit in string.codeUnits) {
    if (codeUnit == open) {
      parenthesesStack.push(codeUnit);
    } else if (codeUnit == close) {
      if (parenthesesStack.isEmpty) {
        return false;
      } else {
        parenthesesStack.pop();
      }
    }
  }
  return parenthesesStack.isEmpty;
}

void reverseList(List list) {
  final start = DateTime.now();
  final stack = Stack.of(list);
  for (final item in list) {
    print(stack.pop());
  }
  final end = DateTime.now();
  final change = end.difference(start);
  print('Time taken: ${change.inMilliseconds} millisecs');
}
