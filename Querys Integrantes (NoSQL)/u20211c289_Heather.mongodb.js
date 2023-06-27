// QUERY 1: Para obtener los electrodomésticos que consumen más energía entre el 25 de junio de 2023 y el 30 de junio de 2023, y también obtener la cantidad de minutos de uso por cada electrodoméstico energía en los distritos de Lima, Miraflores y San Isidro.
use("wolex");
db.usuario.aggregate([
  {
    $unwind: "$propiedades",
  },
  {
    $unwind: "$propiedades.dispositivoMedidor.electrodomesticos",
  },
  {
    $match: {
      "propiedades.idZona": { $in: ["Lima", "Miraflores", "San Isidro"] },
      "propiedades.dispositivoMedidor.electrodomesticos.idReporteConsumoEnergia":
        {
          $gte: "2023-05-13",
          $lte: "2023-05-20",
        },
    },
  },
  {
    $group: {
      _id: "$propiedades.dispositivoMedidor.electrodomesticos.nombreElec",
      totalMinutosUso: {
        $sum: "$propiedades.dispositivoMedidor.electrodomesticos.minutosDeUsoElec",
      },
      totalConsumoEnergia: {
        $sum: "$propiedades.dispositivoMedidor.electrodomesticos.consumoEnergiaElec",
      },
    },
  },
  {
    $sort: { totalConsumoEnergia: -1 },
  },
]);

// QUERY 2: Para obtener la lista de técnicos que han realizado mantenimientos en postes de luz, junto con la cantidad de mantenimientos realizados por cada técnico en cada distrito de la ciudad de Lima Metropolitana.
use("wolex");
db.mantenimientos.aggregate([
  {
    $lookup: {
      from: "tecnicos",
      localField: "idTecnico",
      foreignField: "_id",
      as: "tecnico",
    },
  },
  {
    $unwind: "$tecnico",
  },
  {
    $group: {
      _id: {
        distrito: "$distrito",
        tecnicoId: "$tecnico._id",
        tecnicoNombre: "$tecnico.nombre",
      },
      totalMantenimientos: { $sum: 1 },
    },
  },
  {
    $group: {
      _id: {
        distrito: "$_id.distrito",
        tecnicoId: "$_id.tecnicoId",
      },
      tecnicoNombre: { $first: "$_id.tecnicoNombre" },
      totalMantenimientos: { $sum: "$totalMantenimientos" },
    },
  },
  {
    $sort: { "_id.distrito": 1 },
  },
]);

// QUERY 3: Para obtener los avisos más repetidos durante las fechas comprendidas entre el 26 de junio de 2023 y el 16 de julio de 2023, junto con la información del electrodoméstico correspondiente y su descripción detallada.
db.usuario.aggregate([
  {
    $match: {
      "propiedades.dispositivoMedidor.electrodomesticos.idReporteConsumoEnergia.fecha":
        {
          $gte: "2023-05-13",
          $lte: "2023-05-20",
        },
    },
  },
  {
    $unwind: "$propiedades",
  },
  {
    $unwind: "$propiedades.dispositivoMedidor.electrodomesticos",
  },
  {
    $match: {
      "propiedades.dispositivoMedidor.electrodomesticos.idReporteConsumoEnergia.fecha":
        {
          $gte: "2023-05-13",
          $lte: "2023-05-20",
        },
    },
  },
  {
    $group: {
      _id: {
        usuario: "$_id",
        electrodomestico:
          "$propiedades.dispositivoMedidor.electrodomesticos.nombreElec",
        descripcion:
          "$propiedades.dispositivoMedidor.electrodomesticos.descripcionElec",
      },
      count: { $sum: 1 },
    },
  },
  {
    $sort: { count: -1 },
  },
  {
    $group: {
      _id: "$_id.usuario",
      maxRepetidos: { $first: "$count" },
      electrodomesticos: {
        $push: {
          electrodomestico: "$_id.electrodomestico",
          descripcion: "$_id.descripcion",
        },
      },
    },
  },
  {
    $project: {
      usuario: "$_id",
      maxRepetidos: 1,
      electrodomesticos: 1,
      _id: 0,
    },
  },
]);
