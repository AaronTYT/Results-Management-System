<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Assignment2_v2.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CPA Login</title>
    <link rel="stylesheet" href="main.css" type="text/css" />
    <style type="text/css">
        .login {
            text-align: center;
        }
        .auto-style1 {
            font-size: xx-large;
        }
        .auto-style2 {
            font-size: x-large;
        }
    </style>
</head>
<body>
    <h1 style="align-content: center" class="auto-style1">&nbsp;</h1>
    <h1 style="align-content: center" class="login">Rapid Management System Login</h1>
    
    <form id="form1" runat="server">
        <div class="login">

            <asp:Label ID="loginError" runat="server" Text="Invalid username and/or password!" Visible="False" ForeColor="Red" CssClass="auto-style2"></asp:Label><br />
            <asp:TextBox ID="username" CssClass="username" placeholder="username" runat="server"></asp:TextBox><br /> <br />
            <asp:TextBox ID="password" CssClass="password" TextMode="Password" placeholder="password" runat="server"></asp:TextBox>
                <br />
                <br />

            <!--loginBtn_Click -->
        <asp:Button ID="loginBtn" CssClass="loginBtn" runat="server" Text="Login" OnClick="loginBtn_Click"/>

        </div>

    </form>
            
</body>
</html>