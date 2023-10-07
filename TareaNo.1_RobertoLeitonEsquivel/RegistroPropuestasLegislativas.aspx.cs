using Models;
using Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace TareaNo._1_RobertoLeitonEsquivel
{
    public partial class RegistroPropuestasLegislativas : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            this.GetProvincias();
        }

        [WebMethod]
        public static string Save(PropuestasModel propuestas)
        {
            try
            {
                PropuestasService propuestasService = new PropuestasService();

                propuestasService.Save(propuestas);

                return "Guardo con éxito.";
            }
            catch (Exception)
            {

                throw;
            }
        }

        public void GetProvincias()
        {
            try
            {
              
                ProvinciasService provinciasService = new ProvinciasService();

                var provincias = provinciasService.GetProvincias();

                foreach (var p in provincias)
                    provincia.Items.Add(new ListItem(p.Provincia, p.Id));
            }
            catch (Exception)
            {
                
            }


        }

        [WebMethod]
        public static List<ListItem> GetCantones(string IdProvincia)
        {
            try
            {
                CantonesService provinciasService = new CantonesService();

                List<ListItem> opciones = new List<ListItem>();

                var cantones = provinciasService.GetCantones(IdProvincia);

                foreach (var c in cantones)
                    opciones.Add(new ListItem(c.Canton, c.IdCanton));

                return opciones;
            }
            catch (Exception)
            {
                return new List<ListItem>();
            }
        }

    }
}