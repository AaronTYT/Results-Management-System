using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text.RegularExpressions;

namespace Assignment2_v2
{
    public partial class manageUnits : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //If the user goes straight to manageUnits.aspx without login, redirect back to the login.aspx
                if (Session["user_session_key"] == null)
                    Response.Redirect("login.aspx");

                //If the manager user goes straight to manageUnits.aspx, redirect back to their manageReuslts.aspx
                if (Session["user_session_key"].ToString() == "1")
                {
                    Response.Redirect("manageResults.aspx");
                }
            }
            catch (Exception ee)
            {
                Response.Write(ee.ToString());
            }
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            int errorCode = 0;

            void addData()
            {
                AddUnit.Insert();
                showUnitGrid.DataBind();
            }


            int validation()
            {

                string unitCode = Request.Form["unitCodeTxt"].Trim();
                string unitTitle = Request.Form["unitTitleTxt"].Trim();
                string unitCor = Request.Form["unitCorTxt"];

                string patternUnitCode = @"^[A-Z]{1,3}[0-9]{4,7}";

                if (unitCode.Length == 0)
                {
                    unitCodeError.Text = "Missing UnitCode";
                    unitCodeError.Visible = true;
                    unitCodeTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);

                }
                else if (!Regex.IsMatch(unitCode, patternUnitCode))
                {
                    unitCodeError.Text = "3 capalised letters and 4 numbers only";
                    unitCodeError.Visible = true;
                    unitCodeTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                }
                else
                {
                    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);
                    SqlCommand cmd = new SqlCommand("SELECT unitCode FROM units", conn);

                    SqlDataReader unitsData;
                    conn.Open();
                    unitsData = cmd.ExecuteReader();

                    while (unitsData.Read())
                    {
                        if (unitsData["unitCode"].ToString() == unitCodeTxt.Text)
                        {
                            unitCodeError.Text = "Unit Code exists!";
                            unitCodeTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                            return 1;
                        }
                    }

                    unitCodeError.Text = "";
                    message.Text = "";
                    unitCodeError.Visible = false;
                    unitCodeTxt.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }

                if (unitTitle.Length == 0)
                {
                    unitTitleError.Text = "Missing Unit Title";
                    message.Text = "";
                    unitTitleError.Visible = true;
                    unitTitleTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                }
                else
                {
                    unitTitleError.Text = "";
                    unitTitleError.Visible = false;
                    unitTitleTxt.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }

                if (fileUpload.HasFile)
                {
                    string ext = "";
                    ext = Path.GetExtension(fileUpload.PostedFile.FileName);
                    if (ext.ToLower() == ".docx" || ext.ToLower() == ".pdf" || ext.ToLower() == ".doc")
                    {
                        int fileSize = fileUpload.PostedFile.ContentLength;
                        if(fileSize > 2097152)
                        {
                            message.Text = "Maximum file size (2MB) exceeded";
                            message.ForeColor = System.Drawing.Color.Red;
                        }
                        else
                        {
                            fileUpload.SaveAs(Server.MapPath("~/Uploads/" + fileUpload.FileName));

                        }
                    }
                    else
                    {
                        fileError.Text = "Upload either pdf, docx or doc";
                    }

                }

                if (unitCodeError.Text == "" && unitTitleError.Text == "")
                {
                    return 0;
                }
                else
                {
                    return 1;
                }
            }


            void main()
            {
                errorCode = validation();
                if (errorCode == 1)
                {
                    message.ForeColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    message.Text = "Unsucessful! Please fix the following errors shown above";
                }
                else
                {
                    addData();
                    message.ForeColor = System.Drawing.Color.FromArgb(0, 0, 193, 45);
                    message.Text = "Successful!";

                    unitCodeTxt.Text = "";
                    unitTitleTxt.Text = "";
                    unitCorTxt.Text = "";
                }
            }
            main();
        }

        protected void LogoutLink_Click(object sender, EventArgs e)
        {
            Session["user"] = null;
            Response.Redirect("login.aspx");
        }

        protected void showUnitGrid_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            message.ForeColor = System.Drawing.Color.FromArgb(0, 0, 193, 45);
            message.Text = "Successfully deleted";
        }

        protected void showUnitGrid_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            message.ForeColor = System.Drawing.Color.FromArgb(0, 0, 193, 45);
            message.Text = "Successfully updated";
        }
    }
}