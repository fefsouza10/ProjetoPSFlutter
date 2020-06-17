

class UFInfo {
  int uid;
  String uf;
  String state;
  int cases;
  int deaths;
  int suspects;
  int refuses;
  bool broadcast;
  String comments;
  String datetime;

  UFInfo(
      {this.uid,
        this.uf,
        this.state,
        this.cases,
        this.deaths,
        this.suspects,
        this.refuses,
        this.broadcast,
        this.comments,
        this.datetime});

  UFInfo.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    uf = json['uf'];
    state = json['state'];
    cases = json['cases'];
    deaths = json['deaths'];
    suspects = json['suspects'];
    refuses = json['refuses'];
    broadcast = json['broadcast'];
    comments = json['comments'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['uf'] = this.uf;
    data['state'] = this.state;
    data['cases'] = this.cases;
    data['deaths'] = this.deaths;
    data['suspects'] = this.suspects;
    data['refuses'] = this.refuses;
    data['broadcast'] = this.broadcast;
    data['comments'] = this.comments;
    data['datetime'] = this.datetime;
    return data;
  }
}
