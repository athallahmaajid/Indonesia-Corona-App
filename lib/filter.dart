// TODO : bikin filter biar nampak rapi di display nya
String filterNumber(int number){
  List<String> reversed = number.toString().split('').reversed.toList();
  var limiter = 0;
  var counter = 0;
  for (var i = 0; i < reversed.length; i++) {
    print(reversed);
    if (limiter == 3){
      if (reversed.length < 6) {
        reversed.insert(i, ',');
        counter++;
        limiter = 0;
      } else if (reversed[i+counter-1] != reversed.last) {
        reversed.insert(i+counter, ',');
        counter++;
        limiter = 0;
      }
    }
    limiter++;
  }
  return reversed.reversed.toList().join();
}
