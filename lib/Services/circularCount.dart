import 'package:cloud_firestore/cloud_firestore.dart';

class CircularCount {
  var educationCircularCount;
  var sportsCircularCount;
  var culturalsCircularCount;
  var otherCircularCount;

  CircularCount(this.educationCircularCount, this.sportsCircularCount,
      this.culturalsCircularCount, this.otherCircularCount);

  static insertcountData() async {
    var eduCount;
    var sportCount;
    var culturalCount;
    var otherCount;
    var temp1, temp2, temp3, temp4;
    temp1 = await FirebaseFirestore.instance.collection("Education").get();
    eduCount = temp1.size;
    temp2 = await FirebaseFirestore.instance.collection("Sports").get();
    sportCount = temp2.size;
    temp3 = await FirebaseFirestore.instance.collection("Culturals").get();
    culturalCount = temp3.size;
    temp4 = await FirebaseFirestore.instance.collection("Other").get();
    otherCount = temp4.size;
    print(eduCount.toString());
    print(sportCount);
    print(culturalCount);
    print(otherCount.toString());
    circularsCount =
        CircularCount(eduCount, sportCount, culturalCount, otherCount);
  }

  static getCount(int index) {
    if (index == 0)
      return circularsCount.educationCircularCount;
    else if (index == 1)
      return circularsCount.sportsCircularCount;
    else if (index == 2)
      return circularsCount.culturalsCircularCount;
    else
      return circularsCount.otherCircularCount;
  }
}

CircularCount circularsCount;
