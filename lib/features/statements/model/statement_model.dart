class StatementsResponse {
  bool success;
  List<Statement> statements;

  StatementsResponse({
    required this.success,
    required this.statements,
  });

  factory StatementsResponse.fromJson(Map<String, dynamic> json) {
    return StatementsResponse(
      success: json['success'],
      statements: List<Statement>.from(
        json['statements'].map((statement) => Statement.fromJson(statement)),
      ),
    );
  }
}

class Statement {
  int month;
  String monthString;
  String statementRange;
  int year;
  String fileName;
  String link;
  String path;

  Statement({
    required this.month,
    required this.monthString,
    required this.statementRange,
    required this.year,
    required this.fileName,
    required this.link,
    required this.path,
  });

  factory Statement.fromJson(Map<String, dynamic> json) {
    return Statement(
      month: json['month'],
      monthString: json['month_string'],
      statementRange: json['statement_range'],
      year: json['year'],
      fileName: json['file_name'],
      link: json['link'],
      path: json['path'],
    );
  }
}
