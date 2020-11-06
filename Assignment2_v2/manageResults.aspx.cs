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
    public partial class manageResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //If the user goes straight to manageResults.aspx without login, redirect back to the login.aspx
                if (Session["user_session_key"] == null)
                    Response.Redirect("login.aspx");

                //If the admin goes straight to manageResults.aspx, redirect back to their main page (manageUnits.aspx)
                if(Session["user_session_key"].ToString() == "0")
                {
                    Response.Redirect("manageUnits.aspx");
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
                AddResult.Insert();
                showResultGrid.DataBind();
            }

            int validation()
            {
                //studentID validate
                if (DropDownStudent.SelectedItem.Text == "Select a Student ID")
                {
                    studentIDError.Text = "Select a student";
                    studentIDError.Visible = true;
                    DropDownStudent.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else
                {
                    studentIDError.Text = "";
                    studentIDError.Visible = false;
                    DropDownStudent.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }

                //unitCode validate
                if (unitCodeDrop.SelectedItem.Text=="Select a Unit Code") {
                    unitCodeError.Text = "Select a Unit Code";
                    unitCodeError.Visible = true;
                    unitCodeDrop.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else
                {
                    unitCodeError.Text = "";
                    unitCodeError.Visible = false;
                    unitCodeDrop.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }                

                //semester validate
                if (semester.SelectedItem.Text == "")
                {
                    semesterError.Text = "Select a semester";
                    semesterError.Visible = true;
                    semester.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else
                {
                    semesterError.Text = "";
                    semesterError.Visible = false;
                    semester.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }

                //int yearValue = int.Parse(yearTxt.Text);
                //year validate
                if (!Int32.TryParse(yearTxt.Text, out int yearInt))
                {
                    yearError.Text = "Year has to be an integer";
                    yearError.Visible = true;
                    yearTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else if (yearTxt.Text.Length < 4)
                {
                    yearError.Text = "Year has to be 4 digits long";
                    yearError.Visible = true;
                    yearTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else if (int.Parse(yearTxt.Text) < 1900 || int.Parse(yearTxt.Text) > 2200)
                {
                    yearError.Text = "Enter the year between 1900-2200";
                    yearError.Visible = true;
                    yearTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else
                {
                    yearError.Text = "";
                    yearError.Visible = false;
                    yearTxt.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }

                //assessment1 validate
                if (!Int32.TryParse(assessment1Txt.Text, out int assessment1Int))
                {
                    assessment1Error.Text = "Assessment 1 has to be an integer";
                    assessment1Error.Visible = true;
                    assessment1Txt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else if (assessment1Int < 0 || assessment1Int > 20)
                {
                    assessment1Error.Text = "Enter between 0 - 20";
                    assessment1Error.Visible = true;
                    assessment1Txt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else
                {
                    assessment1Error.Text = "";
                    assessment1Error.Visible = false;
                    assessment1Txt.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }

                //assessment2 validate
                if (!Int32.TryParse(assessment2Txt.Text, out int assessment2Int))
                {
                    assessment2Error.Text = "Assessment 2 has to be an integer";
                    assessment2Error.Visible = true;
                    assessment2Txt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else if (assessment2Int < 0 || assessment2Int > 20)
                {
                    assessment2Error.Text = "Enter between 0 - 20";
                    assessment2Error.Visible = true;
                    assessment2Txt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else
                {
                    assessment2Error.Text = "";
                    assessment2Error.Visible = false;
                    assessment2Txt.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }

                //exam validate
                if (!Int32.TryParse(examTxt.Text, out int examInt))
                {
                    examError.Text = "Exam has to be an integer";
                    examError.Visible = true;
                    examTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else if (examInt < 0 || examInt > 60)
                {
                    examError.Text = "Enter between 0 - 60";
                    examError.Visible = true;
                    examTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else
                {
                    examError.Text = "";
                    examError.Visible = false;
                    examTxt.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }

                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);
                SqlCommand cmd = new SqlCommand("SELECT * FROM results", conn);

                SqlDataReader resultsCheck;
                conn.Open();
                resultsCheck = cmd.ExecuteReader();

                string studentIDR = "";
                string unitCodeR = "";
                string semesterR = "";
                string yearR = "";

                while (resultsCheck.Read())
                {
                    studentIDR = resultsCheck["studentID"].ToString();
                    unitCodeR = resultsCheck["unitCode"].ToString();
                    semesterR = resultsCheck["semester"].ToString();
                    yearR = resultsCheck["yr"].ToString();


                    if (DropDownStudent.SelectedItem.Text == studentIDR
                        && unitCodeDrop.SelectedItem.Text == unitCodeR
                        && semester.SelectedItem.Text == semesterR
                        && yearTxt.Text == yearR)
                    {
                        studentIDError.Text = "Cannot duplicate this data";
                        studentIDError.Visible = true;
                        DropDownStudent.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);

                        unitCodeError.Text = "Cannot duplicate this data";
                        unitCodeError.Visible = true;
                        unitCodeDrop.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);

                        semesterError.Text = "Cannot duplicate this data";
                        semesterError.Visible = true;
                        semester.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);

                        yearError.Text = "Cannot duplicate this data";
                        yearError.Visible = true;
                        yearTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                        return 1;
                    }
                }
              
                if (errorCode == 1)
                {
                    return 1;
                }
                else
                {
                    return 0;
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

                    DropDownStudent.SelectedValue = "Select a Student ID";
                    unitCodeDrop.SelectedValue = "Select a Unit Code";
                    semester.SelectedValue = "";
                   
                    yearTxt.Text = "";
                    assessment1Txt.Text = "";
                    assessment2Txt.Text = "";
                    examTxt.Text = "";
                }
            }
            main();
        }

        protected void LogoutLink_Click(object sender, EventArgs e)
        {
            Session["user"] = null;
            Response.Redirect("login.aspx");
        }

        protected void StudentLink_Click(object sender, EventArgs e)
        {
            Response.Redirect("manageStudents.aspx");
        }

        protected void showResultGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = (GridViewRow)showResultGrid.Rows[e.RowIndex];
            Label lbldeleteid = (Label)row.FindControl("lblResultID");

            string x = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(x);
            conn.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM results WHERE resultID='" + Convert.ToInt32(showResultGrid.DataKeys[e.RowIndex].Value.ToString()) + "'", conn);
            cmd.ExecuteNonQuery();
            conn.Close();
            message.ForeColor = System.Drawing.Color.FromArgb(0, 0, 193, 45);
            message.Text = "Successfully deleted.";
        }

        protected void Report_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewReports.aspx");
        }
    }
}