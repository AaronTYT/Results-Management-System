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
    public partial class manageStudents : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string x = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //If the user goes straight to manageResults.aspx without login, redirect back to the login.aspx
                if (Session["user_session_key"] == null)
                    Response.Redirect("login.aspx");

                //If the admin user goes straight to manageStudents.aspx, redirect back to their main page (manageUnits.aspx)
                if (Session["user_session_key"].ToString() == "0")
                {
                    Response.Redirect("manageUnits.aspx");
                }

            }
            catch (Exception ee)
            {
                Response.Write(ee.ToString());

            }

            if (!IsPostBack)
            {
                ImageData();
            }
        }

        protected void ImageData()
        {
            conn = new SqlConnection(x);
            conn.Open();
            da = new SqlDataAdapter("SELECT * FROM students", conn);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void manageResultsLink_Click(object sender, EventArgs e)
        {
            Response.Redirect("manageResults.aspx");
        }

        protected void LogoutLink_Click(object sender, EventArgs e)
        {
            Session["user"] = null;
            Response.Redirect("login.aspx");
        }


        protected void addBtn_Click(object sender, EventArgs e)
        {
            int errorCode = 0;

            int validation()
            {
                //Validate for studentID
                if(studentIDTxt.Text == "")
                {
                    studentIDError.Text = "Student ID cannot be blank";
                    studentIDError.Visible = true;
                    studentIDTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }


                else if (!Int32.TryParse(studentIDTxt.Text, out int studentInt))
                {
                    studentIDError.Text = "Student ID has to be an integer";
                    studentIDError.Visible = true;
                    studentIDTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else if (studentIDTxt.Text.Length < 8)
                {
                    studentIDError.Text = "Student ID has to be 8 digits long";
                    studentIDError.Visible = true;
                    studentIDTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                    errorCode = 1;
                }
                else
                {
                    //Checking if its the same studentID.
                    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);
                    SqlCommand cmd = new SqlCommand("SELECT studentID FROM students", conn);

                    SqlDataReader studentData;
                    conn.Open();
                    studentData = cmd.ExecuteReader();

                    while (studentData.Read())
                    {
                        if (studentData["studentID"].ToString() == studentIDTxt.Text)
                        {
                            studentIDError.Text = "Student ID exists!";
                            studentIDError.Visible = true;
                            studentIDTxt.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                            return 1;
                        }
                    }

                    studentIDError.Text = "";
                    studentIDError.Visible = false;
                    studentIDTxt.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                }

                //Validate for picture
                if (photoUpload.HasFile)
                {
                    HttpPostedFile postedFile = photoUpload.PostedFile;
                    string fileName = Path.GetExtension(postedFile.FileName);
                    string fileExtension = Path.GetFileName(fileName);

                    if(fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".bmp" || fileExtension.ToLower() == ".png")
                    {
                        ;
                    }
                    else
                    {
                        photoError.Text = "Upload either a jpg, bmp or png file";
                        photoError.Visible = true;
                        photoUpload.BorderColor = System.Drawing.Color.FromArgb(0, 0, 0, 0);
                        errorCode = 1;
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
                //Finish validation
            }


            void addData()
            {
                try
                {
                    if (photoUpload.HasFile)
                    {
                        string fileName = Path.GetFileName(photoUpload.PostedFile.FileName);
                        photoUpload.SaveAs(Server.MapPath("StudentImages/" + fileName));
                        conn = new SqlConnection(x);
                        conn.Open();
                        cmd = new SqlCommand("INSERT INTO students (studentID, photo) VALUES (@studentID, @path)", conn);
                        cmd.Parameters.AddWithValue("@studentID", studentIDTxt.Text);
                        cmd.Parameters.AddWithValue("@path", "StudentImages/" + fileName);
                        cmd.ExecuteNonQuery();
                        ImageData();
                    }
                    else
                    {
                        conn = new SqlConnection(x);
                        conn.Open();
                        cmd = new SqlCommand("INSERT INTO students (studentID) VALUES (@studentID)", conn);
                        cmd.Parameters.AddWithValue("@studentID", studentIDTxt.Text);
                      
                        cmd.ExecuteNonQuery();
                        ImageData();
                    }
                    
                }
                catch (Exception ex)
                {
                    message.Text = ex.Message;
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
                    studentIDTxt.Text = "";
                }
            }

            main();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            ImageData();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                //find image id of edit row    
                string id = GridView1.DataKeys[e.RowIndex].Value.ToString();
                // find values for update    
                FileUpload FileUpload1 = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("FileUpload1");
                conn = new SqlConnection(x);
                string path = "StudentImages/";
                if (FileUpload1.HasFile)
                {
                    path += FileUpload1.FileName;
                    //save image in folder    
                    FileUpload1.SaveAs(MapPath(path));
                }
                else
                {
                    // use previous user image if new image is not changed    
                    Image img = (Image)GridView1.Rows[e.RowIndex].FindControl("img_user");
                    path = img.ImageUrl;
                }
                SqlCommand cmd = new SqlCommand("UPDATE students SET photo='" + path + "' WHERE studentID=" + id + "", conn);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                GridView1.EditIndex = -1;
                ImageData();
                message.ForeColor = System.Drawing.Color.FromArgb(0, 0, 193, 45);
                message.Text = "Sucessfully updated";
            }
            catch (Exception ex)
            {
                message.Text = ex.Message;
            }
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            ImageData();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
            Label lbldeleteid = (Label)row.FindControl("lblImgId");
            Label lblDeleteImageName = (Label)row.FindControl("lblImageName");
            conn = new SqlConnection(x);
            conn.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM students WHERE studentID='" + Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString()) + "'", conn);
            cmd.ExecuteNonQuery();
            conn.Close();
            message.ForeColor = System.Drawing.Color.FromArgb(0, 0, 193, 45);
            message.Text = "Successfully deleted.";
            ImageData();
        }

        protected void LinkReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewReports.aspx");
        }
    }
}