class Line {
String id = "";
String name = "";
String tube = "";
var disruptions = [];

Line(this.id, this.disruptions, this.name);
factory Line.fromMap(Map<String, dynamic> json) {
return Line(json['id'], json['disruptions'], json['name']);
}

}

class LineStatus {
String type = "";
int id = 0;
int statusSeverity = 0;
String StatusSevrityDescription = "";
var created = DateTime(2001, 01,10);
var ValidityPeriods = List<dynamic>;

LineStatus(this.id, this.statusSeverity, this.created, this.StatusSevrityDescription);
factory LineStatus.fromMap(Map<String, dynamic> json) {
return LineStatus(json['id'], json['StatusSeverity'], json['created'], json['StatusSevrityDescription']);
}
}