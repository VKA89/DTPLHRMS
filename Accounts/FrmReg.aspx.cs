using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using HRMS.App_Code;

    public partial class Accounts_FrmReg : System.Web.UI.Page
    {
        DAL Objdal = new DAL();
        ED objED = new ED();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {

            string passwordBase64 = objED.EncryptString(txtPassword.Text.Trim());
            int rslt = 0;
            SqlParameter[] param = {
                new SqlParameter("@Username", txtUsername.Text.Trim()),
                new SqlParameter("@Password", passwordBase64),
                new SqlParameter("@Name", txtName.Text.Trim()),
              new SqlParameter("@rslt",0)
             };
            rslt = Objdal.IUDwithSqlParam("USP_UserReg", param, "@rslt");
            if (rslt > 0)
            {
                lblMessage.Text = "User registered successfully!";
                txtUsername.Text = string.Empty;
                txtPassword.Text = string.Empty;
                txtName.Text = string.Empty;
            }
            else
            {
                lblMessage.Text = "Please try Again..!";
            }
        }
    }
