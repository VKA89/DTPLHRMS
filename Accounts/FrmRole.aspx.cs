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

public partial class Account_FrmRole : System.Web.UI.Page
{
    DAL Objdal = new DAL();
    ED objED = new ED();
    private string connectionString = ConfigurationManager.ConnectionStrings["conHR"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRoleGrid();
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
            new SqlParameter("@Role", txtRole.Text.Trim()),
            new SqlParameter("@rslt", 0)
            };

            rslt = Objdal.IUDwithSqlParam("Usp_InsertRole", param, "@rslt");
            if (rslt > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Role registered successfully!')", true);
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
            new SqlParameter("@Role_Id_pk", Convert.ToInt32(hdnId.Value)),
            new SqlParameter("@Role", txtRole.Text.Trim()),
            new SqlParameter("@rslt", 0)
            };

            rslt = Objdal.IUDwithSqlParam("Usp_UpdateRole", param, "@rslt");
            if (rslt > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Role updated successfully!')", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Update failed. Please try again.')", true);
            }

            hdnId.Value = "";
        }

        txtRole.Text = "";
        BindRoleGrid();


    }
    private void BindRoleGrid()
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand("Usp_GetAllRole", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvRole.DataSource = dt;
            gvRole.DataBind();
            if (dt.Rows.Count > 0)
            {
                gvRole.HeaderRow.TableSection = TableRowSection.TableHeader;
                gvRole.FooterRow.TableSection = TableRowSection.TableFooter;
            }
        }
    }
    protected void gvRole_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditRole")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM mst_Role WHERE Role_Id_pk =  @Role_Id_pk", con);
                cmd.Parameters.AddWithValue("@Role_Id_pk", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtRole.Text = dr["Role"].ToString();
                    hdnId.Value = dr["Role_Id_pk"].ToString();
                }
                con.Close();
            }
        }
    }
}