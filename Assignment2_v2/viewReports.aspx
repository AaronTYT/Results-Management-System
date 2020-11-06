<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewReports.aspx.cs" Inherits="Assignment2_v2.viewReports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Reports</title>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link rel="stylesheet" href="main.css" type="text/css"/>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        </style>
</head>
<body>
    
    <div class="auto-style1">
    
    <div class="container">
        <form runat="server">
            <div class="auto-style1" aria-hidden="False">
            <h1>View Reports</h1>
            <h1><i class="fa fa-search"></i></h1>
            <asp:LinkButton ID="manageResultsLink" runat="server" OnClick="manageResultsLink_Click">Manage Results</asp:LinkButton>&nbsp;
                <asp:LinkButton ID="LinkStudent" runat="server" OnClick="LinkStudent_Click">Manage Students</asp:LinkButton>
            <br /><br />
            <strong>Welcome Manager!</strong><br />
                
            <asp:LinkButton ID="LogoutLink" runat="server" OnClick="LogoutLink_Click">Logout</asp:LinkButton>
            <br />
            <br />
            <hr />
            <h2>Search Options</h2>

            <div class="row">
                <!-- Student ID -->
                <div class="col-30">
                    <asp:Label ID="Label1" runat="server" Text="Student ID"></asp:Label>
                </div>

                <div class="col-60">
                    <asp:DropDownList AppendDataBoundItems="true" ID="StudentDrop" runat="server" DataSourceID="GetStudent" DataTextField="studentID" DataValueField="studentID" Width="225px">
                        <asp:ListItem Selected="True" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
           </div>
           <br />

           <div class="row">
                <!-- Unit Code -->
                <div class="col-30">
                    <asp:Label ID="Label2" runat="server" Text="Unit Code"></asp:Label>
                </div>

                <div class="col-60">
                    <asp:DropDownList ID="unitDrop" AppendDataBoundItems="true" runat="server" DataSourceID="GetUnitCode" DataTextField="unitCode" DataValueField="unitCode" Width="225px">
                        <asp:ListItem Selected="True" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
           </div>
           <br />

           <div class="row">
                <!-- Semester -->
                <div class="col-30">
                    <asp:Label ID="semesterlbl" runat="server" Text="Semester"></asp:Label>
                </div>

               <div class="col-60">
                   <asp:DropDownList ID="semesterDrop" runat="server">
                        <asp:ListItem Selected="True" Value=""></asp:ListItem>
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                    </asp:DropDownList>
                </div>
           </div>
           <br />

           <div class="row">
                <!-- Year -->
                <div class="col-30">
                    <asp:Label ID="yearlbl" runat="server" Text="Year"></asp:Label>
                </div>

               <div class="col-60">
                   <asp:TextBox ID="yearTxt" runat="server" Width="225px" placeholder="eg. 2019" MaxLength="4"></asp:TextBox>
                </div>
           </div>

            <br />
                <asp:Button ID="searchBtn" runat="server" CssClass="loginBtn" OnClick="search_Click" Text="Search" />
            <br />
                <asp:SqlDataSource ID="GetUnitCode" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnection %>" SelectCommand="SELECT [unitCode] FROM [units]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="GetStudent" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnection %>" SelectCommand="SELECT [studentID] FROM [students]"></asp:SqlDataSource>
                <br />
            <br />
                
            </div>
     </div>
        <asp:Label ID="lblResultText" runat="server"></asp:Label><br />
        <asp:Label ID="lblList" runat="server"></asp:Label>
        <br />
        <strong>
        <asp:Label ID="lblCount" runat="server"></asp:Label>
        </strong>
        <br />
        <strong>
        <asp:Label ID="lblAllAvg" runat="server"></asp:Label>
        </strong>
    <br />
        <asp:GridView ID="gvSearch" runat="server" AllowSorting="True" OnSorting="gvSearch_Sorting">
            <Columns>
                <asp:TemplateField HeaderText="Unit Score">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblUnitScore" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Grade">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    <br />
    
        <div class="auto-style1">
        </form>
            
    </div>

    </div>

</body>
</html>
