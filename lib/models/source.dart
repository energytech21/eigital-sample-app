
class Source {
  final String? id;
  final String? name;

  Source(this.id, this.name);

  factory Source.fromJson(Map<String,dynamic> json){
    return Source(json['id'], json['name']);
  }

  Map<String,dynamic> toJson() => { 'id': this.id, 'name': this.name };
}