<%@ WebService Language="C#"  Class="WSRezervacii" %>
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

/// <summary>
/// Summary description for WSRezervacii
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class WSRezervacii : System.Web.Services.WebService {
    SqlCommand sqlCm;
    SqlConnection sqlCn;
    SqlDataAdapter sqlDa;
    
    String cnString;
    String komanda;

    public WSRezervacii () {

        cnString = WebConfigurationManager.ConnectionStrings["SQLMoj"].ToString();
        //oCon = new OracleConnection(cnString);
        sqlCn = new SqlConnection(cnString);
    }
    [WebMethod(Description="Rezervacii",EnableSession=true)]
    public String[] rezervirajMasa(String datum, Int16 Vreme, Int16 brLica, Int16 RestoranID)
    {
        Session.Remove("Masi");
        DataSet dsMasi = new DataSet();
        List<String> masiId = new List<String>();
        try
        {
            // komanda = "Select top 1 ID from masi where Mesta>=" + brLica + " and  Id in (Select m.Id from rezervacii r right outer join masi m on r.Masa_Id=m.Id and r.Vreme<>" + Vreme + " and r.Datum=CAST('" + datum + "' as smalldatetime)) order by Masi.Mesta";
            komanda = "Select  top 1 ID from masi where Mesta>=" + brLica + " and Id not in (Select Masa_id from rezervacii r where r.Restoran_ID=" + RestoranID + " and r.Vreme=" + Vreme + " and r.Datum=CAST('" + datum + "' as smalldatetime)) order by Masi.ID";
            sqlCm = new SqlCommand(komanda, sqlCn);
            sqlDa = new SqlDataAdapter(sqlCm);
            sqlCn.Open();
            sqlDa.Fill(dsMasi);
            sqlCn.Close();
            if (dsMasi.Tables[0].Rows.Count > 0)
            {
                masiId.Add(dsMasi.Tables[0].Rows[0]["ID"].ToString());
                Session["Masi"] = masiId;
                return  prefrliListaVoString(masiId);
            }
            else
            {
                // ako nema masa so tolku mesta
                int pom = 0;
                //komanda = "Select  * from masi where Id in (Select m.Id from rezervacii r right outer join masi m on r.Masa_Id=m.Id and r.Vreme<>" + Vreme + " and r.Datum=CAST('" + datum + "' as smalldatetime)) order by Masi.Mesta";
                komanda = "Select  * from masi where Id not in (Select Masa_id from rezervacii r where r.Restoran_ID=" + RestoranID + " and r.Vreme=" + Vreme + " and r.Datum=CAST('" + datum + "' as smalldatetime)) order by Masi.ID";
                sqlCm = new SqlCommand(komanda, sqlCn);
                sqlDa = new SqlDataAdapter(sqlCm);
                sqlCn.Open();
                sqlDa.Fill(dsMasi);
                sqlCn.Close();
                for (int i = 0; i < dsMasi.Tables[0].Rows.Count; i++)
                {
                    pom += Convert.ToInt16(dsMasi.Tables[0].Rows[i]["Mesta"].ToString());
                    masiId.Add(dsMasi.Tables[0].Rows[i]["ID"].ToString());
                    if (pom >= brLica)
                    {
                        Session["Masi"] = masiId;
                        break;
                    }

                }
                if (pom >= brLica)
                {
                    //Ima mesto
                    return prefrliListaVoString(masiId);;
                }
                else
                {
                    //Nema mesto
                    //statusDiv.InnerText = "Нема слободни места за избраното време и датум.";
                    //porakaStatus = "Нема слободни места за избраното време и датум.";
                    return null;
                }
            }
        }
        catch (Exception ex)
        {
            sqlCn.Close();
            //greskiDiv.InnerText = "Проблем при проврка на слободна маса " + ex.Message;
            //greskiDiv.Attributes.Add("style", "display:block");
            //porakaGreska = "Проблем при проврка на слободна маса " + ex.Message;
            return null;
        }

    }
    [WebMethod(Description = "Rezervacii", EnableSession = true)]
    public Boolean dodadiVoRezervacija(String[] masiId, String Datum, String Vreme, String RestoranID, String Ime, String Tel, String Email, String Baranje)
    {
        try
        {
            sqlCm = new SqlCommand();
            sqlCm.Connection = sqlCn;
            sqlCn.Open();
            for (int i = 0; i < masiId.Length; i++)
            {
                int masaId = Convert.ToInt16(masiId[i].ToString());
                komanda = "Insert into Rezervacii values(" + masaId + ",CAST('" + Datum + "' as smalldatetime)," + Vreme + "," + RestoranID + ",'" + Ime + "','" + Tel + "','" + Email + "','" + Baranje + "')";
                sqlCm.CommandText = komanda;
                sqlCm.ExecuteNonQuery();

            }
            sqlCn.Close();
            return true;
        }
        catch (Exception ex)
        {
            //greskiDiv.InnerText = "Проблем при резервирање на маса " + ex.Message;
            //greskiDiv.Attributes.Add("style", "display:block");
            //porakaGreska = "Проблем при резервирање на маса " + ex.Message;
            return false;
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

