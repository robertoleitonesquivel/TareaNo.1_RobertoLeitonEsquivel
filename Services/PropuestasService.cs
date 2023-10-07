using Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Services
{
    public class PropuestasService
    {
        public void Save(PropuestasModel propuestasModel)
        {

            string directorioActual = AppDomain.CurrentDomain.BaseDirectory;

            string rutaArchivo = Path.Combine(directorioActual, "Data/PropuestasLegislativas.xml");


            if (!File.Exists(rutaArchivo))
            {

                XElement propuesta = new XElement("Propuestas",
                            new XElement("Propuesta",
                            new XElement("TypeIdentificacion", propuestasModel.TypeIdentificacion),
                            new XElement("Identificacion", propuestasModel.Identificacion),
                            new XElement("Nombre", propuestasModel.Nombre),
                            new XElement("Apellidos", propuestasModel.Apellidos),
                            new XElement("Telefono", propuestasModel.Telefono),
                            new XElement("Email", propuestasModel.Email),
                            new XElement("Provincia", propuestasModel.Provincia),
                            new XElement("Canton", propuestasModel.Canton),
                            new XElement("Propuesta", propuestasModel.Propuesta))
                        );

                propuesta.Save(rutaArchivo);
            }
            else
            {

                XDocument xmlDoc = XDocument.Load(rutaArchivo);


                XElement propuesta = new XElement("Propuesta",
                    new XElement("TypeIdentificacion", propuestasModel.TypeIdentificacion),
                    new XElement("Identificacion", propuestasModel.Identificacion),
                    new XElement("Nombre", propuestasModel.Nombre),
                    new XElement("Apellidos", propuestasModel.Apellidos),
                    new XElement("Telefono", propuestasModel.Telefono),
                    new XElement("Email", propuestasModel.Email),
                    new XElement("Provincia", propuestasModel.Provincia),
                    new XElement("Canton", propuestasModel.Canton),
                    new XElement("Propuesta", propuestasModel.Propuesta)
                );

                xmlDoc.Root.Add(propuesta);
                xmlDoc.Save(rutaArchivo);
            }


        }
    }
}
