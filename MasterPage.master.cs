using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Convert.ToString(Session["loginID"])) || Convert.ToString(Session["loginID"]) == null || Convert.ToString(Session["loginID"]) == "0")
        {
            Response.Redirect("~/Default.aspx");
        }
        else
        {

            if (!IsPostBack)
            {

                husername.InnerText =  Session["Name"].ToString();

                if (string.IsNullOrEmpty(Convert.ToString(Session["loginID"])) || Convert.ToString(Session["loginID"]) == null || Convert.ToString(Session["loginID"]) == "0")
                {
                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                }
            }
        }
    }
}
