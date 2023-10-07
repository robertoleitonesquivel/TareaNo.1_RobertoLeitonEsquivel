using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public class ProvinciasService
    {
        public List<ProvinciasModel> GetProvincias()
        {
            var list = new List<ProvinciasModel>();

            string directorioActual = AppDomain.CurrentDomain.BaseDirectory;

            string rutaArchivo = Path.Combine(directorioActual, "Data/Provincias.json");

            string jsonContent = File.ReadAllText(rutaArchivo);

            list = JsonConvert.DeserializeObject<List<ProvinciasModel>>(jsonContent);

            return list;
        }
    }
}
