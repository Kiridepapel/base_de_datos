// QUERY 1: Esta consulta buscará todos los usuarios cuyas propiedades tengan al menos un electrodoméstico con un consumo de energía mayor a 250.
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
      "propiedades.dispositivoMedidor.electrodomesticos.consumoEnergiaElec": {
        $gt: 250,
      },
    },
  },
  {
    $group: {
      _id: "$_id",
      nombres: { $first: "$nombres" },
      apellidos: { $first: "$apellidos" },
      telefono: { $first: "$telefono" },
      dni: { $first: "$dni" },
      propiedades: { $push: "$propiedades" },
    },
  },
]);

// QUERY 2: Esta consulta buscará todos los usuarios cuyas propiedades estén asociadas a la empresa proveedora "Luz del Sur".
use("wolex");
db.usuario.aggregate([
  {
    $unwind: "$propiedades",
  },
  {
    $match: {
      "propiedades.empresaProveedora.nombreProveedora": "Luz del Sur",
    },
  },
  {
    $group: {
      _id: "$_id",
      nombres: { $first: "$nombres" },
      apellidos: { $first: "$apellidos" },
      telefono: { $first: "$telefono" },
      dni: { $first: "$dni" },
      propiedades: { $push: "$propiedades" },
    },
  },
]);

// QUERY 3: Esta consulta buscará todos los usuarios cuyas propiedades tengan al menos un electrodoméstico con la marca "Samsung".
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
      "propiedades.dispositivoMedidor.electrodomesticos.marcaElec": "Samsung",
    },
  },
  {
    $group: {
      _id: "$_id",
      nombres: {
        $first: "$nombres",
      },
      apellidos: {
        $first: "$apellidos",
      },
      telefono: {
        $first: "$telefono",
      },
      dni: {
        $first: "$dni",
      },
      propiedades: {
        $push: "$propiedades",
      },
    },
  },
]);
