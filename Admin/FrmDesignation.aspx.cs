using HRMS.App_Code;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_FrmDesignation : System.Web.UI.Page
{
    DAL Objdal = new DAL();
    ED objED = new ED();
    private string connectionString = ConfigurationManager.ConnectionStrings["conHR"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDesignationGrid();
        }

    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        int rslt = 0;
        SqlParameter[] param;

        if (string.IsNullOrEmpty(hdnId.Value))
        {
            param = new SqlParameter[]
            {
            new SqlParameter("@Designation", txtdesignation.Text.Trim()),
            new SqlParameter("@rslt", 0)
            };
            rslt = Objdal.IUDwithSqlParam("Usp_InsertDesignation", param, "@rslt");
            if (rslt > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Designation registered successfully!')", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Insert failed. Please try again.')", true);
            }
        }
        else
        {
            param = new SqlParameter[]
            {
            new SqlParameter("@Id_pk", Convert.ToInt32(hdnId.Value)),
            new SqlParameter("@Designation", txtdesignation.Text.Trim()),
            new SqlParameter("@rslt", 0)
            };

            rslt = Objdal.IUDwithSqlParam("Usp_UpdateDesignation", param, "@rslt");
            if (rslt > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Designation updated successfully!')", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Update failed. Please try again.')", true);
            }

            hdnId.Value = "";
        }
        txtdesignation.Text = "";
        BindDesignationGrid();
    }
    private void BindDesignationGrid()
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand("Usp_GetAllDesignations", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvDesignation.DataSource = dt;
            gvDesignation.DataBind();
            if (dt.Rows.Count > 0)
            {
                gvDesignation.HeaderRow.TableSection = TableRowSection.TableHeader;
                gvDesignation.FooterRow.TableSection = TableRowSection.TableFooter;
            }
        }
    }
    protected void gvDesignation_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditDesignation")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM mst_Designation WHERE Id_pk = @Id", con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtdesignation.Text = dr["Designation"].ToString();
                    hdnId.Value = dr["Id_pk"].ToString();
                }
                con.Close();
            }
        }
    }

}