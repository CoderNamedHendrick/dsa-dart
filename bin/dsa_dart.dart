import 'package:dsa_dart/dsa_dart.dart' as dsa_dart;

void main(List<String> arguments) {
  final start = DateTime.now();
  final sum = sumFromOneTo(10000);
  final end = DateTime.now();
  final time = end.difference(start);
  print(sum);
  print(time);
}

int sumFromOneTo(int n) {
  var sum = 0;
  for(var i =1; i<= n; i++) {
    sum += i;
  }
  return sum;
}
