<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manageResults.aspx.cs" Inherits="Assignment2_v2.manageResults" %>

<!DOCTYPE html>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Data.SqlClient" %>
<%@ Import namespace="System.Configuration" %>
<%@ Import namespace="System.IO"%>

<script runat="server">

    protected void btnClear_Click(object sender, EventArgs e)
    {
       Response.Redirect("manageResults.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Results</title>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link rel="stylesheet" href="main.css" type="text/css" />
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
            <h1 style="text-align:center">Manage Results</h1>
            <asp:LinkButton ID="studentLink" runat="server" OnClick="StudentLink_Click">Manage Students</asp:LinkButton>
            <asp:LinkButton ID="reportLink" runat="server" OnClick="Report_Click">View Reports</asp:LinkButton>
            <br /><br />
            <strong>Welcome Manager!</strong><br />
            <asp:LinkButton ID="LogoutLink" runat="server" OnClick="LogoutLink_Click">Logout</asp:LinkButton>
            
             <div class="row">
                <!-- Student ID (make a drop down value) -->
                <div class="col-20">
                    <asp:Label ID="Label1" runat="server" Text="Student ID"></asp:Label>
                </div>

                <div class="col-40">
                    <asp:DropDownList AppendDataBoundItems="True" ID="DropDownStudent" runat="server" DataSourceID="GetStudent" DataTextField="studentID" DataValueField="studentID">
                        <asp:ListItem Selected="True">Select a Student ID</asp:ListItem>
                    </asp:DropDownList>
                        
                </div>

                <div class="col-10">
                    <asp:Label runat="server" Text="*" ForeColor="Red" ></asp:Label>
                </div>

                <div class="col-30">
                    <asp:Label ID="studentIDError" runat="server" ForeColor="Red"></asp:Label><br />
                </div>
            </div>
            <br />



            <div class="auto-style1">
                <!-- UnitCode (make a drop down value) -->
                <div class="row">
                    <div class="col-20">
                        <asp:Label ID="unitCodeLbl" runat="server" Text="Unit Code"></asp:Label>
                    </div>

                    <div class="col-40">
                        <asp:DropDownList AppendDataBoundItems="true" ID="unitCodeDrop" runat="server" DataSourceID="GetUnits" DataTextField="unitCode" DataValueField="unitCode">
                            <asp:ListItem Selected="True">Select a Unit Code</asp:ListItem>
                        </asp:DropDownList>
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
                <!-- Semester -->
               <div class="col-20">
                    <asp:Label ID="semesterlbl" runat="server" Text="Semester"></asp:Label>
                </div>

                <div class="col-40">
                    <asp:DropDownList ID="semester" runat="server">
                        <asp:ListItem Selected="True"></asp:ListItem>
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-10">
                    <asp:Label runat="server" Text="*" ForeColor="Red" ></asp:Label>
                </div>

                <div class="col-30">
                    <asp:Label ID="semesterError" runat="server" ForeColor="Red"></asp:Label><br />
                </div>



            </div>

            <br />

            <div class="row">
                <!-- Year -->
                <div class="col-20">
                    <asp:Label ID="yearlbl" runat="server" Text="Year"></asp:Label>
                </div>

                <div class="col-40">
                    <asp:TextBox ID="yearTxt" runat="server" Width="225px" placeholder="eg. 2019" MaxLength="4"></asp:TextBox>
                </div>

                <div class="col-10">
                    <asp:Label runat="server" Text="*" ForeColor="Red" ></asp:Label>
                </div>

                <div class="col-30">
                    <asp:Label ID="yearError" runat="server" ForeColor="Red"></asp:Label><br />
                </div>
            </div>

            <br />

            <div class="row">
                <!-- Assessment 1 -->
                <div class="col-20">
                    <asp:Label ID="Label7" runat="server" Text="Assessment 1 score"></asp:Label>
                </div>

                <div class="col-40">
                    <asp:TextBox ID="assessment1Txt" runat="server" Width="225px" placeholder="Enter between 0 - 20" MaxLength="2"></asp:TextBox>
                </div>

                <div class="col-10">
                    <asp:Label runat="server" Text="*" ForeColor="Red" ></asp:Label>
                </div>

                <div class="col-30">
                    <asp:Label ID="assessment1Error" runat="server" ForeColor="Red"></asp:Label><br />
                </div>
            </div>

            <br />

            <div class="row">
                <!-- Assessment 2 -->
               <div class="col-20">
                    <asp:Label ID="Label9" runat="server" Text="Assessment 2 score"></asp:Label>
                </div>

                <div class="col-40">
                    <asp:TextBox ID="assessment2Txt" runat="server" Width="225px" placeholder="Enter between 0 - 20" MaxLength="2"></asp:TextBox>
                </div>

                <div class="col-10">
                    <asp:Label runat="server" Text="*" ForeColor="Red" ></asp:Label>
                </div>

                <div class="col-30">
                    <asp:Label ID="assessment2Error" runat="server" ForeColor="Red"></asp:Label><br />
                </div>
            </div>

            <br />

            <div class="row">
                <!-- Exam -->
               <div class="col-20">
                    <asp:Label ID="Label11" runat="server" Text="Exam score"></asp:Label>
                </div>

                <div class="col-40">
                    <asp:TextBox ID="examTxt" runat="server" Width="225px" placeholder="Enter between 0 - 60" MaxLength="2"></asp:TextBox>
                </div>

                <div class="col-10">
                    <asp:Label runat="server" Text="*" ForeColor="Red" ></asp:Label>
                </div>

                <div class="col-30">
                    <asp:Label ID="examError" runat="server" ForeColor="Red"></asp:Label><br />
                </div>
            </div>
                
        <asp:SqlDataSource ID="GetStudent" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnection %>" SelectCommand="SELECT [studentID] FROM [students]"></asp:SqlDataSource>
                        
        <asp:SqlDataSource ID="GetUnits" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnection %>" SelectCommand="SELECT [unitCode] FROM [units]" OldValuesParameterFormatString="original_{0}">
        </asp:SqlDataSource>
        
            <asp:SqlDataSource ID="AddResult" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnection %>" InsertCommand="INSERT INTO results(unitCode, semester, yr, assignment1, assignment2, exam, studentID) VALUES (@unitCode, @semester, @yr, @assignment1, @assignment2, @exam, @studentID)" SelectCommand="SELECT unitCode, semester, yr, assignment1, assignment2, exam FROM results">
                <InsertParameters>
                    <asp:ControlParameter ControlID="unitCodeDrop" Name="unitCode" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="semester" Name="semester" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="yearTxt" Name="yr" PropertyName="Text" />
                    <asp:ControlParameter ControlID="assessment1Txt" Name="assignment1" PropertyName="Text" />
                    <asp:ControlParameter ControlID="assessment2Txt" Name="assignment2" PropertyName="Text" />
                    <asp:ControlParameter ControlID="examTxt" Name="exam" PropertyName="Text" />
                    <asp:ControlParameter ControlID="DropDownStudent" Name="studentID" PropertyName="SelectedValue" />
                </InsertParameters>
            </asp:SqlDataSource>
        
            <br />
            
            <!-- Buttons -->
        
            <asp:Button ID="addBtn" runat="server" Text="Add +" OnClick="addBtn_Click" CssClass="btnAdd" />

            <button runat="server" id="clearBtn" onserverclick="btnClear_Click" class="btnClear">
                Clear <i class="fa fa-eraser fa-1x"></i>
            </button>
        <!-- Display results -->
        
        
    </div>
        <strong>
        <asp:Label ID="message" runat="server"></asp:Label>
        </strong>
    </div>
        <strong>
        <asp:ValidationSummary ID="ValidationSummary" runat="server" DisplayMode="List" ForeColor="Red" HeaderText="Invalid entry!"/>
        </strong>
        <h2>Results List</h2>
        <asp:GridView ID="showResultGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="resultID" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="resultID" HeaderText="Result ID" InsertVisible="False" ReadOnly="True" SortExpression="resultID" />
                <asp:TemplateField HeaderText="Student ID" SortExpression="studentID">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("studentID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Unit Code" SortExpression="unitCode">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="GetUnits" DataTextField="unitCode" DataValueField="unitCode" AppendDataBoundItems="True" SelectedValue='<%# Bind("unitCode") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("unitCode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Semester" SortExpression="semester">
                    <EditItemTemplate>
                        <asp:TextBox ID="SemesterTxtEdit" runat="server" Text='<%# Bind("semester") %>' MaxLength="2" Width="20px"></asp:TextBox>

                        <asp:RangeValidator ID="semesterVal" runat="server" ErrorMessage="Enter either 1 or 2" 
                            MinimumValue="1" MaximumValue="2" Text="*" ForeColor="Red" ControlToValidate="semesterTxtEdit">

                        </asp:RangeValidator>

                        <asp:RequiredFieldValidator ID="errorField" runat="server"
                            ErrorMessage="Semester cannot be empty" ControlToValidate="semesterTxtEdit"
                            Text="*" ForeColor="Red">
                             
                        </asp:RequiredFieldValidator>

                        
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("semester") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Year" SortExpression="yr">
                    <EditItemTemplate>
                        <asp:TextBox ID="yrTxt" runat="server" Text='<%# Bind("yr") %>' MaxLength="4" Width="30px"></asp:TextBox>

                        <asp:RangeValidator ID="yrVal" runat="server" ErrorMessage="Enter the year between 1900-2200" 
                            MinimumValue="1900" MaximumValue="2200" Text="*" ForeColor="Red" ControlToValidate="yrTxt">

                        </asp:RangeValidator>

                        <asp:RequiredFieldValidator ID="errorField2" runat="server"
                            ErrorMessage="Year cannot be empty" ControlToValidate="yrTxt"
                            Text="*" ForeColor="Red">
                             
                        </asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("yr") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Assignment 1" SortExpression="assignment1">
                    <EditItemTemplate>
                        <asp:TextBox ID="assTxt1" runat="server" Text='<%# Bind("assignment1") %>' MaxLength="2" Width="20px"></asp:TextBox>
                        <asp:RangeValidator ID="assVal1" runat="server" ErrorMessage="Enter assignment 1 between 0 and 20" 
                            MinimumValue="0" MaximumValue="20" Text="*" ForeColor="Red" ControlToValidate="assTxt1">

                        </asp:RangeValidator>

                        <asp:RequiredFieldValidator ID="errorField3" runat="server"
                            ErrorMessage="Assignment 1 cannot be empty" ControlToValidate="assTxt1"
                            Text="*" ForeColor="Red">
                             
                        </asp:RequiredFieldValidator>

                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("assignment1") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Assignment 2" SortExpression="assignment2">
                    <EditItemTemplate>
                        <asp:TextBox ID="assTxt2" runat="server" Text='<%# Bind("assignment2") %>' MaxLength="2" Width="20px"></asp:TextBox>

                        <asp:RangeValidator ID="assVal2" runat="server" ErrorMessage="Enter assignment 2 between 0 and 20" 
                            MinimumValue="0" MaximumValue="20" Text="*" ForeColor="Red" ControlToValidate="assTxt2">

                        </asp:RangeValidator>

                        <asp:RequiredFieldValidator ID="errorField4" runat="server"
                            ErrorMessage="Assignment 2 cannot be empty" ControlToValidate="assTxt2"
                            Text="*" ForeColor="Red">
                             
                        </asp:RequiredFieldValidator>

                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("assignment2") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Exam" SortExpression="exam">
                    <EditItemTemplate>
                        <asp:TextBox ID="examTxt" runat="server" Text='<%# Bind("exam") %>' MaxLength="2" Width="20px"></asp:TextBox>

                        <asp:RangeValidator ID="examVal" runat="server" ErrorMessage="Enter exam between 0 and 60" 
                            MinimumValue="0" MaximumValue="60" Text="*" ForeColor="Red" ControlToValidate="examTxt">

                        </asp:RangeValidator>

                        <asp:RequiredFieldValidator ID="errorField5" runat="server"
                            ErrorMessage="Exam cannot be empty" ControlToValidate="examTxt"
                            Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>


                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("exam") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Options">
                    <ItemTemplate>
                        <asp:ImageButton ImageUrl="Images/edit_orange.jpg" runat="server" CommandName="Edit" ToolTip="Edit" Width="25px" Height="25px"/>
                        <asp:ImageButton ImageUrl="Images/bin_red.png" runat="server" CommandName="Delete" ToolTip="Delete" Width="25px" Height="25px" OnClientClick="return confirm('Are you sure you want to delete this result?')"/>
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
        <br />
        
    </form>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnection %>" DeleteCommand="DELETE FROM [results] WHERE [resultID] = @resultID" InsertCommand="INSERT INTO [results] ([studentID], [unitCode], [semester], [yr], [assignment1], [assignment2], [exam]) VALUES (@studentID, @unitCode, @semester, @yr, @assignment1, @assignment2, @exam)" SelectCommand="SELECT * FROM [results]" UpdateCommand="UPDATE [results] SET [studentID] = @studentID, [unitCode] = @unitCode, [semester] = @semester, [yr] = @yr, [assignment1] = @assignment1, [assignment2] = @assignment2, [exam] = @exam WHERE [resultID] = @resultID">
            <DeleteParameters>
                <asp:Parameter Name="resultID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="studentID" Type="Int32" />
                <asp:Parameter Name="unitCode" Type="String" />
                <asp:Parameter Name="semester" Type="Int32" />
                <asp:Parameter Name="yr" Type="Int32" />
                <asp:Parameter Name="assignment1" Type="Int32" />
                <asp:Parameter Name="assignment2" Type="Int32" />
                <asp:Parameter Name="exam" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="studentID" Type="Int32" />
                <asp:Parameter Name="unitCode" Type="String" />
                <asp:Parameter Name="semester" Type="Int32" />
                <asp:Parameter Name="yr" Type="Int32" />
                <asp:Parameter Name="assignment1" Type="Int32" />
                <asp:Parameter Name="assignment2" Type="Int32" />
                <asp:Parameter Name="exam" Type="Int32" />
                <asp:Parameter Name="resultID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </div>

</body>
</html>
