using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using HRMS.App_Code;
using System.Collections.Specialized;
using Newtonsoft.Json;
/// <summary>
/// Summary description for DropdownWebservice
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class DropdownWebservice : System.Web.Services.WebService
    {
    DAL Objdal = new DAL();
    [WebMethod(EnableSession = true)]
        public CascadingDropDownNameValue[] BindBUdropdown(string knownCategoryValues, string category)
        {
            DataTable dtSelectMethod = new DataTable();
            DAL Objdal = new DAL();
            dtSelectMethod = new DataTable();
            string DistCode;
            StringDictionary countrydetails = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            DistCode = Convert.ToString(countrydetails["BU"]);
            int Index = 0;
            //Index = countrydetails.IndexOf();
            SqlParameter[] param = {
                         new SqlParameter("@uuId", DistCode)
               };
            dtSelectMethod = Objdal.GetDataTableFromSP("USP_GetBU", param);
            List<CascadingDropDownNameValue> Districtdetails = new List<CascadingDropDownNameValue>();
            foreach (DataRow dtrow in dtSelectMethod.Rows)
            {
                string DistrictCode = dtrow["Code"].ToString();
                string DistrictName = dtrow["unitcode"].ToString();
                Districtdetails.Add(new CascadingDropDownNameValue(DistrictName, DistrictCode));
            }
            return Districtdetails.ToArray();
        }

    [WebMethod(EnableSession =true)]
    public string SaveCompanyFullData(string jsonData)
    {
        try
        {
            DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(jsonData);
            DataTable companyDataTable = dataSet.Tables["companyData"];
            DataTable emailDataTable = dataSet.Tables["emailData"];
            DataTable phoneDataTable = dataSet.Tables["phoneData"];
            SqlParameter[] CompanyfullDataParams = new SqlParameter[]
            {
            new SqlParameter("@CompanyId_pk", Guid.NewGuid()),
            new SqlParameter("@CompanyName", companyDataTable.Rows[0]["CompanyName"].ToString().Trim()),
            new SqlParameter("@EffectiveDate", Convert.ToDateTime(companyDataTable.Rows[0]["EffectiveDate"])),
            new SqlParameter("@Status", companyDataTable.Rows[0]["Status"].ToString() == "Active"?true:false),
            new SqlParameter("@Description", companyDataTable.Rows[0]["Description"].ToString().Trim()),
            new SqlParameter("@ShortDescription", companyDataTable.Rows[0]["ShortDescription"].ToString().Trim()),
            new SqlParameter("@Location", companyDataTable.Rows[0]["Location"].ToString().Trim()),
            new SqlParameter("@DefaultSetID", Convert.ToInt32(companyDataTable.Rows[0]["DefaultSetID"])),
            new SqlParameter("@Country", Convert.ToInt32(companyDataTable.Rows[0]["Country"])),
            new SqlParameter("@Building", companyDataTable.Rows[0]["Building"].ToString().Trim()),
            new SqlParameter("@Floor_No", companyDataTable.Rows[0]["Floor_No"].ToString().Trim()),
            new SqlParameter("@Language_Code", companyDataTable.Rows[0]["Language_Code"].ToString().Trim()),
            new SqlParameter("@StateId", Convert.ToInt32(companyDataTable.Rows[0]["StateId"])),
            new SqlParameter("@DistrictId", Convert.ToInt32(companyDataTable.Rows[0]["DistrictId"])),
            new SqlParameter("@Address1", companyDataTable.Rows[0]["Address1"].ToString().Trim()),
            new SqlParameter("@Address2", companyDataTable.Rows[0]["Address2"].ToString().Trim()),
            new SqlParameter("@PinCode", companyDataTable.Rows[0]["PinCode"].ToString().Trim()),
            new SqlParameter("@Industry", companyDataTable.Rows[0]["Industry"].ToString().Trim()),
            new SqlParameter("@IndustrySector", companyDataTable.Rows[0]["IndustrySector"].ToString().Trim()),
            new SqlParameter("@IP", companyDataTable.Rows[0]["IP"].ToString().Trim()),
            new SqlParameter("@Tbl_CompanyLocation_Email", emailDataTable),
            new SqlParameter("@Tbl_CompanyPhones_PhoneType", phoneDataTable),
            new SqlParameter("@rslt", 0) // Output parameter for result
            };
            dataSet.Dispose();
            string strcompMsgval = string.Empty;
            strcompMsgval = companyDataTable.Rows[0]["CompanyName"].ToString();
            companyDataTable.Dispose();
            emailDataTable.Dispose();
            phoneDataTable.Dispose();
            if (Objdal.IUDwithSqlParam("Usp_InsertCompanyFullData", CompanyfullDataParams, "@rslt") <= 0)
            {
                return "Insert failed for Company And Phone Location: " + strcompMsgval;
            }
            return "All data inserted successfully!";
        }
        catch (Exception ex)
        {
            return "Error: " + ex.Message;
        }
    }
}
