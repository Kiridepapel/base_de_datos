// QUERY 1: Json Schema Validation de la Collection poste_luz (principal), zona (zona del poste de luz), empresa_reguladora (encargada de darle mantenimiento a los postes de luz), mantenimiento (lista de mantenimientos que se le hicieron a ese poste de luz a lo largo del tiempo), tipo_mantenimiento, tecnico (tecnico encargado del mantenimiento).
use("wolex");
db.createCollection("poste_luz", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: [
        "_id",
        "fechaInstalacion",
        "estabilidadPoste",
        "zona",
        "mantenimientos",
        "empresaReguladora",
      ],
      properties: {
        _id: {
          bsonType: "string",
        },
        fechaInstalacion: {
          bsonType: "string",
          description: "Fecha de instalación del poste de luz",
        },
        estabilidadPoste: {
          bsonType: "object",
          required: ["tipoEstabilidad"],
          properties: {
            _id: {
              bsonType: "string",
            },
            tipoEstabilidad: {
              bsonType: "string",
              maximum: 60,
              description: "Tipo de estabilidad del poste",
            },
            detalle: {
              bsonType: "string",
              maximum: 777,
              description: "Detalle del tipo de estabilidad",
            },
          },
        },
        zona: {
          bsonType: "object",
          required: ["latitud", "longitud"],
          properties: {
            _id: {
              bsonType: "string",
            },
            nombreZona: {
              bsonType: "string",
              maximum: 50,
              description: "Nombre de la zona",
            },
            latitud: {
              bsonType: "number",
              minimum: -90,
              maximum: 90,
              description: "Latitud de la zona",
            },
            longitud: {
              bsonType: "number",
              minimum: -90,
              maximum: 90,
              description: "Longitud de la zona",
            },
            distrito: {
              bsonType: "object",
              required: ["nombreDistrito"],
              properties: {
                _id: {
                  bsonType: "string",
                },
                nombreDistrito: {
                  bsonType: "string",
                  maximum: 50,
                  description: "Nombre del distrito",
                },
                codigoDistrital: {
                  bsonType: "number",
                  pattern: "^[0-9]{5}$",
                  description: "Codigo del distrito",
                },
                ciudad: {
                  bsonType: "object",
                  required: ["nombreCiudad"],
                  properties: {
                    _id: {
                      bsonType: "string",
                    },
                    nombreCiudad: {
                      bsonType: "string",
                      maximum: 50,
                      description: "Nombre de la ciudad",
                    },
                    codigoPostal: {
                      bsonType: "number",
                      pattern: "^[0-9]{6}$",
                      description: "Codigo postal de la ciudad",
                    },
                  },
                },
              },
            },
          },
        },
        mantenimientos: {
          bsonType: "array",
          description: "Lista de mantenimientos",
          items: {
            bsonType: "object",
            required: [
              "tecnico",
              "detalle",
              "fecha",
              "hora",
              "tipoMantenimiento",
              "calidad",
            ],
            properties: {
              _id: {
                bsonType: "string",
              },
              tecnico: {
                bsonType: "object",
                required: ["nombres", "apellidos", "telefono"],
                properties: {
                  _id: {
                    bsonType: "string",
                  },
                  nombres: {
                    bsonType: "string",
                    maximum: 40,
                    description: "Nombres del técnico encargado",
                  },
                  apellidos: {
                    bsonType: "string",
                    maximum: 40,
                    description: "Apellidos del técnico encargado",
                  },
                  telefono: {
                    bsonType: "string",
                    pattern: "^[0-9]{9}$",
                    description: "Telefono del técnico encargado",
                  },
                },
              },
              detalle: {
                bsonType: "string",
                maximum: 400,
                description: "Detalle del mantenimiento",
              },
              fecha: {
                bsonType: "string",
                description: "Fecha del mantenimiento",
              },
              hora: {
                bsonType: "string",
                description: "Hora del mantenimiento",
              },
              tipoMantenimiento: {
                bsonType: "object",
                required: ["tipoMantenimiento"],
                properties: {
                  _id: {
                    bsonType: "string",
                  },
                  tipoMantenimiento: {
                    bsonType: "string",
                    maximum: 60,
                    description: "Tipo de mantenimiento",
                  },
                  detalle: {
                    bsonType: "string",
                    maximum: 777,
                    description: "Descripcion del tipo de mantenimiento",
                  },
                },
              },
              calidad: {
                maximum: 20,
                bsonType: "string",
              },
            },
          },
        },
        empresaReguladora: {
          bsonType: "object",
          required: ["nombreReguladora"],
          properties: {
            _id: {
              bsonType: "string",
            },
            nombreReguladora: {
              bsonType: "string",
              maximum: 50,
              description: "Nombre de la empresa reguladora",
            },
            informacion: {
              bsonType: "string",
              maximum: 777,
              description: "Informacion de la empresa reguladora",
            },
          },
        },
      },
    },
  },
});

// QUERY 2: Inserción de datos en la Collection poste_luz a partir del Json Schema Validation creado anteriormente (datos que cumplen con las validaciones).
use("wolex");
db.poste_luz.insertOne({
  _id: "POSTL_1",
  fechaInstalacion: "2023-06-25",
  estabilidadPoste: {
    _id: "EPOSTL_1",
    tipoEstabilidad: "Estable",
    detalle: "El poste se encuentra firmemente instalado en el suelo.",
  },
  zona: {
    _id: "ZONA_1",
    nombreZona: "Parque Kennedy",
    latitud: -12.345678,
    longitud: -78.901234,
    distrito: {
      _id: "DIST_1",
      nombreDistrito: "San Isidro",
      codigoDistrital: 150126,
      ciudad: {
        _id: "CIUD_1",
        nombreCiudad: "Lima",
        codigoPostal: 15001,
      },
    },
  },
  mantenimientos: [
    {
      _id: "MANT_1",
      tecnico: {
        _id: "TEC_1",
        nombres: "Juan",
        apellidos: "Pérez",
        telefono: "982849281",
      },
      detalle: "Mantenimiento preventivo rutinario",
      fecha: "2023-06-25",
      hora: "09:00",
      tipoMantenimiento: {
        _id: "TMANT_1",
        tipoMantenimiento: "Revisión general",
        detalle: "Inspección visual y revisión de conexiones.",
      },
      calidad: "Alta",
    },
    {
      _id: "MANT_2",
      tecnico: {
        _id: "TEC_2",
        nombres: "María",
        apellidos: "Gómez",
        telefono: "987654321",
      },
      detalle: "Reparación de cableado",
      fecha: "2023-06-27",
      hora: "14:30",
      tipoMantenimiento: {
        _id: "TMANT_2",
        tipoMantenimiento: "Reparación",
        detalle: "Reemplazo de cables dañados.",
      },
      calidad: "Media",
    },
    {
      _id: "MANT_3",
      tecnico: {
        _id: "TEC_3",
        nombres: "Carlos",
        apellidos: "López",
        telefono: "982349821",
      },
      detalle: "Mantenimiento preventivo",
      fecha: "2023-06-29",
      hora: "10:00",
      tipoMantenimiento: {
        _id: "TMANT_3",
        tipoMantenimiento: "Revisión periódica",
        detalle: "Verificación del estado general del poste de luz.",
      },
      calidad: "Alta",
    },
    {
      _id: "MANT_4",
      tecnico: {
        _id: "TEC_4",
        nombres: "Ana",
        apellidos: "Martínez",
        telefono: "982834567",
      },
      detalle: "Mantenimiento correctivo",
      fecha: "2023-07-02",
      hora: "15:30",
      tipoMantenimiento: {
        _id: "TMANT_4",
        tipoMantenimiento: "Reparación",
        detalle: "Solución de problemas de funcionamiento.",
      },
      calidad: "Alta",
    },
  ],
  empresaReguladora: {
    _id: "EMPREG_1",
    nombreReguladora: "OSINERGMIN",
    informacion:
      "Organismo Supervisor de la Inversión en Energía y Minería en Perú.",
  },
});

// QUERY 3: Obtener la zona de los postes de luz que han tenido al menos un mantenimiento en entre el 2023-06-25 y el 2023-06-30 y con calidad de mantenimiento alta. Debe mostrarse además de la zona, la fecha exacta en la que se realizó ese mantenimiento y el tipo de mantenimiento que fue.
use("wolex");
db.poste_luz.aggregate([
  {
    $unwind: "$mantenimientos",
  },
  {
    $match: {
      "mantenimientos.fecha": {
        $gte: "2023-06-25",
        $lte: "2023-06-30",
      },
      "mantenimientos.calidad": "Alta",
    },
  },
  {
    $sort: {
      "mantenimientos.fecha": 1,
    },
  },
  {
    $project: {
      _id: 0,
      "ID del Poste": "$_id",
      "Zona del Poste": "$zona.nombreZona",
      "ID del Mantenimiento": "$mantenimientos._id",
      "Fecha del Mantenimiento": "$mantenimientos.fecha",
      "Tipo de Mantenimiento":
        "$mantenimientos.tipoMantenimiento.tipoMantenimiento",
      "Calidad del Mantenimiento": "$mantenimientos.calidad",
    },
  },
]);

// QUERY 4: Obtener el nombre completo de los usuarios con menos de 3 propiedades, de la cual al menos una propiedad está vinculada a un dispositivo medidor el cual tiene una capacidad mayor a 5 y además a ese usuario debe tener como empresa proveedora a la empresa Luz del Sur; además debe mostrar el numero de propiedades que tienen un dispositivo medidor con una capacidad de medidor mayor a 3.
use("wolex");
db.usuario.aggregate([
  {
    $match: {
      $and: [
        {
          $expr: {
            $lt: [{ $size: "$propiedades" }, 3],
          },
        },
        {
          "propiedades.dispositivoMedidor.capacidadMedidor": {
            $gt: 5,
          },
        },
        {
          "propiedades.empresaProveedora.nombreProveedora": "Luz del Sur",
        },
      ],
    },
  },
  {
    $addFields: {
      "Propiedades con Capacidad de Medidor Mayor a 3": {
        $size: {
          $filter: {
            input: "$propiedades",
            cond: {
              $gt: ["$$this.dispositivoMedidor.capacidadMedidor", 3], // gt: > que | // $$this: referencia al elemento actual del arreglo que se está filtrando
            },
          },
        },
      },
    },
  },
  {
    $project: {
      _id: 0,
      "Nombre Completo": { $concat: ["$nombres", " ", "$apellidos"] },
      "Propiedades con Capacidad de Medidor Mayor a 3": 1,
      Telefono: { $concat: ["+51 ", "$telefono"] },
      DNI: "$dni",
    },
  },
]);
