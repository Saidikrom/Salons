import 'dart:convert';

SalonsModel salonsModelFromJson(String str) =>
    SalonsModel.fromJson(json.decode(str));

String salonsModelToJson(SalonsModel data) => json.encode(data.toJson());

class SalonsModel {
  final List<Datum> data;
  final Links links;
  final Meta meta;

  SalonsModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory SalonsModel.fromJson(Map<String, dynamic> json) => SalonsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class Datum {
  final int id;
  final String slug;
  final String uuid;
  final bool open;
  final bool visibility;
  final bool verify;
  final int deliveryType;
  final String backgroundImg;
  final String logoImg;
  final Status status;
  final DeliveryTime deliveryTime;
  final LatLong latLong;
  final int minPrice;
  final int maxPrice;
  final int serviceMaxPrice;
  final double distance;
  final int productsCount;
  final Translation translation;
  final List<dynamic> services;
  // final List<ShopWorkingDay> shopWorkingDays;
  final List<dynamic> shopClosedDate;
  final int? rCount;
  final double? rAvg;
  final int? serviceMinPrice;

  Datum({
    required this.id,
    required this.slug,
    required this.uuid,
    required this.open,
    required this.visibility,
    required this.verify,
    required this.deliveryType,
    required this.backgroundImg,
    required this.logoImg,
    required this.status,
    required this.deliveryTime,
    required this.latLong,
    required this.minPrice,
    required this.maxPrice,
    required this.serviceMaxPrice,
    required this.distance,
    required this.productsCount,
    required this.translation,
    required this.services,
    // required this.shopWorkingDays,
    required this.shopClosedDate,
    this.rCount,
    this.rAvg,
    this.serviceMinPrice,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        slug: json["slug"],
        uuid: json["uuid"],
        open: json["open"],
        visibility: json["visibility"],
        verify: json["verify"],
        deliveryType: json["delivery_type"],
        backgroundImg: json["background_img"],
        logoImg: json["logo_img"],
        status: statusValues.map[json["status"]]!,
        deliveryTime: DeliveryTime.fromJson(json["delivery_time"]),
        latLong: LatLong.fromJson(json["lat_long"]),
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        serviceMaxPrice: json["service_max_price"],
        distance: json["distance"]?.toDouble(),
        productsCount: json["products_count"],
        translation: Translation.fromJson(json["translation"]),
        services: List<dynamic>.from(json["services"].map((x) => x)),
        // shopWorkingDays: List<ShopWorkingDay>.from(
        //     json["shop_working_days"].map((x) => ShopWorkingDay.fromJson(x))),
        shopClosedDate:
            List<dynamic>.from(json["shop_closed_date"].map((x) => x)),
        rCount: json["r_count"],
        rAvg: json["r_avg"]?.toDouble(),
        serviceMinPrice: json["service_min_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "uuid": uuid,
        "open": open,
        "visibility": visibility,
        "verify": verify,
        "delivery_type": deliveryType,
        "background_img": backgroundImg,
        "logo_img": logoImg,
        "status": statusValues.reverse[status],
        "delivery_time": deliveryTime.toJson(),
        "lat_long": latLong.toJson(),
        "min_price": minPrice,
        "max_price": maxPrice,
        "service_max_price": serviceMaxPrice,
        "distance": distance,
        "products_count": productsCount,
        "translation": translation.toJson(),
        "services": List<dynamic>.from(services.map((x) => x)),
        // "shop_working_days":
            // List<dynamic>.from(shopWorkingDays.map((x) => x.toJson())),
        "shop_closed_date": List<dynamic>.from(shopClosedDate.map((x) => x)),
        "r_count": rCount,
        "r_avg": rAvg,
        "service_min_price": serviceMinPrice,
      };
}

class DeliveryTime {
  final String to;
  final String from;
  final Type type;

  DeliveryTime({
    required this.to,
    required this.from,
    required this.type,
  });

  factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
        to: json["to"],
        from: json["from"],
        type: typeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "from": from,
        "type": typeValues.reverse[type],
      };
}

enum Type { HOUR, MINUTE }

final typeValues = EnumValues({"hour": Type.HOUR, "minute": Type.MINUTE});

class LatLong {
  final double latitude;
  final double longitude;

  LatLong({
    required this.latitude,
    required this.longitude,
  });

  factory LatLong.fromJson(Map<String, dynamic> json) => LatLong(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class ShopWorkingDay {
  final int id;
  final Day day;
  final From from;
  final To to;
  final bool disabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  ShopWorkingDay({
    required this.id,
    required this.day,
    required this.from,
    required this.to,
    required this.disabled,
    required this.createdAt,
    required this.updatedAt,
  });

  // factory ShopWorkingDay.fromJson(Map<String, dynamic> json) => ShopWorkingDay(
  //       id: json["id"],
  //       day: dayValues.map[json["day"]]!,
  //       from: fromValues.map[json["from"]]!,
  //       to: toValues.map[json["to"]]!,
  //       disabled: json["disabled"],
  //       createdAt: DateTime.parse(json["created_at"]),
  //       updatedAt: DateTime.parse(json["updated_at"]),
  //     );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": dayValues.reverse[day],
        "from": fromValues.reverse[from],
        "to": toValues.reverse[to],
        "disabled": disabled,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Day { FRIDAY, MONDAY, SATURDAY, SUNDAY, THURSDAY, TUESDAY, WEDNESDAY }

final dayValues = EnumValues({
  "friday": Day.FRIDAY,
  "monday": Day.MONDAY,
  "saturday": Day.SATURDAY,
  "sunday": Day.SUNDAY,
  "thursday": Day.THURSDAY,
  "tuesday": Day.TUESDAY,
  "wednesday": Day.WEDNESDAY
});

enum From { THE_0100, THE_0400 }

final fromValues = EnumValues({"01:00": From.THE_0100, "04:00": From.THE_0400});

enum To { THE_2300, THE_2330 }

final toValues = EnumValues({"23:00": To.THE_2300, "23:30": To.THE_2330});

enum Status { APPROVED }

final statusValues = EnumValues({"approved": Status.APPROVED});

class Translation {
  final int id;
  final Locale locale;
  final String title;
  final String description;
  final String address;

  Translation({
    required this.id,
    required this.locale,
    required this.title,
    required this.description,
    required this.address,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        locale: localeValues.map[json["locale"]]!,
        title: json["title"],
        description: json["description"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locale": localeValues.reverse[locale],
        "title": title,
        "description": description,
        "address": address,
      };
}

enum Locale { EN }

final localeValues = EnumValues({"en": Locale.EN});

class Links {
  final String first;
  final String last;
  final dynamic prev;
  final String next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final List<Link> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
