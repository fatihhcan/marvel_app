// To parse this JSON data, do
//
//     final charactersModel = charactersModelFromJson(jsonString);

import 'dart:convert';

CharactersModel charactersModelFromJson(String str) => CharactersModel.fromJson(json.decode(str));

String charactersModelToJson(CharactersModel data) => json.encode(data.toJson());

class CharactersModel {
    CharactersModel({
        this.id,
        this.name,
        this.description,
        this.modified,
        this.thumbnail,
        this.resourceUri,
        this.comics,
        this.series,
        this.stories,
        this.events,
        this.urls,
    });

    int? id;
    String? name;
    String? description;
    String? modified;
    Thumbnail? thumbnail;
    String? resourceUri;
    Comics? comics;
    Comics? series;
    Stories? stories;
    Comics? events;
    List<Url>? urls;

    factory CharactersModel.fromJson(Map<String, dynamic> json) => CharactersModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        modified: json["modified"] == null ? null : json["modified"],
        thumbnail: json["thumbnail"] == null ? null : Thumbnail.fromJson(json["thumbnail"]),
        resourceUri: json["resourceURI"] == null ? null : json["resourceURI"],
        comics: json["comics"] == null ? null : Comics.fromJson(json["comics"]),
        series: json["series"] == null ? null : Comics.fromJson(json["series"]),
        stories: json["stories"] == null ? null : Stories.fromJson(json["stories"]),
        events: json["events"] == null ? null : Comics.fromJson(json["events"]),
        urls: json["urls"] == null ? null : List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "modified": modified == null ? null : modified,
        "thumbnail": thumbnail == null ? null : thumbnail!.toJson(),
        "resourceURI": resourceUri == null ? null : resourceUri,
        "comics": comics == null ? null : comics!.toJson(),
        "series": series == null ? null : series!.toJson(),
        "stories": stories == null ? null : stories!.toJson(),
        "events": events == null ? null : events!.toJson(),
        "urls": urls == null ? null : List<dynamic>.from(urls!.map((x) => x.toJson())),
    };
}

class Comics {
    Comics({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    int? available;
    String? collectionUri;
    List<ComicsItem>? items;
    int? returned;

    factory Comics.fromJson(Map<String, dynamic> json) => Comics(
        available: json["available"] == null ? null : json["available"],
        collectionUri: json["collectionURI"] == null ? null : json["collectionURI"],
        items: json["items"] == null ? null : List<ComicsItem>.from(json["items"].map((x) => ComicsItem.fromJson(x))),
        returned: json["returned"] == null ? null : json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available == null ? null : available,
        "collectionURI": collectionUri == null ? null : collectionUri,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
        "returned": returned == null ? null : returned,
    };
}

class ComicsItem {
    ComicsItem({
        this.resourceUri,
        this.name,
    });

    String? resourceUri;
    String? name;

    factory ComicsItem.fromJson(Map<String, dynamic> json) => ComicsItem(
        resourceUri: json["resourceURI"] == null ? null : json["resourceURI"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri == null ? null : resourceUri,
        "name": name == null ? null : name,
    };
}

class Stories {
    Stories({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    int? available;
    String? collectionUri;
    List<StoriesItem>? items;
    int? returned;

    factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        available: json["available"] == null ? null : json["available"],
        collectionUri: json["collectionURI"] == null ? null : json["collectionURI"],
        items: json["items"] == null ? null : List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromJson(x))),
        returned: json["returned"] == null ? null : json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available == null ? null : available,
        "collectionURI": collectionUri == null ? null : collectionUri,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
        "returned": returned == null ? null : returned,
    };
}

class StoriesItem {
    StoriesItem({
        this.resourceUri,
        this.name,
        this.type,
    });

    String? resourceUri;
    String? name;
    Type? type;

    factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json["resourceURI"] == null ? null : json["resourceURI"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri == null ? null : resourceUri,
        "name": name == null ? null : name,
        "type": type == null ? null : typeValues.reverse[type],
    };
}

enum Type { COVER, INTERIOR_STORY, RECAP }

final typeValues = EnumValues({
    "cover": Type.COVER,
    "interiorStory": Type.INTERIOR_STORY,
    "recap": Type.RECAP
});

class Thumbnail {
    Thumbnail({
        this.path,
        this.extension,
    });

    String? path;
    String? extension;

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"] == null ? null : json["path"],
        extension: json["extension"] == null ? null : json["extension"],
    );

    Map<String, dynamic> toJson() => {
        "path": path == null ? null : path,
        "extension": extension == null ? null : extension,
    };
}

class Url {
    Url({
        this.type,
        this.url,
    });

    String? type;
    String? url;

    factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "url": url == null ? null : url,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
