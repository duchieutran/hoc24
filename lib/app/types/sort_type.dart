enum SortType { sweek, smonth, summAll }

extension SortItem on SortType {
  String get name {
    switch (this) {
      case SortType.sweek:
        return "Tuần";
      case SortType.smonth:
        return "Tháng";
      case SortType.summAll:
        return "Năm";
    }
  }

  String get query {
    switch (this) {
      case SortType.sweek:
        return "sweek";
      case SortType.smonth:
        return "smonth";
      case SortType.summAll:
        return "sum_all";
    }
  }
}
