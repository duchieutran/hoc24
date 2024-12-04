class PageInfo {
  bool? hasNextPage;
  String? endCursor;

  PageInfo({
    this.hasNextPage,
    this.endCursor,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        hasNextPage: json["hasNextPage"],
        endCursor: json["endCursor"],
      );

  Map<String, dynamic> toJson() => {
        "hasNextPage": hasNextPage,
        "endCursor": endCursor,
      };
}
