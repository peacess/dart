import 'package:test/test.dart';

void main() {
  test("", () {
    //使用时间戳创建datetime时，再次取出时间戳时，与最开始创建时的值相等， 就算进行各种变量也是相
    var t1 = DateTime.fromMillisecondsSinceEpoch(1000, isUtc: true);
    var t2 = DateTime.fromMillisecondsSinceEpoch(1000, isUtc: false);
    expect(0, equals(t1.compareTo(t2)));
    expect(t1.millisecondsSinceEpoch, equals(t2.millisecondsSinceEpoch));
    expect(t1.toUtc().millisecondsSinceEpoch, equals(t2.toUtc().millisecondsSinceEpoch));
    expect(t1.toLocal().millisecondsSinceEpoch, equals(t2.toLocal().millisecondsSinceEpoch));
    //把 utc时间转换为 local
    var t3 = DateTime(t1.year, t1.month, t1.day, t1.hour, t1.minute, t1.second, t1.millisecond, t1.microsecond);
    expect(t1.millisecondsSinceEpoch, isNot(equals(t3.millisecondsSinceEpoch)));
    //不要使用这种转换，它的时间戳还是原来的没有变华
    var tError = t1.toLocal();
    expect(t1.millisecondsSinceEpoch, tError.millisecondsSinceEpoch);
  });
}
