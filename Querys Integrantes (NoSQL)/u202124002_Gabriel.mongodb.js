// QUERY 1: Json Schema de la colección calificacion con valores delimitados
db.createCollection("calificacion", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["idPosteLuz", "idUsuario", "cantEstrellas", "comentario"],
      properties: {
        idPosteLuz: {
          bsonType: "string",
          pattern: "^P_\\d+$",
          description:
            "Identificador del poste de luz (formato: P_1, P_2, etc.)",
        },
        idUsuario: {
          bsonType: "string",
          pattern: "^US_\\d+$",
          description: "Identificador del usuario (formato: US_1, US_2, etc.)",
        },
        cantEstrellas: {
          bsonType: "int",
          minimum: 1,
          maximum: 5,
          description: "Cantidad de estrellas (valor numérico del 1 al 5)",
        },
        comentario: {
          bsonType: "string",
          maxLength: 240,
          description: "Comentario (hasta 240 caracteres)",
        },
      },
    },
  },
});

// QUERY 2: Inserción de datos en la colección calificacion cumpliendo con los valores limitados por ejemplo Json Schema anterior.
db.calificacion.insertOne({
  idPosteLuz: "P_3",
  idUsuario: "US_5",
  cantEstrellas: 3,
  comentario:
    "Este poste necesita un mantenimiento debido a que presenta degeneración de material",
});

// QUERY 3:
