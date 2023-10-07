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
    public class CantonesService
    {

        public List<CantonesModel> GetCantones(string IdProvincia)
        {
            var list = new List<CantonesModel>();

            string directorioActual = AppDomain.CurrentDomain.BaseDirectory;

            string rutaArchivo = Path.Combine(directorioActual, "Data/Cantones.json");

            string jsonContent = File.ReadAllText(rutaArchivo);

            list = JsonConvert.DeserializeObject<List<CantonesModel>>(jsonContent);

            return list.Where(element=>element.IdProvincia == IdProvincia).ToList();

        }
    }
}
