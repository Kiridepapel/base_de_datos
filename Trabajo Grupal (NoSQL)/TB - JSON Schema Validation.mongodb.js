// Json Schema Validation: usuario
use("wolex");
db.createCollection("usuario", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["nombres", "apellidos", "telefono", "dni"],
      properties: {
        nombres: {
          bsonType: "string",
          minLength: 1,
          maxLength: 40,
        },
        apellidos: {
          bsonType: "string",
          minLength: 1,
          maxLength: 40,
        },
        telefono: {
          bsonType: "string",
          pattern: "^[0-9]{9}$",
        },
        dni: {
          bsonType: "string",
          pattern: "^[0-9]{8}$",
        },
        propiedades: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: [
              "_id",
              "idZona",
              "tipoPropiedad",
              "dispositivoMedidor",
              "empresaProveedora",
            ],
            properties: {
              _id: {
                bsonType: "string",
              },
              idZona: {
                bsonType: "string",
              },
              tipoPropiedad: {
                bsonType: "string",
              },
              dispositivoMedidor: {
                bsonType: "object",
                required: [
                  "_id",
                  "modeloMedidor",
                  "marcaMedidor",
                  "tipoMedidor",
                  "capacidadMedidor",
                ],
                properties: {
                  _id: {
                    bsonType: "string",
                  },
                  modeloMedidor: {
                    bsonType: "string",
                    maxLength: 40,
                  },
                  marcaMedidor: {
                    bsonType: "string",
                    maxLength: 40,
                  },
                  tipoMedidor: {
                    bsonType: "string",
                    maxLength: 20,
                  },
                  capacidadMedidor: {
                    bsonType: "decimal",
                  },
                  electrodomesticos: {
                    bsonType: "array",
                    items: {
                      bsonType: "object",
                      required: [
                        "_id",
                        "idReporteConsumoEnergia",
                        "nombreElec",
                        "marcaElec",
                        "modeloElec",
                        "tipoElec",
                        "descripcionElec",
                        "minutosDeUsoElec",
                        "consumoEnergiaElec",
                      ],
                      properties: {
                        _id: {
                          bsonType: "string",
                        },
                        idReporteConsumoEnergia: {
                          bsonType: "string",
                        },
                        nombreElec: {
                          bsonType: "string",
                          maxLength: 50,
                        },
                        marcaElec: {
                          bsonType: "string",
                          maxLength: 60,
                        },
                        modeloElec: {
                          bsonType: "string",
                          maxLength: 60,
                        },
                        tipoElec: {
                          bsonType: "string",
                          maxLength: 50,
                        },
                        descripcionElec: {
                          bsonType: "string",
                          maxLength: 300,
                        },
                        minutosDeUsoElec: {
                          bsonType: "int",
                        },
                        consumoEnergiaElec: {
                          bsonType: "decimal",
                        },
                      },
                    },
                  },
                },
              },
              empresaProveedora: {
                bsonType: "object",
                required: ["_id", "nombreProveedora"],
                properties: {
                  _id: {
                    bsonType: "string",
                  },
                  nombreProveedora: {
                    bsonType: "string",
                    maxLength: 50,
                  },
                  informacion: {
                    bsonType: "string",
                    maxLength: 777,
                  },
                  empresaReguladora: {
                    bsonType: "object",
                    required: ["_id", "nombreReguladora"],
                    properties: {
                      _id: {
                        bsonType: "string",
                      },
                      nombreReguladora: {
                        bsonType: "string",
                        maxLength: 50,
                      },
                      informacion: {
                        bsonType: "string",
                        maxLength: 777,
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  },
});

// INSERTAR DATO QUE CUMPLE CON LAS CONDICIONES

// INSERTAR DATO QUE NO CUMPLE CON LAS CONDICIONES
