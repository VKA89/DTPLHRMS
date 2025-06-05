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

public partial class Admin_FrmDepartment : System.Web.UI.Page
{
    DAL Objdal = new DAL();
    ED objED = new ED();
    private string connectionString = ConfigurationManager.ConnectionStrings["conHR"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDepartmentGrid();
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
            new SqlParameter("@Department", txtdepart.Text.Trim()),
            new SqlParameter("@rslt", 0)
            };

            rslt = Objdal.IUDwithSqlParam("Usp_InsertDepart", param, "@rslt");
            if (rslt > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Department registered successfully!')", true);
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
            new SqlParameter("@Department_Id_pk", Convert.ToInt32(hdnId.Value)),
            new SqlParameter("@Department", txtdepart.Text.Trim()),
            new SqlParameter("@rslt", 0)
            };

            rslt = Objdal.IUDwithSqlParam("Usp_UpdateDepart", param, "@rslt");
            if (rslt > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Department updated successfully!')", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Update failed. Please try again.')", true);
            }

            hdnId.Value = "";
        }

        txtdepart.Text = "";
        BindDepartmentGrid();

    }
    private void BindDepartmentGrid()
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand("Usp_GetAllDepart", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvDepart.DataSource = dt;
            gvDepart.DataBind();
            if (dt.Rows.Count > 0)
            {
                gvDepart.HeaderRow.TableSection = TableRowSection.TableHeader;
                gvDepart.FooterRow.TableSection = TableRowSection.TableFooter;
            }
        }
    }
    protected void gvDepart_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditDepartment")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM mst_Department WHERE Department_Id_pk =  @Department_Id_pk", con);
                cmd.Parameters.AddWithValue("@Department_Id_pk", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtdepart.Text = dr["Department"].ToString();
                    hdnId.Value = dr["Department_Id_pk"].ToString();
                }
                con.Close();
            }
        }
    }
}