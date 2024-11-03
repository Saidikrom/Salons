class PlaceDetailsModel {
  PlaceDetailsModel({
    required this.htmlAttributions,
    required this.result,
    required this.status,
  });

  final List<dynamic> htmlAttributions;
  final Result? result;
  final String? status;

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
      htmlAttributions: json["html_attributions"] == null
          ? []
          : List<dynamic>.from(json["html_attributions"]!.map((x) => x)),
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions.map((x) => x).toList(),
        "result": result?.toJson(),
        "status": status,
      };
}

class Result {
  Result({
    required this.addressComponents,
    required this.adrAddress,
    required this.formattedAddress,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.photos,
    required this.placeId,
    required this.reference,
    required this.types,
    required this.url,
    required this.utcOffset,
    required this.vicinity,
  });

  final List<AddressComponent> addressComponents;
  final String? adrAddress;
  final String? formattedAddress;
  final Geometry? geometry;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String? name;
  final List<Photo> photos;
  final String? placeId;
  final String? reference;
  final List<String> types;
  final String? url;
  final num? utcOffset;
  final String? vicinity;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      addressComponents: json["address_components"] == null
          ? []
          : List<AddressComponent>.from(json["address_components"]!
              .map((x) => AddressComponent.fromJson(x))),
      adrAddress: json["adr_address"],
      formattedAddress: json["formatted_address"],
      geometry:
          json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
      icon: json["icon"],
      iconBackgroundColor: json["icon_background_color"],
      iconMaskBaseUri: json["icon_mask_base_uri"],
      name: json["name"],
      photos: json["photos"] == null
          ? []
          : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
      placeId: json["place_id"],
      reference: json["reference"],
      types: json["types"] == null
          ? []
          : List<String>.from(json["types"]!.map((x) => x)),
      url: json["url"],
      utcOffset: json["utc_offset"],
      vicinity: json["vicinity"],
    );
  }

  Map<String, dynamic> toJson() => {
        "address_components":
            addressComponents.map((x) => x.toJson()).toList(),
        "adr_address": adrAddress,
        "formatted_address": formattedAddress,
        "geometry": geometry?.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "photos": photos.map((x) => x.toJson()).toList(),
        "place_id": placeId,
        "reference": reference,
        "types": types.map((x) => x).toList(),
        "url": url,
        "utc_offset": utcOffset,
        "vicinity": vicinity,
      };
}

class AddressComponent {
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  final String? longName;
  final String? shortName;
  final List<String> types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json["long_name"],
      shortName: json["short_name"],
      types: json["types"] == null
          ? []
          : List<String>.from(json["types"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": types.map((x) => x).toList(),
      };
}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  final Location? location;
  final Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      viewport:
          json["viewport"] == null ? null : Viewport.fromJson(json["viewport"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "viewport": viewport?.toJson(),
      };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  final num? lat;
  final num? lng;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json["lat"],
      lng: json["lng"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });

  final Location? northeast;
  final Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: json["northeast"] == null
          ? null
          : Location.fromJson(json["northeast"]),
      southwest: json["southwest"] == null
          ? null
          : Location.fromJson(json["southwest"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "northeast": northeast?.toJson(),
        "southwest": southwest?.toJson(),
      };
}

class Photo {
  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  final num? height;
  final List<String> htmlAttributions;
  final String? photoReference;
  final int? width;

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      height: json["height"],
      htmlAttributions: json["html_attributions"] == null
          ? []
          : List<String>.from(json["html_attributions"]!.map((x) => x)),
      photoReference: json["photo_reference"],
      width: json["width"],
    );
  }

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": htmlAttributions.map((x) => x).toList(),
        "photo_reference": photoReference,
        "width": width,
      };
}
