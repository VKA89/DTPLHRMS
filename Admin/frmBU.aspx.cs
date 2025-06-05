using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRMS.App_Code;

public partial class Admin_frmBU : System.Web.UI.Page
{
    DAL Objdal = new DAL();
    ED ed = new ED();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
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
                new SqlParameter("@Code", txtbuname.Text.ToUpper().Trim()),
                new SqlParameter("@Name", txtbuname.Text.ToUpper().Trim()),
                new SqlParameter("@CreatedBy", Session["LoginID"].ToString()),
               new SqlParameter("@IP", ed.GetUserIP()),
              new SqlParameter("@rslt",0)
             };
        rslt = Objdal.IUDwithSqlParam("USP_IUBUMaster", param, "@rslt");
        if (rslt > 0)
        {
            hdnname.Value = txtbuname.Text.Trim();
            hdnCode.Value = rslt.ToString();
            lblunit.Text = hdnname.Value;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "funPopSetup();", true);
            txtbuname.Text = "";
        }
        else if (rslt == -2)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Unit : " + txtbuname.Text + " already exists.')", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Try again....')", true);
        }
        bindgrd();
    }
    void bindgrd()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = {
                         new SqlParameter("@uuId", "")
               };
        dt = Objdal.GetDataTableFromSP("USP_GetBU", param);
        grdview.DataSource = dt;
        grdview.DataBind();
        if (dt.Rows.Count > 0)
        {
            grdview.HeaderRow.TableSection = TableRowSection.TableHeader;
            grdview.FooterRow.TableSection = TableRowSection.TableFooter;
        }
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
                new SqlParameter("@GroupuuId",ddlbu.SelectedValue),
                new SqlParameter("@rslt",0)
             };
        rslt = Objdal.IUDwithSqlParam("USP_IUBUMaster_Desc", param, "@rslt");
        if (rslt > 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Unit : " + txtbuname.Text + " Submited successfully')", true);
            txtbuname.Text = "";
            hdnCode.Value = string.Empty;
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

    protected void grdview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
        int index = row.RowIndex;
        lblunit.Text = row.Cells[1].Text;
        txtFdesc.Text = row.Cells[2].Text.Replace("&nbsp;",string.Empty);
        txtsdesc.Text = row.Cells[3].Text.Replace("&nbsp;", string.Empty);
        CFYear.SelectedValue = ((HiddenField)row.FindControl("hndgcode")).Value;
        ddlstatus.SelectedIndex = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText(row.Cells[4].Text));
        hdnCode.Value = ((HiddenField)row.FindControl("hndid")).Value;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "funPopSetup();", true);
        bindgrd();
    }
}