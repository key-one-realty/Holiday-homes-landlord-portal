class PropertyDetailsApiResponse {
  final bool success;
  final String message;
  final PropertyDetailsData data;

  PropertyDetailsApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PropertyDetailsApiResponse.fromJson(Map<String, dynamic> json) {
    return PropertyDetailsApiResponse(
      success: json['success'],
      message: json['message'],
      data: PropertyDetailsData.fromJson(json['data']),
    );
  }
}

class PropertyDetailsData {
  final TransactionDetails transactionDetails;
  final PropertyDetailsScreenBody propertyDetailsScreenBody;
  final PropertyIncome propertyIncome;
  PropertyTrendsReport propertyTrendsReport;
  List<MonthlyBooking> monthlyBooking;

  PropertyDetailsData({
    required this.transactionDetails,
    required this.propertyDetailsScreenBody,
    required this.propertyIncome,
    required this.propertyTrendsReport,
    required this.monthlyBooking,
  });

  factory PropertyDetailsData.fromJson(Map<String, dynamic> json) {
    return PropertyDetailsData(
      transactionDetails:
          TransactionDetails.fromJson(json['transaction_details']),
      propertyDetailsScreenBody:
          PropertyDetailsScreenBody.fromJson(json['property_details']),
      propertyIncome: PropertyIncome.fromJson(json["property_income"]),
      propertyTrendsReport:
          PropertyTrendsReport.fromJson(json['property_trends_report']),
      monthlyBooking: List<MonthlyBooking>.from(
          json['monthly_booking'].map((x) => MonthlyBooking.fromJson(x))),
    );
  }
}

class TransactionDetails {
  final String grossIncome;
  final String upcomingRent;
  final int occupancyRate;
  final int totalNightBooked;
  final int totalBookings;
  final List<BookingDate> bookingDates;
  final List<dynamic> upcomingBookings;

  TransactionDetails({
    required this.grossIncome,
    required this.upcomingRent,
    required this.occupancyRate,
    required this.totalNightBooked,
    required this.totalBookings,
    required this.bookingDates,
    required this.upcomingBookings,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) {
    return TransactionDetails(
      grossIncome: json['gross_income'],
      upcomingRent: json['upcoming_rent'],
      occupancyRate: json['occupancy_rate'],
      totalNightBooked: json['total_night_booked'],
      totalBookings: json['total_bookings'],
      bookingDates: List<BookingDate>.from(
        json['booking_dates'].map((x) {
          return BookingDate.fromJson(x);
        }),
      ),
      upcomingBookings: List<dynamic>.from(json['upcoming_bookings']),
    );
  }
}

class BookingDate {
  final String checkIn;
  final String checkOut;

  BookingDate({
    required this.checkIn,
    required this.checkOut,
  });

  factory BookingDate.fromJson(Map<String, dynamic> json) {
    return BookingDate(
      checkIn: json['check_in'],
      checkOut: json['check_out'],
    );
  }
}

class PropertyDetailsScreenBody {
  final int id;
  final String crmId;
  final String firstbitPropertyId;
  final String firstbitOwnerId;
  final String buildingName;
  final String neighbourhood;
  final String unitNumber;
  final String displayImage;
  final String propertyType;
  final String floorNumber;
  final String numberOfBedroom;
  final String numberOfBathroom;
  final String createdAt;
  final String updatedAt;

  PropertyDetailsScreenBody({
    required this.id,
    required this.crmId,
    required this.firstbitPropertyId,
    required this.firstbitOwnerId,
    required this.buildingName,
    required this.neighbourhood,
    required this.unitNumber,
    required this.displayImage,
    required this.propertyType,
    required this.floorNumber,
    required this.numberOfBedroom,
    required this.numberOfBathroom,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PropertyDetailsScreenBody.fromJson(Map<String, dynamic> json) {
    return PropertyDetailsScreenBody(
      id: json['id'],
      crmId: json['crm_id'],
      firstbitPropertyId: json['firstbit_property_id'],
      firstbitOwnerId: json['firstbit_owner_id'],
      buildingName: json['building_name'],
      neighbourhood: json['neighbourhood'],
      unitNumber: json['unit_number'],
      displayImage: json['display_image'],
      propertyType: json['property_type'],
      floorNumber: json['floor_number'],
      numberOfBedroom: json['number_of_bedroom'],
      numberOfBathroom: json['number_of_bathroom'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class PropertyIncome {
  final List<IncomeItem> propertyIncome;

  PropertyIncome({required this.propertyIncome});

  factory PropertyIncome.fromJson(List<dynamic> json) {
    final List<IncomeItem> incomeItems = List<IncomeItem>.from(
      json.map((x) => IncomeItem.fromJson(x)),
    );
    return PropertyIncome(propertyIncome: incomeItems);
  }
}

class IncomeItem {
  final String income;
  final int month;
  final int year;
  final String monthString;

  IncomeItem({
    required this.income,
    required this.month,
    required this.year,
    required this.monthString,
  });

  factory IncomeItem.fromJson(Map<String, dynamic> json) {
    return IncomeItem(
      income: json['income'],
      month: json['month'],
      year: json['year'],
      monthString: json['month_string'],
    );
  }
}

class PropertyTrendsReport {
  GrossIncomeTrend grossIncomeTrend;
  OccupanyRateTrend occupanyRateTrend;
  TotalBookingTrend totalBookingTrend;

  PropertyTrendsReport({
    required this.grossIncomeTrend,
    required this.occupanyRateTrend,
    required this.totalBookingTrend,
  });

  factory PropertyTrendsReport.fromJson(Map<String, dynamic> json) {
    return PropertyTrendsReport(
      grossIncomeTrend: GrossIncomeTrend.fromJson(json['gross_income_trend']),
      occupanyRateTrend:
          OccupanyRateTrend.fromJson(json['occupany_rate_trend']),
      totalBookingTrend:
          TotalBookingTrend.fromJson(json['total_booking_trend']),
    );
  }
}

class GrossIncomeTrend {
  int trendChange;
  String trendDirection;

  GrossIncomeTrend({
    required this.trendChange,
    required this.trendDirection,
  });

  factory GrossIncomeTrend.fromJson(Map<String, dynamic> json) {
    return GrossIncomeTrend(
      trendChange: json['trend_change'],
      trendDirection: json['trend_direction'],
    );
  }
}

class OccupanyRateTrend {
  int trendChange;
  String trendDirection;

  OccupanyRateTrend({
    required this.trendChange,
    required this.trendDirection,
  });

  factory OccupanyRateTrend.fromJson(Map<String, dynamic> json) {
    return OccupanyRateTrend(
      trendChange: json['trend_change'],
      trendDirection: json['trend_direction'],
    );
  }
}

class TotalBookingTrend {
  int trendChange;
  String trendDirection;

  TotalBookingTrend({
    required this.trendChange,
    required this.trendDirection,
  });

  factory TotalBookingTrend.fromJson(Map<String, dynamic> json) {
    return TotalBookingTrend(
      trendChange: json['trend_change'],
      trendDirection: json['trend_direction'],
    );
  }
}

class MonthlyBooking {
  String bookingClientName;
  String bookingPlatform;
  String bookingNightQty;
  String bookingRentalAmount;
  String bookingDate;

  MonthlyBooking({
    required this.bookingClientName,
    required this.bookingPlatform,
    required this.bookingNightQty,
    required this.bookingRentalAmount,
    required this.bookingDate,
  });

  factory MonthlyBooking.fromJson(Map<String, dynamic> json) {
    return MonthlyBooking(
      bookingClientName: json['booking_client_name'],
      bookingPlatform: json['booking_platform'],
      bookingNightQty: json['booking_night_qty'],
      bookingRentalAmount: json['booking_rental_amount'],
      bookingDate: json['booking_date'],
    );
  }
}
