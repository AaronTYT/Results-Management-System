<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manageStudents.aspx.cs" Inherits="Assignment2_v2.manageStudents" %>

<!DOCTYPE html>

<script runat="server">

    protected void btnClear_Click(object sender, EventArgs e)
    {
       Response.Redirect("manageStudents.aspx");
    }
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Students</title>
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
<div class="auto-style1">
    <div class="container">
        
    <form runat="server">
        <h1 style="text-align:center">Manage Students</h1>
        <h1><i class="fa fa-user" style="color:cornflowerblue;"></i></h1>

        <asp:LinkButton ID="manageResultsLink" runat="server" OnClick="manageResultsLink_Click">Manage Results</asp:LinkButton>
        <asp:LinkButton ID="LinkReport" runat="server" OnClick="LinkReport_Click">View Reports</asp:LinkButton>
        <br /><br />
        <strong>Welcome Manager!</strong><br />
        <asp:LinkButton ID="LogoutLink" runat="server" OnClick="LogoutLink_Click">Logout</asp:LinkButton>

        <div class="row">
                <!-- Student ID -->
                <div class="col-20">
                    <asp:Label ID="Label1" runat="server" Text="Student ID"></asp:Label>
                </div>

                <div class="col-40">
                    <asp:TextBox ID="studentIDTxt" runat="server" Width="225px" placeholder="eg. 12345678" MaxLength="8"></asp:TextBox>
                </div>

                <div class="col-10">
                    <asp:Label runat="server" Text="*" ForeColor="Red" ></asp:Label>
                </div>

                <div class="col-30">
                    <asp:Label ID="studentIDError" runat="server" ForeColor="Red"></asp:Label><br />
                </div>
        </div>
            <br />
            

        <div class="row">
            <!-- Student Photo -->
            <div class="col-20">
                <asp:Label ID="photoLbl" runat="server" Text="Student Photo" ></asp:Label><br />
                
            </div>

            <div class="col-40">
                <asp:FileUpload ID="photoUpload" runat="server" />
            </div>

            <div class="col-30">
                <asp:Label ID="photoError" runat="server" ForeColor="Red"></asp:Label><br />
            </div>

            <br />
            
        </div>

        <br />
        <asp:Button ID="addBtn" runat="server" Text="Add +" OnClick="addBtn_Click" CssClass="btnAdd" />
        <button runat="server" id="clearBtn" onserverclick="btnClear_Click" class="btnClear">
                Clear <i class="fa fa-eraser fa-1x"></i>
        </button>

    </div>
        </div>
        <strong>
        <asp:Label ID="message" runat="server"></asp:Label>
        </strong>
    </div>
    <br />
    <h2 style="text-align:center">Student List</h2>

    <!-- GridView -->
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting"
        OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" DataKeyNames="studentID" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="Student ID">
                <ItemTemplate>
                    <asp:Label ID="lblImgId" runat="server" Text='<%#Eval("studentID")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Student Photo">
                <EditItemTemplate>
                    <asp:Image ID="img_user" runat="server" ImageUrl='<%# Eval("photo")%>' Height="100px" Width="110px" /><br />
                    <asp:FileUpload ID="FileUpload1" runat="server" Height="20px" Width="195px" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("photo")%>' Height="100px" Width="110px" />
                </ItemTemplate>
            </asp:TemplateField>


            <asp:TemplateField HeaderText="Student Location">
                <ItemTemplate>
                    <asp:Label ID="lblImageName" runat="server" Text='<%# Eval("photo")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>


            <asp:TemplateField HeaderText="Options">
                <ItemTemplate>
                    <asp:ImageButton ImageUrl="Images/edit_orange.jpg" runat="server" CommandName="Edit" ToolTip="Edit" Width="25px" Height="25px"/>
                    <asp:ImageButton ImageUrl="Images/bin_red.png" runat="server" CommandName="Delete" ToolTip="Delete" Width="25px" Height="25px" OnClientClick="return confirm('Are you sure you want to delete student?\nIf this student has unit results, all of their unit data will be deleted.')"/>
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
    </form>
  
  
</body>
</html>
