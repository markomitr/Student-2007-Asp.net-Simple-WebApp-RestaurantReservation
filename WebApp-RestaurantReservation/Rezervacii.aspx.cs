using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data.OracleClient;
using System.Data;
using System.Web.Services;

public partial class Rezervacii : System.Web.UI.Page
{
    SqlCommand sqlCm;
    SqlConnection sqlCn;
    SqlDataAdapter sqlDa;
    OracleConnection oCon;
    OracleCommand oCom;

    String cnString;
    String komanda;
    RezervaciiProekt.WSRezervacii wsRezerviraj;
    //WebService wsRezerviraj = new WebService();
    public Rezervacii()
    {
        cnString = WebConfigurationManager.ConnectionStrings["SQLMoj"].ToString();
        //oCon = new OracleConnection(cnString);
        sqlCn = new SqlConnection(cnString);
        wsRezerviraj = new RezervaciiProekt.WSRezervacii();
        //wsRezerviraj = new WebService();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        greskiDiv.Attributes.Add("style", "display:none");
        statusDiv.Attributes.Add("style", "display:none");
        if(!IsPostBack)
        napolniRestorani();
       
    }
    //protected Boolean rezervirajMasa(String datum, Int16 Vreme, Int16 brLica,Int16 RestoranID)
    //{
    //    Session.Remove("Masi");
    //    DataSet dsMasi = new DataSet();
    //    List<String> masiId = new List<String>();
    //    try
    //    {
    //       // komanda = "Select top 1 ID from masi where Mesta>=" + brLica + " and  Id in (Select m.Id from rezervacii r right outer join masi m on r.Masa_Id=m.Id and r.Vreme<>" + Vreme + " and r.Datum=CAST('" + datum + "' as smalldatetime)) order by Masi.Mesta";
    //        komanda = "Select  top 1 ID from masi where Mesta>=" + brLica + " and Id not in (Select Masa_id from rezervacii r where r.Restoran_ID="+ RestoranID +" and r.Vreme=" + Vreme + " and r.Datum=CAST('" + datum + "' as smalldatetime)) order by Masi.ID";
    //        sqlCm = new SqlCommand(komanda, sqlCn);
    //        sqlDa = new SqlDataAdapter(sqlCm);
    //        sqlCn.Open();
    //        sqlDa.Fill(dsMasi);
    //        sqlCn.Close();
    //        if (dsMasi.Tables[0].Rows.Count > 0)
    //        {
    //            masiId.Add(dsMasi.Tables[0].Rows[0]["ID"].ToString());
    //            Session["Masi"] = masiId;
                
    //            return true;
    //        }
    //        else
    //        {
    //            // ako nema masa so tolku mesta
    //            int pom = 0;
    //            //komanda = "Select  * from masi where Id in (Select m.Id from rezervacii r right outer join masi m on r.Masa_Id=m.Id and r.Vreme<>" + Vreme + " and r.Datum=CAST('" + datum + "' as smalldatetime)) order by Masi.Mesta";
    //            komanda = "Select  * from masi where Id not in (Select Masa_id from rezervacii r where r.Restoran_ID=" + RestoranID + " and r.Vreme=" + Vreme + " and r.Datum=CAST('" + datum + "' as smalldatetime)) order by Masi.ID";
    //            sqlCm = new SqlCommand(komanda, sqlCn);
    //            sqlDa = new SqlDataAdapter(sqlCm);
    //            sqlCn.Open();
    //            sqlDa.Fill(dsMasi);
    //            sqlCn.Close();
    //            for (int i = 0; i < dsMasi.Tables[0].Rows.Count; i++)
    //            {
    //                pom += Convert.ToInt16(dsMasi.Tables[0].Rows[i]["Mesta"].ToString());
    //                masiId.Add(dsMasi.Tables[0].Rows[i]["ID"].ToString());
    //                if (pom >= brLica)
    //                {
    //                    Session["Masi"] = masiId;
    //                    break;
    //                }
                        
    //            }
    //            if (pom >= brLica)
    //            {
    //                //Ima mesto
    //                return true;
    //            }
    //            else
    //            {
    //                //Nema mesto
    //                statusDiv.InnerText = "Нема слободни места за избраното време и датум.";
    //                return false;
    //            }
    //        }
    //    }
    //    catch(Exception ex)
    //    {
    //        sqlCn.Close();
    //        greskiDiv.InnerText = "Проблем при проврка на слободна маса " + ex.Message;
    //        greskiDiv.Attributes.Add("style", "display:block");
    //        return false;
    //    }

    //}
    //protected Boolean dodadiVoRezervacija(List<String> masiId,String Datum,String Vreme,String RestoranID,String Ime,String Tel,String Email,String Baranje)
    //{
    //    try
    //    {
    //        sqlCm = new SqlCommand();
    //        sqlCm.Connection = sqlCn;
    //        sqlCn.Open();
    //        for (int i = 0; i < masiId.Count; i++)
    //        {
    //            int masaId = Convert.ToInt16(masiId[i].ToString());
    //            komanda = "Insert into Rezervacii values("+masaId+",CAST('" + Datum + "' as smalldatetime),"+ Vreme + "," + RestoranID  + ",'"+Ime+"','"+Tel+"','"+Email+"','"+Baranje+"')";
    //            sqlCm.CommandText = komanda;
    //            sqlCm.ExecuteNonQuery();
			 
    //        }
    //        sqlCn.Close();
    //        return true;
    //    }
    //    catch (Exception ex)
    //    {
    //        greskiDiv.InnerText = "Проблем при резервирање на маса " + ex.Message;
    //        greskiDiv.Attributes.Add("style", "display:block");
    //        return false;
    //    }

    //}
    protected void Rezerviraj_Click(object sender, EventArgs e)
    {
        statusDiv.Attributes.Add("style", "display:block");
        String statusPoraka ="";
        String greskaPoraka="";
        greskiDiv.InnerText = "";
        statusDiv.InnerText = "";
        String[] masi =wsRezerviraj.rezervirajMasa(txtBoxDatum.Text, Convert.ToInt16(ddlVreme.SelectedItem.Text), Convert.ToInt16(txtBoxBrLica.Text), Convert.ToInt16(ddlRestorani.SelectedValue));
        if (masi!=null)
        {          
            if (wsRezerviraj.dodadiVoRezervacija(masi,txtBoxDatum.Text, ddlVreme.SelectedItem.Text, ddlRestorani.SelectedValue, txtBoxIme.Text, txtBoxTel.Text, txtBoxEmail.Text, txtBoxBaranje.Text))
            {
                String masiRezervirani ="";
                for (int i = 0; i < masi.Length; i++)
			    {
    			  masiRezervirani +=masi[i] + ",";
			    }
                statusDiv.InnerText = "Ресторан "+ ddlRestorani.SelectedItem.Text + ". Резервирани се " + masi.Length.ToString() + " маси(" + masiRezervirani + ") на ден " + txtBoxDatum.Text + " со капацитет " + txtBoxBrLica.Text + "  лица  на име " + txtBoxIme.Text + ". Благодариме.";
            }
            else
            {
                //greeska vo dodavanjeto
                statusDiv.InnerText += "Не е резервирано " + statusPoraka;
                if (greskaPoraka != "")
                {
                    greskiDiv.Attributes.Add("style", "display:block");
                    greskiDiv.InnerText = greskaPoraka;
                }
            }
        }
        else
        {
            //nema vo proverkata
            statusDiv.InnerText += "Не е резервирано " + statusPoraka;
            if (greskaPoraka != "")
            {
                greskiDiv.Attributes.Add("style", "display:block");
                greskiDiv.InnerText = greskaPoraka;
            }
        }
    }

    protected void btnOtkazi_Click(object sender, EventArgs e)
    {
        Session.Remove("Masi");
        Response.Redirect("Doma.aspx");
    }
    protected void napolniRestorani()
    {
        
        try
        {
            SqlDataReader sqlDr;
            komanda  = "Select * from Restorani";
            sqlCm = new SqlCommand(komanda, sqlCn);

            sqlCn.Open();
            sqlDr = sqlCm.ExecuteReader();
            if (sqlDr.HasRows && sqlDr != null)
            {
                while (sqlDr.Read())
                {
                    ddlRestorani.Items.Add(new ListItem(sqlDr["Ime"].ToString(),sqlDr["ID"].ToString()));
                }
            }
             sqlCn.Close();
        }
        catch (Exception ex)
        {
            sqlCn.Close();
            greskiDiv.InnerText ="Problem so polnenje na listboxRestorani " + ex.Message;
        }
    }
    protected String[] prefrliListaVoString(List<String> lista)
    {
        String[] pom = new String[lista.Count];
        for (int i = 0; i < lista.Count; i++)
        {
            pom[i] = lista[i].ToString();
        }
        return pom;
    }
}
