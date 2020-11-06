<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manageUnits.aspx.cs" Inherits="Assignment2_v2.manageUnits" %>

<!DOCTYPE html>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Data.SqlClient" %>
<%@ Import namespace="System.Configuration" %>
<%@ Import namespace="System.IO"%>

<script runat="server">

    protected void btnClear_Click(object sender, EventArgs e)
    {
       Response.Redirect("manageUnits.aspx");
    }
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link rel="stylesheet" href="main.css" type="text/css" />
    <title>Manage Units</title>
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
            <h1 style="text-align:center">Manage Units</h1>
            <h1><i class="fa fa-book" style="color:darkorange;"></i></h1>
            <strong>Welcome Admin!</strong><br />
            <asp:LinkButton ID="LogoutLink" runat="server" OnClick="LogoutLink_Click">Logout</asp:LinkButton>
            <div class="auto-style1">
                <!-- UnitCode -->
                <div class="row">
                    <div class="col-20">
                        <asp:Label ID="unitCodeLbl" runat="server" Text="Unit Code"></asp:Label>
                    </div>

                    <div class="col-40">
                        <asp:TextBox ID="unitCodeTxt" runat="server" Width="225px" placeholder="eg. CSI2241" MaxLength="7"></asp:TextBox>
                    </div>

                    <div class="col-10">
                        <asp:Label runat="server" Text="*" ForeColor="Red" ></asp:Label>
                    </div>

                    <div class="col-30">
                        <asp:Label ID="unitCodeError" runat="server" ForeColor="Red"></asp:Label><br />
                    </div>
                </div>
                   
            </div>
                <br />
            <div class="row">
                <!-- Unit Title -->
                <div class="col-20">
                    <asp:Label ID="unitTitleLbl" runat="server" Text="Unit Title" ></asp:Label>
                </div>

                <div class="col-40">
                    <asp:TextBox ID="unitTitleTxt" runat="server" Width="225px" placeholder="eg. Application Development"></asp:TextBox>
                </div>

                <div class="col-10">
                    <asp:Label runat="server" Text="*" ForeColor="Red"></asp:Label>
                </div>

                <div class="col-30">
                    <asp:Label ID="unitTitleError" runat="server" ForeColor="Red" ></asp:Label><br />
                </div>
            </div>
                <br />
            

            <div class="row">
                <!-- Unit Coordinator -->
                <div class="col-20">
                    <asp:Label ID="unitCorLbl" runat="server" Text="Unit Coordinator" ></asp:Label>
                </div>

                <div class="col-40">
                    <asp:TextBox ID="unitCorTxt" runat="server" Width="225px" placeholder="eg. Naeem Janjua"></asp:TextBox>
                </div>

                
                <div class="col-30">
                    <asp:Label ID="unitCorError" runat="server" ForeColor="Red" ></asp:Label><br />
                </div>

                <br />
            
            </div>

            <div class="row">
                <!-- Unit File (not working) -->
                <div class="col-20">
                    <asp:Label ID="fileLbl" runat="server" Text="Unit File" ></asp:Label><br />
                </div>

                <div class="col-40">
                    <asp:FileUpload ID="fileUpload" runat="server" />
                </div>

                <div class="col-30">
                    <asp:Label ID="fileError" runat="server" ForeColor="Red"></asp:Label><br />
                </div>
            </div>

            <br />
            
            <!-- Buttons -->
            
            <asp:Button ID="addBtn" runat="server" Text="Add +" OnClick="addBtn_Click" CssClass="btnAdd" />

             <button runat="server" id="clearBtn" onserverclick="btnClear_Click" class="btnClear">
                Clear <i class="fa fa-eraser fa-1x"></i>
            </button>
        
           
            <p class="auto-style1">
                <asp:SqlDataSource ID="AddUnit" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnection %>" InsertCommand="INSERT INTO units(unitCode, unitTitle, unitCordinator) VALUES (@unitCode, @unitTitle, @unitCor)" SelectCommand="SELECT [unitCode], [unitTitle], [unitCordinator], [unitFile] FROM [units]">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="unitCodeTxt" Name="unitCode" PropertyName="Text" />
                        <asp:ControlParameter ControlID="unitTitleTxt" Name="unitTitle" PropertyName="Text" />
                        <asp:ControlParameter ControlID="unitCorTxt" Name="unitCor" PropertyName="Text" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </p>
        </div>
        
        <!-- Display results -->
        <strong><asp:Label ID="message" runat="server" Text="" ></asp:Label></strong>
        <br />
    
        <asp:ValidationSummary ID="ValidationSummary" runat="server" DisplayMode="List" ForeColor="Red" HeaderText="Invalid entry!" />
        <h2>Units list</h2>

        <asp:GridView ID="showUnitGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="unitCode" DataSourceID="GenerateData" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDeleted="showUnitGrid_RowDeleted" OnRowUpdated="showUnitGrid_RowUpdated">
            
            <AlternatingRowStyle BackColor="White" />
            
            <Columns>
                <asp:BoundField DataField="unitCode" HeaderText="Unit Code" ReadOnly="True" SortExpression="unitCode" />
                <asp:TemplateField HeaderText="Unit Title" SortExpression="unitTitle">
                    <EditItemTemplate>
                        <asp:TextBox ID="unitTitleTxt" runat="server" Text='<%# Bind("unitTitle") %>'></asp:TextBox>

                        <asp:RequiredFieldValidator ID="errorField" runat="server"
                            ErrorMessage="Unit Title cannot be empty" ControlToValidate="unitTitleTxt"
                            Text="*" ForeColor="Red">
                             
                        </asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("unitTitle") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Unit Cordinator" SortExpression="unitCordinator">
                    <EditItemTemplate>
                        <asp:TextBox ID="unitCorTxt" runat="server" Text='<%# Bind("unitCordinator") %>'></asp:TextBox>
                    </EditItemTemplate>


                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("unitCordinator") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                
                
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ImageUrl="Images/edit_orange.jpg" runat="server" CommandName="Edit" ToolTip="Edit" Width="25px" Height="25px"/>
                        <asp:ImageButton ImageUrl="Images/bin_red.png" runat="server" CommandName="Delete" ToolTip="Delete" Width="25px" Height="25px" OnClientClick="return confirm('Are you sure you want to delete this unit?\nIf any result data has been recorded with that same unit, all the results that has the same Unit Code will be deleted')"/>
                    </ItemTemplate>

                    <EditItemTemplate>
                        
                        <asp:ImageButton ImageUrl="Images/save_blue.png" runat="server" CommandName="Update" ToolTip="Update" Width="25px" Height="25px" ID="update"/>
                        <asp:ImageButton ImageUrl="Images/cancel.png" runat="server" CommandName="Cancel" ToolTip="Cancel" Width="25px" Height="25px"/>
                        
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#AEEEEE" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
           
            
        </asp:GridView>
        <asp:SqlDataSource ID="GenerateData" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnection %>" SelectCommand="SELECT * FROM [units]"
            UpdateCommand="UPDATE [units] SET [unitTitle] = @unitTitle, [unitCordinator] = @unitCordinator WHERE [unitCode] = @unitCode"
            DeleteCommand="DELETE FROM [units] WHERE [unitCode] = @unitCode"></asp:SqlDataSource>
        </form>
    </div>

</body>
</html>
