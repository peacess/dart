typedef IntList = List<int>;

void generic() {
  IntList d = [1];
  // ignore: unnecessary_type_check
  if (d is IntList) {
    print(d);
  }
}
