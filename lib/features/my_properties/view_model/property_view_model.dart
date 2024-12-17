class PropertyApiResponse {
  final bool success;
  final PropertyApiData data;

  PropertyApiResponse({required this.success, required this.data});

  factory PropertyApiResponse.fromJson(Map<String, dynamic> json) {
    return PropertyApiResponse(
      success: json['success'],
      data: PropertyApiData.fromJson(json['data']),
    );
  }
}

class PropertyApiData {
  final List<Project> projects;
  final List<PropertyDetailsBody> propertyDetailsBody;

  PropertyApiData({required this.projects, required this.propertyDetailsBody});

  factory PropertyApiData.fromJson(Map<String, dynamic> json) {
    return PropertyApiData(
      projects:
          List<Project>.from(json['projects'].map((x) => Project.fromJson(x))),
      propertyDetailsBody: List<PropertyDetailsBody>.from(
          json['property_details'].map((x) => PropertyDetailsBody.fromJson(x))),
    );
  }
}

class Project {
  final String ownerProjectId;
  final String ownerProjectName;
  final int ownerProjectCommision;

  Project({
    required this.ownerProjectId,
    required this.ownerProjectName,
    required this.ownerProjectCommision,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      ownerProjectId: json['Owner_project_id'],
      ownerProjectName: json['Owner_project_name'],
      ownerProjectCommision: json['Owner_project_commision'],
    );
  }
}

class PropertyDetailsBody {
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

  PropertyDetailsBody({
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

  factory PropertyDetailsBody.fromJson(Map<String, dynamic> json) {
    return PropertyDetailsBody(
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
