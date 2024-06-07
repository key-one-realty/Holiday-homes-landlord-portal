class LandlordDashboardResponse {
  bool success;
  MonthlyFacts monthlyFacts;
  LandlordTrendsReport landlordTrendsReport;
  List<MonthlyIncome> monthlyIncome;
  double totalRecentPayout;

  LandlordDashboardResponse({
    required this.success,
    required this.monthlyFacts,
    required this.landlordTrendsReport,
    required this.monthlyIncome,
    required this.totalRecentPayout,
  });

  factory LandlordDashboardResponse.fromJson(Map<String, dynamic> json) {
    return LandlordDashboardResponse(
      success: json['success'],
      monthlyFacts: MonthlyFacts.fromJson(json['monthly_facts']),
      landlordTrendsReport:
          LandlordTrendsReport.fromJson(json['landlord_trends_report']),
      monthlyIncome: List<MonthlyIncome>.from(
          json['monthly_income'].map((x) => MonthlyIncome.fromJson(x))),
      totalRecentPayout: json['total_recent_payout'].toDouble(),
    );
  }
}

class MonthlyFacts {
  double totalPayout;
  double totalNetRental;
  int avgOccupancyRate;
  int avgNightsBooked;

  MonthlyFacts({
    required this.totalPayout,
    required this.totalNetRental,
    required this.avgOccupancyRate,
    required this.avgNightsBooked,
  });

  factory MonthlyFacts.fromJson(Map<String, dynamic> json) {
    return MonthlyFacts(
      totalPayout: json['total_payout'].toDouble(),
      totalNetRental: json['total_net_rental'].toDouble(),
      avgOccupancyRate: json['avg_occupancy_rate'],
      avgNightsBooked: json['avg_nights_booked'],
    );
  }
}

class LandlordTrendsReport {
  TrendData totalPayoutTrend;
  TrendData totalNetRentalTrend;
  TrendData avgOccupancyRateTrend;
  TrendData avgNightsBookedTrend;

  LandlordTrendsReport({
    required this.totalPayoutTrend,
    required this.totalNetRentalTrend,
    required this.avgOccupancyRateTrend,
    required this.avgNightsBookedTrend,
  });

  factory LandlordTrendsReport.fromJson(Map<String, dynamic> json) {
    return LandlordTrendsReport(
      totalPayoutTrend: TrendData.fromJson(json['total_payout_trend']),
      totalNetRentalTrend: TrendData.fromJson(json['total_net_rental_trend']),
      avgOccupancyRateTrend:
          TrendData.fromJson(json['avg_occupancy_rate_trend']),
      avgNightsBookedTrend: TrendData.fromJson(json['avg_nights_booked_trend']),
    );
  }
}

class TrendData {
  int trendChange;
  String trendDirection;

  TrendData({
    required this.trendChange,
    required this.trendDirection,
  });

  factory TrendData.fromJson(Map<String, dynamic> json) {
    return TrendData(
      trendChange: json['trend_change'],
      trendDirection: json['trend_direction'],
    );
  }
}

class MonthlyIncome {
  String income;
  int month;
  int year;
  String monthString;

  MonthlyIncome({
    required this.income,
    required this.month,
    required this.year,
    required this.monthString,
  });

  factory MonthlyIncome.fromJson(Map<String, dynamic> json) {
    return MonthlyIncome(
      income: json['income'],
      month: json['month'],
      year: json['year'],
      monthString: json['month_string'],
    );
  }
}
