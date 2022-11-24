import 'package:flutter/material.dart';

class Usuario{
  var _uid;
  var _name;
  var _email;
  var _password;
  var _genre;
  var _favoritesLugares;
  var _bornDate;

  Usuario(this._uid,this._name, this._email, this._password, this._genre,
      this._favoritesLugares, this._bornDate);

  Usuario.Empty();

  get uid => _uid;

  set uid(value) {
    _uid = value;
  }

  Usuario.fromJson(Map<String, dynamic> json)
      : _uid = json['uid'],
        _name = json["name"],
        _email = json["email"],
        _password = json["password"],
        _genre = json["genre"],
        _favoritesLugares = json["favoritesLugares"],
        _bornDate = json["bornDate"];

  Map<String, dynamic> ToJson() => {
    'uid': _uid,
    "name" : _name,
    "email" : _email,
    "password" : _password,
    "genre" : _genre,
    "favoritesGenres" : _favoritesLugares,
    "bornDate" : _bornDate
  };

  get name => _name;

  set name(value) {
    _name = value;
  }

  get email => _email;

  get bornDate => _bornDate;

  set bornDate(value) {
    _bornDate = value;
  }

  get favoritesLugares => _favoritesLugares;

  set favoritesLugares(value) {
    _favoritesLugares = value;
  }

  get genre => _genre;

  set genre(value) {
    _genre = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  set email(value) {
    _email = value;
  }
}

