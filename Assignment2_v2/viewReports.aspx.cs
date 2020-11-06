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
    public partial class viewReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void manageResultsLink_Click(object sender, EventArgs e)
        {
            Response.Redirect("manageResults.aspx");
        }

        protected void LinkStudent_Click(object sender, EventArgs e)
        {
            Response.Redirect("manageStudents.aspx");
        }

        protected void LogoutLink_Click(object sender, EventArgs e)
        {
            Session["user"] = null;
            Response.Redirect("login.aspx");
        }


        string calculateGrade(int totalMark)
        {
            if(totalMark < 50)
            {
                return "N";
            }
            else if(totalMark < 60)
            {
                return "C";
            }
            else if(totalMark < 70)
            {
                return "CR";
            }
            else if(totalMark < 80)
            {
                return "D";
            }
            else
            {
                return "HD";
            }
        }


        int validation()
        {
            if (String.IsNullOrEmpty(yearTxt.Text))
            {
                return 0;
            }

            if(!int.TryParse(yearTxt.Text, out int isNum))
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        int errorCode = 0;
        List<int> resultID = new List<int>();
        protected void search_Click(object sender, EventArgs e)
        {
            errorCode = validation();
            if(errorCode == 1)
            {
                Response.Write("<script language=javascript>alert('Please enter the year as digits.')</script>");
            }
            else
            {
                string connStr = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    List<string> list = new List<string>();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandText = "spResults";
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlCommand cmd2 = new SqlCommand();
                    cmd2.Connection = con;
                    cmd2.CommandText = "spOnlyResults";
                    cmd2.CommandType = CommandType.StoredProcedure;

                    SqlCommand cmd3 = new SqlCommand();
                    cmd3.Connection = con;
                    cmd3.CommandText = "spSearchCount";
                    cmd3.CommandType = CommandType.StoredProcedure;

                    SqlCommand cmd4 = new SqlCommand();
                    cmd4.Connection = con;
                    cmd4.CommandText = "spSearchScores";
                    cmd4.CommandType = CommandType.StoredProcedure;

                    if (!String.IsNullOrEmpty(StudentDrop.SelectedValue))
                    {
                        SqlParameter param = new SqlParameter("@studentID", StudentDrop.SelectedValue);
                        cmd.Parameters.Add(param);

                        SqlParameter param2 = new SqlParameter("@studentID", StudentDrop.SelectedValue);
                        cmd2.Parameters.Add(param2);

                        SqlParameter param3 = new SqlParameter("@studentID", StudentDrop.SelectedValue);
                        cmd3.Parameters.Add(param3);

                        SqlParameter param4 = new SqlParameter("@studentID", StudentDrop.SelectedValue);
                        cmd4.Parameters.Add(param4);

                        list.Add("Student ID: " + StudentDrop.SelectedValue);
                    }

                    if (unitDrop.SelectedValue != "")
                    {
                        SqlParameter param = new SqlParameter("@unitCode", unitDrop.SelectedValue);
                        cmd.Parameters.Add(param);

                        SqlParameter param2 = new SqlParameter("@unitCode", unitDrop.SelectedValue);
                        cmd2.Parameters.Add(param2);

                        SqlParameter param3 = new SqlParameter("@unitCode", unitDrop.SelectedValue);
                        cmd3.Parameters.Add(param3);

                        SqlParameter param4 = new SqlParameter("@unitCode", unitDrop.SelectedValue);
                        cmd4.Parameters.Add(param4);


                        list.Add("Unit Code: " + unitDrop.SelectedValue);
                    }

                    if (semesterDrop.SelectedValue != "")
                    {
                        SqlParameter param = new SqlParameter("@semester", semesterDrop.SelectedValue);
                        cmd.Parameters.Add(param);

                        SqlParameter param2 = new SqlParameter("@semester", semesterDrop.SelectedValue);
                        cmd2.Parameters.Add(param2);

                        SqlParameter param3 = new SqlParameter("@semester", semesterDrop.SelectedValue);
                        cmd3.Parameters.Add(param3);

                        SqlParameter param4 = new SqlParameter("@semester", semesterDrop.SelectedValue);
                        cmd4.Parameters.Add(param4);

                        list.Add("Semester: " + semesterDrop.SelectedValue);
                    }

                    if (yearTxt.Text.Trim() != "")
                    {
                        SqlParameter param = new SqlParameter("@yr", yearTxt.Text);
                        cmd.Parameters.Add(param);

                        SqlParameter param2 = new SqlParameter("@yr", yearTxt.Text);
                        cmd2.Parameters.Add(param2);

                        SqlParameter param3 = new SqlParameter("@yr", yearTxt.Text);
                        cmd3.Parameters.Add(param3);

                        SqlParameter param4 = new SqlParameter("@yr", yearTxt.Text);
                        cmd4.Parameters.Add(param4);

                        list.Add("Year: " + yearTxt.Text);
                    }

                    con.Open();

                    //Display the spResults procedure
                    SqlDataReader rdr = cmd.ExecuteReader();
                    gvSearch.DataSource = rdr;
                    gvSearch.DataBind();

                    con.Close();


                    con.Open();


                    con.Close();
                    con.Open();
                    //Count how many rows does the results has from the query
                    int numRows = Convert.ToInt32(cmd3.ExecuteScalar());

                    if (numRows == 0)
                    {
                        lblResultText.Text = "Sorry, no results have been found";
                        lblList.Text = "";
                        lblCount.Text = "";
                        lblAllAvg.Text = "";
                    }
                    else
                    {

                        int totalMark = Convert.ToInt32(cmd4.ExecuteScalar());                       
                        con.Close();
                        
                        if (StudentDrop.SelectedValue == "" && unitDrop.SelectedValue == "" && semesterDrop.SelectedValue == "" && yearTxt.Text == "")
                        {
                            lblResultText.Text = "Search results for everything";
                            lblList.Text = "";
                            lblCount.Text = "Found " + numRows + " results!";

                            int averageMarks = totalMark / numRows;
                            lblAllAvg.Text = "Class Average: " + averageMarks.ToString() + " (" + calculateGrade(averageMarks) + ")";
                        }
                        else
                        {
                            if(StudentDrop.SelectedValue.Length > 0)
                            {
                                lblResultText.Text = "Search results for: " + StudentDrop.SelectedValue.ToString();
                                lblCount.Text = "Found " + numRows + " units!";
                                int averageMarks = totalMark / numRows;
                                lblAllAvg.Text =  "Student ID: "+ StudentDrop.SelectedValue.ToString() + " average: " + averageMarks.ToString() + " (" + calculateGrade(averageMarks) + ")";
                            }
                            else
                            {
                                lblResultText.Text = "Search results for: ";
                                lblCount.Text = "Found " + numRows + " results!";
                                foreach (string search in list)
                                {
                                    lblList.Text = "\u2022 " + search + "<br>";
                                }

                                int averageMarks = totalMark / numRows;
                                lblAllAvg.Text = "Class Average: " + averageMarks.ToString() + " (" + calculateGrade(averageMarks) + ")";
                            }
                        }
                    }
                }
            }
        }

        public SortDirection SortDir
        {
            get
            {
                if (ViewState["SortDir"] == null)
                {
                    ViewState["SortDir"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["SortDir"];

            }
            set
            {
                ViewState["SortDir"] = value;
            }
        }

        private DataTable getDataTable()
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["dbconnection"].ToString();

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "spResults";
            cmd.CommandType = CommandType.StoredProcedure;

            if (!String.IsNullOrEmpty(StudentDrop.SelectedValue))
            {
                SqlParameter param = new SqlParameter("@studentID", StudentDrop.SelectedValue);
                cmd.Parameters.Add(param);
            }

            if (unitDrop.SelectedValue != "")
            {
                SqlParameter param = new SqlParameter("@unitCode", unitDrop.SelectedValue);
                cmd.Parameters.Add(param);
            }

            if (semesterDrop.SelectedValue != "")
            {
                SqlParameter param = new SqlParameter("@semester", semesterDrop.SelectedValue);
                cmd.Parameters.Add(param);
            }


            if (yearTxt.Text.Trim() != "")
            {
                SqlParameter param = new SqlParameter("@yr", yearTxt.Text);
                cmd.Parameters.Add(param);
            }

            con.Open();
    
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];

        }

        protected void gvSearch_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExp = e.SortExpression;
            string direction = string.Empty;
            if (SortDir == SortDirection.Ascending)
            {
                SortDir = SortDirection.Descending;
                direction = "DESC";
            }
            else
            {
                SortDir = SortDirection.Ascending;
                direction = "ASC";
            }
            DataTable dt = getDataTable();
            dt.DefaultView.Sort = sortExp + " " + direction;
            gvSearch.DataSource = dt;
            gvSearch.DataBind();
        }
    }
}