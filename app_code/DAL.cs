using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Runtime.Remoting;


namespace HRMS.App_Code
{
    public class DAL
    {
        SqlConnection ConnectionFactory = new SqlConnection(WebConfigurationManager.ConnectionStrings["conHR"].ToString());

        DataTable SqldbDataTable = new DataTable();
        
        public int IUDwithSqlParam(string sp, SqlParameter[] param, string OutParaName)
        {
            int inreslt = 0;

            if (ConnectionFactory.State == ConnectionState.Closed)
            {
                ConnectionFactory.Open();
            }
            try
            {

                SqlCommand sqlcommd = new SqlCommand();
                sqlcommd.Connection = ConnectionFactory;
                sqlcommd.CommandType = CommandType.StoredProcedure;
                sqlcommd.CommandText = sp;
                if (param != null && param.Length > 0)
                {
                    for (int i = 0; i < param.Length; i++)
                    {
                        sqlcommd.Parameters.Add(param[i]);
                        if (param[i].ParameterName == OutParaName)
                            param[i].Direction = ParameterDirection.Output;
                    }
                }
                sqlcommd.CommandTimeout = 999999;
                //ConnectionFactory.Open();
                sqlcommd.ExecuteNonQuery();
                inreslt = Convert.ToInt32(sqlcommd.Parameters[OutParaName].Value);
                ConnectionFactory.Close();
                sqlcommd.Dispose();
            }
            catch (Exception ex)
            {
                if (ConnectionFactory.State == ConnectionState.Open)
                {
                    ConnectionFactory.Close();
                }
                throw ex;
            }
            finally
            {
                if (ConnectionFactory.State == ConnectionState.Open)
                {
                    ConnectionFactory.Close();
                }
            }

            return inreslt;
        }

        public DataTable GetDataTableFromSP(string sp, SqlParameter[] param)
        {
            DataTable dt = new DataTable();
            SqlCommand sqlcommd = new SqlCommand();
            try
            {
                sqlcommd.Connection = ConnectionFactory;
                sqlcommd.CommandType = CommandType.StoredProcedure;
                sqlcommd.CommandText = sp;
                if (param != null && param.Length > 0)
                {
                    for (int i = 0; i < param.Length; i++)
                    {
                        sqlcommd.Parameters.Add(param[i]);
                        //if (param[i].ParameterName == OutParaName)
                        //    param[i].Direction = ParameterDirection.Output;
                    }
                }
                sqlcommd.CommandTimeout = 999999;
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = sqlcommd;
                da.Fill(dt);
            }catch(Exception ex)
            {

            }
            return dt;
        }


        public DataSet GetDataSetFromSP(string sp, SqlParameter[] param)
        {
            DataSet ds = new DataSet();
            SqlCommand sqlcommd = new SqlCommand();
            sqlcommd.Connection = ConnectionFactory;
            sqlcommd.CommandType = CommandType.StoredProcedure;
            sqlcommd.CommandText = sp;
            if (param != null && param.Length > 0)
            {
                for (int i = 0; i < param.Length; i++)
                {
                    sqlcommd.Parameters.Add(param[i]);
                    //if (param[i].ParameterName == OutParaName)
                    //    param[i].Direction = ParameterDirection.Output;
                }
            }
            sqlcommd.CommandTimeout = 999999;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = sqlcommd;
            da.Fill(ds);
            return ds;
        }

        public bool ValidateUser(string USERID, string PASSWORD, string DomainFlag)
        {
            try
            {
                ED objED = new ED();
                DataTable dbSqlDataTable = new DataTable();
                dbSqlDataTable = CheckPassword("", USERID, PASSWORD, objED.EncryptString(PASSWORD), "", "", "Login");


                if (dbSqlDataTable.Rows.Count > 0)
                {
                    HttpContext.Current.Session["LoginID"] = (dbSqlDataTable.Rows[0]["LoginID"].ToString());
                    HttpContext.Current.Session["Username"] = (dbSqlDataTable.Rows[0]["Username"].ToString());
                    HttpContext.Current.Session["Name"] = (dbSqlDataTable.Rows[0]["Name"].ToString());
                    return true;
                }
                else { return false; }
            }
            catch (SqlException e)
            {

                throw e;
            }
            finally
            {

            }
        }
        public DataTable CheckPassword(string UserID, string UserName, string CurrPass, string EncyCurrPass, string NewPass, string EncyNewPass, string flag)
        {
            DataTable SqlDataTable = new DataTable();
            SqlCommand dbSqlCommand = new SqlCommand();
            SqlDataAdapter dbSqlAdapter = new SqlDataAdapter();
            SqlDataTable = new DataTable();
            try
            {
                if (ConnectionFactory.State == ConnectionState.Closed)
                {
                    ConnectionFactory.Open();
                }
                dbSqlCommand.Connection = ConnectionFactory;
                dbSqlCommand.CommandType = CommandType.StoredProcedure;
                dbSqlCommand.CommandText = "SP_Login";
                dbSqlCommand.Parameters.AddWithValue("@UserID", UserID);
                dbSqlCommand.Parameters.AddWithValue("@UserName", UserName);
                dbSqlCommand.Parameters.AddWithValue("@CurrPass", CurrPass);
                dbSqlCommand.Parameters.AddWithValue("@EncyCurrPass", EncyCurrPass);
                dbSqlCommand.Parameters.AddWithValue("@NewPass", NewPass);
                dbSqlCommand.Parameters.AddWithValue("@EncyNewPass", EncyNewPass);
                dbSqlCommand.Parameters.AddWithValue("@Tran_Type", flag);
                dbSqlAdapter.SelectCommand = dbSqlCommand;
                dbSqlAdapter.Fill(SqlDataTable);

                return SqlDataTable;
            }
            catch (Exception ex)
            {
                return SqlDataTable = null;
            }
        }


        public bool checkauthenticationA()
        {
            try
            {

                if (Convert.ToString(HttpContext.Current.Session["EmployeeID"]) != "" && Convert.ToString(HttpContext.Current.Session["EmployeeID"]) != null)
                {
                    return true;
                }
                else { return false; }
            }
            catch (SqlException e)
            {
                return false;
            }
            finally

            {

            }
        }


        public DataTable FillSelectDistict(string Dist)
        {
           
            string SqlQuery = "";

            SqlQuery = "select DistrictCode, DistrictName  from JSLPSMIS.dbo.tblMstDistrict where " + Dist + " order by DistrictName";

            SqldbDataTable = GetResultFromSqlQur(SqlQuery);
            return SqldbDataTable;
        }

        public DataTable FillSelectBlock(string ddlDist, string Block)
        {
           
            string SqlQuery = "";
            SqlQuery = "";
            //if (ddlDist == "0" || ddlDist == null || ddlDist == "")
            //{
            //    SqlQuery = "Select Blockcode,BlockName from tblMstBlock  where 1!=1 order by BlockName";
            //}
            //else
            //{
            SqlQuery = "Select Blockcode, BlockName from JSLPSMIS.dbo.tblMstBlock where DistrictCode=" + ddlDist + " " + Block + " order by BlockName";
            //}

            SqldbDataTable = GetResultFromSqlQur(SqlQuery);
            return SqldbDataTable;
        }

        public DataTable GetFYear()
        {
            
            string SqlQuery = "";

            SqlQuery = "select FYear from tblFinancialYear where IsActive=1";

            SqldbDataTable = GetResultFromSqlQur(SqlQuery);
            return SqldbDataTable;
        }

        public DataTable GetDesignation(string whr)
        {
            
            string SqlQuery = "";

            SqlQuery = "select ID as Post_ID,Designation as Position from tblDesignationMaster " + whr;

            SqldbDataTable = GetResultFromSqlQur(SqlQuery);
            return SqldbDataTable;
        }
        public DataTable GetDomain( string FYear)
        {

            string SqlQuery = "";

            SqlQuery = "select DID,DomainSName from mstDomain where isActive=1 and FYear='"+ FYear + "' order by DomainSName";

            SqldbDataTable = GetResultFromSqlQur(SqlQuery);
            return SqldbDataTable;
        }


        //public DataTable GetKPIDomain(string FYear)
        //{
        //    string SqlQuery = "";
        //    SqlQuery = "select distinct t1.DomainID,t2.DomainSName from tblKRA_Master t1 inner join MstDomain t2 on t2.DID=t1.DomainID and t2.FYear=t1.FYear  " + FYear + " order by t2.DomainSName";

        //    SqldbDataTable = GetResultFromSqlQur(SqlQuery);
        //    return SqldbDataTable;
        //}

        public DataTable GetKRA(string whr)
        {

            string SqlQuery = "";

            SqlQuery = "select ID,KRA from tblKRA_Master" + whr;

            SqldbDataTable = GetResultFromSqlQur(SqlQuery);
            return SqldbDataTable;
        }

        public DataTable GetResultFromSqlQur(String strQur)
        {
            SqlDataAdapter dbSqlAdapter = new SqlDataAdapter();
            SqlCommand dbSqlCommand = new SqlCommand();
            DataTable dbSqlDataTable = new DataTable();
            try
            {
                if (this.ConnectionFactory.State == ConnectionState.Closed)
                {
                    this.ConnectionFactory.Open();
                }
                dbSqlDataTable = null;



                dbSqlDataTable = new DataTable();
                dbSqlCommand.Connection = ConnectionFactory;
                dbSqlCommand.Parameters.Clear();
                dbSqlCommand.CommandType = CommandType.Text;
                dbSqlCommand.CommandText = strQur;
                dbSqlAdapter.SelectCommand = dbSqlCommand;
                dbSqlCommand.CommandTimeout = 1000000;
                dbSqlAdapter.Fill(dbSqlDataTable);

                return dbSqlDataTable;

            }
            catch (SqlException sqlEx)
            {
                if (!(this.ConnectionFactory.State == ConnectionState.Closed))
                {
                    this.ConnectionFactory.Close();
                }
                throw sqlEx;
            }
            catch (Exception ex1)
            {
                if (!(this.ConnectionFactory.State == ConnectionState.Closed))
                {
                    this.ConnectionFactory.Close();
                }
                throw ex1;
            }
            finally
            {
                if (!(this.ConnectionFactory.State == ConnectionState.Closed))
                {
                    this.ConnectionFactory.Close();
                }
            }
        }

        public int update_password(string current_apssword, string password, string username, string loginID, int OTP, string flag)
        {

            try
            {
                if (ConnectionFactory.State == ConnectionState.Closed)
                {
                    ConnectionFactory.Open();
                }
                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.Connection = ConnectionFactory;
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.CommandText = "SP_Update_forgotpass";
                sqlcmd.Parameters.AddWithValue("@current_password", current_apssword);
                sqlcmd.Parameters.AddWithValue("@pass_word", password);
                sqlcmd.Parameters.AddWithValue("@user_name", username);
                sqlcmd.Parameters.AddWithValue("@login_ID", loginID);
                sqlcmd.Parameters.AddWithValue("@OTP", OTP);
                sqlcmd.Parameters.AddWithValue("@flag", flag);
                System.Data.SqlClient.SqlParameter pRowsaffect = new SqlParameter("@result", System.Data.SqlDbType.Int);
                pRowsaffect.Direction = System.Data.ParameterDirection.Output;
                sqlcmd.Parameters.Add(pRowsaffect);

                try
                {
                    sqlcmd.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    ConnectionFactory.Close();
                    return -1;

                }
                return Convert.ToInt32(pRowsaffect.Value);

            }
            catch (Exception _ex)
            {
                ConnectionFactory.Close();
                return -1;

            }
        }


        public DataTable GetReportData(string Where, string Flag, string procedureName)
        {

            DataTable dt = new DataTable();
            try
            {

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter ad = new SqlDataAdapter();
                cmd.Connection = ConnectionFactory;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "Sp_HRAReports";

                cmd.Parameters.AddWithValue("@Where", Where);
                cmd.Parameters.AddWithValue("@Flag", Flag);
                ad.SelectCommand = cmd;
                cmd.CommandTimeout = 9999999;
                ad.Fill(dt);

                return dt;

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public DataTable GetAssesementPoints()
        {

            string SqlQuery = "";

            SqlQuery = "select id, Points from tblAssessmentPoints where Isactive=1";

            SqldbDataTable = GetResultFromSqlQur(SqlQuery);
            return SqldbDataTable;
        }
        public DataTable GetEmployee(string EmployeeID)
        {
            string SqlQuery = "";
            SqlQuery = " select* from tblSuperviosor_Master a inner join tblUserMaster b  on a.EmployeeID = b.EmployeeID where a.SuperviosorID=" + EmployeeID + " and b.IsActive = 1";

            SqldbDataTable = GetResultFromSqlQur(SqlQuery);
            return SqldbDataTable;
        }
    }
}