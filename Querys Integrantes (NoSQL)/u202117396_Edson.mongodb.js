// QUERY 1: Obtener la lista de postes de luz que han tenido al menos dos mantenimientos y cuyo tipo de estabilidad del poste es "Estable".
use("wolex");
db.poste_luz.aggregate([
  {
    $match: {
      $expr: {
        $and: [
          { $gte: [{ $size: "$mantenimientos" }, 2] },
          { "estabilidadPoste.tipoEstabilidad": "Estable" },
        ],
      },
    },
  },
  {
    $project: {
      _id: 1,
      fechaInstalacion: 1,
      zona: 1,
      empresaReguladora: 1,
      mantenimientos: 1,
    },
  },
]);

// QUERY 2: Obtener la lista de postes de luz que se encuentran en la zona con nombre "Parque Castilla" y cuyo mantenimiento fue realizado por la empresa reguladora "OSINERGMIN".
use("wolex");
db.poste_luz.aggregate([
  {
    $match: {
      "zona.nombreZona": "Parque Castilla",
      "empresaReguladora.nombreReguladora": "OSINERGMIN",
    },
  },
  {
    $project: {
      _id: 1,
      fechaInstalacion: 1,
      zona: 1,
      empresaReguladora: 1,
      mantenimientos: 1,
    },
  },
]);

// QUERY 3: Obtener todos los postes de luz que han tenido un mantenimiento de tipo "Mantenimiento preventivo regular" y fueron realizados por el técnico con nombres "Pedro", apellidos "López Rodríguez".
use("wolex");
db.poste_luz.aggregate([
  {
    $match: {
      "mantenimientos.tipoMantenimiento.tipoMantenimiento":
        "Mantenimiento preventivo regular",
      "mantenimientos.tecnico.nombres": "Pedro",
      "mantenimientos.tecnico.apellidos": "López Rodríguez",
    },
  },
  {
    $project: {
      _id: 1,
      fechaInstalacion: 1,
      zona: 1,
      empresaReguladora: 1,
      mantenimientos: 1,
    },
  },
]);
