classAreaModel {
int? id;
String? name;

AreaModel({
this.id,
this.name,
  });

factoryAreaModel.fromJson(Map<String, dynamic>json) {
returnAreaModel(
id: json["id"] asint,
name: json["name"] asString,
    );
  }

Map<String, dynamic>toJson() {
return {
'id': id,
'name': name,
    };
  }

staticList<AreaModel>getAllArea() {
return [
AreaModel(
id: 1,
name: "JABODETABEKSER",
      ),
AreaModel(
id: 2,
name: "JAWA BARAT",
      ),
AreaModel(
id: 3,
name: "JAWA TENGAH",
      ),
AreaModel(
id: 4,
name: "JAWA TIMUR",
      ),
AreaModel(
id: 5,
name: "JAWA KALIMANTAN",
      ),
AreaModel(
id: 6,
name: "SULAWESI",
      ),
AreaModel(
id: 7,
name: "SUMATERA",
      ),
    ];
  }
}
