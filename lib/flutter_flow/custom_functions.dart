bool getAppointmentPaidInfo(dynamic paidamount) {
  if (paidamount == "") {
    return true;
  } else {
    return false;
  }
}

String getAppointmentStatusInfo(int appointmentStatus) {
  if (appointmentStatus == 0) {
    return "Pending";
  } else {
    return "Completed";
  }
}

String formatDate(String dateTime) {
  String date = dateTime.split('T').first;
  List<String> dateComponent = date.split('-');

  Map<String, String> months = {
    '01': 'Jan',
    '02': 'Feb',
    '03': 'Mar',
    '04': 'Apr',
    '05': 'May',
    '06': 'Jun',
    '07': 'Jul',
    '08': 'Aug',
    '09': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec',
  };

  String day = dateComponent[2];
  String month = dateComponent[1];
  String year = dateComponent[0];

  return ' $day-$month-$year';
}

List<dynamic> generateBusinessCard(
  List<dynamic> businessCard,
  List<dynamic> group,
) {
  List businessCardList = [];

  for (int i = 0; i < group.length; i++) {
    List sortCard = [];
    for (var card in businessCard) {
      if (card['group_name'] == group[i]['name']) {
        sortCard.add(card);
      }
    }
    Map data = {"name": group[i]['name'], 'data': sortCard};
    businessCardList.add(data);
  }

  return businessCardList;
}

String getAppointmentFormatedTime(
  String fromTime,
  String toTime,
) {
  String from = fromTime.split(" ").first;
  String to = toTime.split(" ").first;
  int toHour = int.parse(to.split(":").first);

  if (toHour <= 12) {
    return "$from - $to AM";
  } else {
    return "$from - $to PM";
  }
}

List<double> generateChartList(List<String> income) {
  // create function for convert List<String> to List<double> and return that double List
  List<double> chartList = [];
  for (String value in income) {
    chartList.add((double.parse(value) != 0) ? double.parse(value) : 0);
  }
  return chartList;
}

List<String> generateMonthList() {
  return ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
}

List<dynamic> generateBusinessGroupList(List<dynamic> groupList) {
  List groups = ['All'];

  for (var group in groupList) {
    groups.add(group['name']);
  }

  return groups;
}

List<dynamic> generateVcardGroupList(List<dynamic> groupList) {
  List groups = ['Thông Tin', 'Mẫu Danh Thiếp', 'Mạng Xã Hội'];

  for (var group in groupList) {
    groups.add(group['name']);
  }

  return groups;
}

List<dynamic> sortListData(List<dynamic> data) {
  return data.reversed.toList();
}

int decreaseIndex(int id) {
  return id - 1;
}

bool textFieldValidator(String value) {
  if (value.trim() == '') {
    return false;
  } else {
    return true;
  }
}

List<dynamic> enquiryListSort(List<dynamic> data) {
  data.sort((a, b) => b['id'].compareTo(a['id']));

  return data;
}

bool isGroupNameValid(
  List<dynamic> data,
  String groupName,
) {
  for (var data in data) {
    String name = data['name'];
    if (name == groupName) {
      return false;
    }
  }
  return true;
}

bool businessCardValidator(
  List<dynamic> data,
  String url,
  List<dynamic> group,
) {
  // for (var card in data) {
  //   if (card['url'] == url) {
  //     for (var grp in group) {
  //       if (grp['name'] == card['group_name']) {
  //         return false;
  //       }
  //     }
  //     // return false;
  //   }
  // }

  for (var card in data) {
    if (card['url'] == url) {
      return false;
    }
  }

  return true;
}
