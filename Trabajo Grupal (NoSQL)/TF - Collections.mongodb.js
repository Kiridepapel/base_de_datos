// Collection: usuario
use("wolex");
db.usuario.insertMany([
  {
    _id: "US_1",
    nombres: "Heather Alexandra",
    apellidos: "Valencia Dominguez",
    telefono: "948271958",
    dni: "73859281",
    propiedades: [
      {
        _id: "PROP_1",
        idZona: "ZONA_1",
        tipoPropiedad: "Casa",
        dispositivoMedidor: {
          _id: "DISMED_1",
          modeloMedidor: "Sensitive Pro 6S",
          marcaMedidor: "Wolex",
          tipoMedidor: "Inteligente",
          capacidadMedidor: 5.6,
          electrodomesticos: [
            {
              _id: "ELEC_1",
              idReporteConsumoEnergia: "REPORTE_1",
              nombreElec: "Refrigeradora",
              marcaElec: "LG",
              modeloElec: "XYZ123",
              tipoElec: "Electrodoméstico",
              descripcionElec: "Una moderna refrigeradora",
              minutosDeUsoElec: 120,
              consumoEnergiaElec: 372.5,
            },
            {
              _id: "ELEC_2",
              idReporteConsumoEnergia: "REPORTE_2",
              nombreElec: "Televisor",
              marcaElec: "Samsung",
              modeloElec: "ABC456",
              tipoElec: "Electrodoméstico",
              descripcionElec: "Un televisor de alta definición",
              minutosDeUsoElec: 180,
              consumoEnergiaElec: 241.2,
            },
            {
              _id: "ELEC_3",
              idReporteConsumoEnergia: "REPORTE_3",
              nombreElec: "Lavadora Samsung",
              marcaElec: "Samsung",
              modeloElec: "WF70F5E0W2W",
              tipoElec: "Electrodoméstico",
              descripcionElec:
                "Una lavadora de carga frontal con capacidad para 7 kg de ropa",
              minutosDeUsoElec: 120,
              consumoEnergiaElec: 300,
            },
          ],
        },
        empresaProveedora: {
          _id: "EMPROV_1",
          nombreProveedora: "Luz del Sur",
          informacion:
            "Empresa proveedora de energía eléctrica en Perú. Provee servicios de electricidad a diversos distritos de Lima y Callao.",
          empresaReguladora: {
            _id: "EMPREG_1",
            nombreReguladora: "OSINERGMIN",
            informacion:
              "Organismo Supervisor de la Inversión en Energía y Minería en Perú. Se encarga de regular y supervisar el sector energético y minero del país.",
          },
        },
      },
    ],
  },
  {
    _id: "US_2",
    nombres: "Naydeline Milagros",
    apellidos: "Duran Guerrero",
    telefono: "987654321",
    dni: "73749281",
    propiedades: [
      {
        _id: "PROP_3",
        idZona: "ZONA_3",
        tipoPropiedad: "Apartamento",
        dispositivoMedidor: {
          _id: "DISMED_3",
          modeloMedidor: "ONE 2W",
          marcaMedidor: "Wibeee",
          tipoMedidor: "Monofásico",
          capacidadMedidor: 4.2,
          electrodomesticos: [
            {
              _id: "ELEC_4",
              idReporteConsumoEnergia: "REPORTE_4",
              nombreElec: "Horno",
              marcaElec: "Bosch",
              modeloElec: "789ABC",
              tipoElec: "Electrodoméstico",
              descripcionElec: "Un horno de última generación",
              minutosDeUsoElec: 60,
              consumoEnergiaElec: 183.7,
            },
            {
              _id: "ELEC_5",
              idReporteConsumoEnergia: "REPORTE_5",
              nombreElec: "Lavadora",
              marcaElec: "Samsung",
              modeloElec: "WF70F5E0W2W",
              tipoElec: "Electrodoméstico",
              descripcionElec: "Una lavadora de carga frontal",
              minutosDeUsoElec: 90,
              consumoEnergiaElec: 220.5,
            },
          ],
        },
        empresaProveedora: {
          _id: "EMPROV_2",
          nombreProveedora: "Enel Perú",
          informacion:
            "Empresa proveedora de servicios de energía eléctrica en Perú. Ofrece soluciones energéticas sostenibles y de calidad.",
          empresaReguladora: {
            _id: "EMPREG_2",
            nombreReguladora: "OSINERGMIN",
            informacion:
              "Organismo Supervisor de la Inversión en Energía y Minería en Perú. Encargado de supervisar y regular el sector energético y minero del país.",
          },
        },
      },
    ],
  },
]);
