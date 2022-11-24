class Sitios {
  var _id;
  var _name;
  var _location;
  var _description;
  var _rating;
  var _genre;

  Sitios(this._id, this._name, this._location, this._description, this._rating,
      this._genre);

  Map<String, dynamic> toJson() => {
    'id': _id,
    'name': _name,
    'localizacion': _location,
    'description': _description,
    'rating': _rating,
    'genre': _genre
  };

  Sitios.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _location = json['localizacion'],
        _description = json['Descripción'],
        _rating = json['rating'],
        _genre = json['genre'];

  get id => _id;

  set id(value) {
    _id = value;
  }

  get genre => _genre;

  set genre(value) {
    _genre = value;
  }

  get rating => _rating;

  set rating(value) {
    _rating = value;
  }

  get description => _description;

  set description(value) {
    _description = value;
  }

  get location => _location;

  set location(value) {
    _location = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }
}

