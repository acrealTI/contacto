class Persona {
  // Los atributos cuando llevan "_" se declaran como privados, la unica forma
  // de acceder es mediante Getters o Setters.
  String _nombre, _apellidos, _telefono;

  Persona({String nombre="", apellidos="", telefono=""}){
    this._nombre = nombre;
    this._apellidos = apellidos;
    this._telefono = telefono;
  }

  get telefono => _telefono;

  get apellidos => _apellidos;

  String get nombre => _nombre;
}
