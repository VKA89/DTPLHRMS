using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRMS.App_Code;

public partial class Admin_frmBU1 : System.Web.UI.Page
{
    DAL Objdal = new DAL();
    ED ed = new ED();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindgrd1();
            bindgrd();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtbuname.Text.Trim()))
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Invalid Data..')", true);
            return;
        }
        int rslt = 0;
        SqlParameter[] param = {
                new SqlParameter("@Code", ed.GenerateCode(6)),
                new SqlParameter("@Name", txtbuname.Text.ToUpper().Trim()),
                new SqlParameter("@CreatedBy", Session["LoginID"].ToString()),
               new SqlParameter("@IP", ed.GetUserIP()),
              new SqlParameter("@rslt",0)
             };
        rslt = Objdal.IUDwithSqlParam("USP_IUBUMaster", param, "@rslt");
        if (rslt > 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Unit " + txtbuname.Text + " created successfully')", true);
            txtbuname.Text = "";
            Response.Redirect(Request.RawUrl);//written by swarup
        }
        else if (rslt == -2)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Role " + txtbuname.Text + " already exists.')", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Try again....')", true);
        }
    }
    void bindgrd()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = {
                         new SqlParameter("@uuId", ddlbu.SelectedValue)
               };
        dt = Objdal.GetDataTableFromSP("USP_GetBU", param);
        GData.DataSource = dt;
        GData.DataBind();
        GData.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
    void bindgrd1()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = {
                         new SqlParameter("@uuId", ddlbu.SelectedValue)
               };
        dt = Objdal.GetDataTableFromSP("USP_GetBU", param);
        grdview.DataSource = dt;
        grdview.DataBind();
        grdview.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindgrd();
    }

    protected void btnpopsave_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtFdesc.Text.Trim()) || string.IsNullOrWhiteSpace(txtsdesc.Text.Trim()) || ddlstatus.SelectedValue == "-1")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Invalid Data..')", true);
            return;
        }
        int rslt = 0;
        SqlParameter[] param = {
                new SqlParameter("@uuId", hdnCode.Value),
                new SqlParameter("@Full_Desc", txtFdesc.Text.ToUpper().Trim()),
                new SqlParameter("@Short_Desc", txtsdesc.Text.ToUpper().Trim()),
                new SqlParameter("@status", ddlstatus.SelectedValue),
                new SqlParameter("@CreatedBy", Session["LoginID"].ToString()),
                new SqlParameter("@IP", ed.GetUserIP()),
                new SqlParameter("@rslt",0)
             };
        rslt = Objdal.IUDwithSqlParam("USP_IUBUMaster_Desc", param, "@rslt");
        if (rslt > 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Unit " + txtbuname.Text + " Record Submited successfully')", true);
            txtbuname.Text = "";
            bindgrd();
        }
        else if (rslt == -2)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Role " + txtbuname.Text + " already exists.')", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Try again....')", true);
        }
    }
}