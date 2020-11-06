using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment2_v2
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginBtn_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);
            SqlCommand cmd = new SqlCommand("SELECT * FROM users WHERE userEmail=@username AND userPassword = @password", conn);
            cmd.Parameters.AddWithValue("@username", username.Text.ToLower());
            cmd.Parameters.AddWithValue("@password", password.Text);

            SqlDataReader loginCheck;
            conn.Open();
            loginCheck = cmd.ExecuteReader();

            if (loginCheck.Read())
            {
                string username = loginCheck["userEmail"].ToString();
                Session["user_session_key"] = username;

                if (loginCheck["userType"].ToString() == "0")
                {
                    Session["user_session_key"] = "0";
                    Response.Redirect("manageUnits.aspx");
                }

                if (loginCheck["userType"].ToString() == "1")
                {
                    Session["user_session_key"] = "1";
                    Response.Redirect("manageResults.aspx");
                }

            }
            else
            {
                username.Text = "";
                loginError.Visible = true;
                username.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
                password.BorderColor = System.Drawing.Color.FromArgb(0, 255, 0, 0);
            }
        }
    }
}