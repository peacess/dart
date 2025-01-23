typedef IntList = List<int>;

void generic() {
  IntList d = [1];
  if (d is IntList) {
    print(d);
  }
}
