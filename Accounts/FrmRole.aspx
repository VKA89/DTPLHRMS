<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FrmRole.aspx.cs" Inherits="Account_FrmRole" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .dataTables_wrapper .dataTables_paginate .paginate_button.previous, .dataTables_wrapper .dataTables_paginate .paginate_button.next {
            width: 4.6875rem !important;
        }

        hr {
            background-color: #fff;
            padding: 0;
        }

            hr.hr-1 {
                border: 0;
                border-top: 1px solid #8c8c8c;
                border-bottom: 1px solid #fff;
            }

        .paginate_button {
            border-radius: 0 !important;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            width: 100%;
            max-width: 900px;
            height: auto;
            background: white;
            display: flex;
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="card shadow-none border my-4" data-component-card="data-component-card">
        <div class="card-header p-4 border-bottom bg-body">
            <div class="row g-3 justify-content-between align-items-center">
                <div class="col-12 col-md">
                    <h4 class="text-body mb-0">Role Manager</h4>

                </div>
                <div class="col col-md-auto">
                    <nav class="nav justify-content-end doc-tab-nav align-items-center" role="tablist">
                        <a id="aenter" class="btn btn-sm btn-phoenix-primary code-btn ms-2 collapsed" style="width: 10.4375rem !important;" data-bs-toggle="collapse" href="#example-code" role="button" aria-controls="example-code" aria-expanded="false">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-code me-2">
                                <polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>Add Role</a><a style="width: 10.4375rem !important;" class="btn btn-sm btn-phoenix-primary preview-btn ms-2"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-eye me-2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>Add Role</a>
                    </nav>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="code-collapse collapse" id="example-code" style="padding: 1%;">
                <div class="col-md-6">
                    <label class="form-label" for="basic-url">
                        <strong>Add Role :</strong><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Add Role" ControlToValidate="txtRole" Font-Size="Small" ForeColor="Red" ValidationGroup="AA"></asp:RequiredFieldValidator>
                    </label>
                    <div class="input-group mb-3">
                        <asp:TextBox ID="txtRole" runat="server" CssClass="form-control" />
                        <span class="input-group-text" id="basic-addon2">
                            <asp:HiddenField runat="server" ID="hdnId" Value=""></asp:HiddenField>
                            <asp:Button ID="btnRegister" runat="server" Text="Submit" OnClick="btnRegister_Click" ValidationGroup="AA" class="btn me-1 mb-1" />

                        </span>

                    </div>
                </div>
                <hr class="hr-1" />
            </div>
            <div class="p-4 code-to-copy">
                <div class="table-responsive scrollbar">
                    <asp:GridView ID="gvRole" runat="server" AutoGenerateColumns="False" DataKeyNames="Role_Id_pk" CCellSpacing="0" CssClass="table fs-9 mb-0"  OnRowCommand="gvRole_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Role_Id_pk" HeaderText="ID" />
                            <asp:BoundField DataField="Role" HeaderText="Department" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <a
                                        onclick="return funPopSetup1('<%#Eval("Role_Id_pk")%>','<%#Eval("Role") %>');">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit-2 text-body fs-5"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path></svg>
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                if ($('#ContentPlaceHolder1_gvRole tbody tr').length > 0) {
                    var table1 = $('#ContentPlaceHolder1_gvRole').DataTable({

                        "searching": true,         //show search box
                        "info": false,      //hide row count
                        "stateSave": true,       //remember user's sort choice
                        "order": [[0, "asc"]],    //default order by this column
                        "columnDefs": [             //individual column settings - count starts at 0  (should not be able to sort by Outcmome, Batch print 
                            {
                                "type": 'custom-id', "targets": [0],
                                bLengthChange: true,
                                //lengthMenu: [[20, 50, -1], [20, 50, "All"]],
                                bFilter: true,
                                bSort: true,
                                bPaginate: true
                            }
                        ]
                    });
                }
            });
            function funPopSetup() {
                $('#myModal').show();
            }
            function funPopSetup1(adata,adata1) {
                document.getElementById("<%=hdnId.ClientID%>").value = adata;
                document.getElementById("<%=txtRole.ClientID%>").value = adata1;
                $("#example-code").addClass("show");
                return false;
            }
            $("#btnpopclose,#btnpopclose1").click(function () {
                $('#myModal').hide();
                return false;
            });
            window.onclick = function (event) {
                if (event.target == modal) {
                    return false;
                }
            }
        </script>
</asp:Content>