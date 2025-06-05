using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRMS.App_Code;

public partial class _Default : System.Web.UI.Page
{
    DAL Objdal = new DAL();
    private static readonly string key = "1234567890123456";  // 16 bytes key
    private static readonly string iv = "1234567890123456";   // 16 bytes IV
    string passwordPattern = @"^(?=(.*[A-Z]){1})(?=(.*[a-z]){1})(?=(.*\d){1})(?=(.*[\W_]){1}).{8,}$";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
    }
    private string EncryptString(string plainText)
    {
        using (Aes aesAlg = Aes.Create())
        {
            aesAlg.Key = Encoding.UTF8.GetBytes(key);  // Use a 16-byte key (128 bits)
            aesAlg.IV = Encoding.UTF8.GetBytes(iv);    // Use a 16-byte IV (128 bits)

            ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

            using (MemoryStream msEncrypt = new MemoryStream())
            {
                using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                {
                    using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                    {
                        swEncrypt.Write(plainText);  // Encrypt the plain text
                    }
                }

                // Return the encrypted text as a base64 string
                return Convert.ToBase64String(msEncrypt.ToArray());
            }
        }
    }

    protected void btnSignIn_Click(object sender, EventArgs e)
    {
        string Passwords = txtPassword.Text.Trim();
        txtPassword.Text = EncryptString(Passwords);
        if (Objdal.ValidateUser(txtUsername.Text.Trim(), Passwords, "Login"))
        {
            Response.Redirect("~/Home.aspx");
        }
        else

        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Invalid User ID/Password')", true);
        }

    }
}