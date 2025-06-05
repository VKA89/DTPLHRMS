<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="frmBU.aspx.cs" Inherits="Admin_frmBU" EnableEventValidation="false" %>

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
    <asp:ScriptManager ID="ScriptManager1" runat="Server" AsyncPostBackTimeout="36000"
        EnableHistory="true" EnablePageMethods="true" EnablePartialRendering="true" EnableScriptGlobalization="true"
        EnableScriptLocalization="true" ScriptMode="Release">
    </asp:ScriptManager>
    <div class="card shadow-none border my-4" data-component-card="data-component-card">
        <div class="card-header p-4 border-bottom bg-body">
            <div class="row g-3 justify-content-between align-items-center">
                <div class="col-12 col-md">
                    <h4 class="text-body mb-0">Business Unit</h4>

                </div>
                <div class="col col-md-auto">
                    <nav class="nav justify-content-end doc-tab-nav align-items-center" role="tablist">
                        <a class="btn btn-sm btn-phoenix-primary code-btn ms-2 collapsed" data-bs-toggle="collapse" href="#example-code" role="button" aria-controls="example-code" aria-expanded="false">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-code me-2"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>Add Unit</a><a class="btn btn-sm btn-phoenix-primary preview-btn ms-2"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-eye me-2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>Add Unit</a>
                    </nav>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="code-collapse collapse" id="example-code" style="padding: 1%;">
                <div class="col-md-6">
                    <label class="form-label" for="basic-url">
                        <strong>Add Unit Name :</strong><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Add Unit Name" ControlToValidate="txtbuname" Font-Size="Small" ForeColor="Red" ValidationGroup="AA"></asp:RequiredFieldValidator>
                        <asp:HiddenField runat="server" ID="hdnCode" />
                        <asp:HiddenField runat="server" ID="hdnname" />
                    </label>
                    <div class="input-group mb-3">
                        <asp:TextBox ID="txtbuname" runat="server" MaxLength="6"
                            class="form-control" type="text" placeholder="Enter Unit Name" aria-label="Enter Unit Name" aria-describedby="basic-addon2" />
                        <span class="input-group-text" id="basic-addon2">
                            <asp:HiddenField runat="server" ID="HiddenField1" Value=""></asp:HiddenField>
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn me-1 mb-1" Style="padding: 9.5px 15px!important;" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="AA" />

                        </span>

                    </div>
                </div>
                <hr class="hr-1" />
            </div>
            <div class="p-4 code-to-copy">
                <div class="table-responsive scrollbar">
                    <asp:GridView ID="grdview" runat="server" AutoGenerateColumns="false" CellSpacing="0" CssClass="table fs-9 mb-0" OnRowCommand="grdview_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="SL.No" HeaderStyle-Width="10%">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="unitcode" HeaderText="Code" />
                            <asp:BoundField DataField="FD" HeaderText="Full Description" />
                            <asp:BoundField DataField="SD" HeaderText="Short Description" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="GName" HeaderText="Group Set" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hndgcode" runat="server" Value='<%#Eval("Code")%>' />
                                    <asp:HiddenField ID="hndid" runat="server" Value='<%#Eval("Id")%>' />
                                    <asp:LinkButton ID="lnkpop" runat="server" CommandArgument='<%#Eval("unitcode")%>' CommandName="popedit"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit-2 text-body fs-5"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path></svg></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div class="modal" tabindex="-1" role="dialog" id="myModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">ERP Setup Page</h5>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-0">
                                    <label class="mb-1"><strong>Unit :</strong></label>
                                    <asp:Label ID="lblunit" runat="server" Text="" CssClass="form-control"></asp:Label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="mb-0">
                                    <label class="mb-1"><strong>Status :</strong></label>
                                    <asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="Deactive"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Unit Status" ControlToValidate="ddlstatus" InitialValue="-1" Font-Size="Small" ForeColor="Red" ValidationGroup="AA1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="mb-0">
                                    <label class="mb-1"><strong>Full Description :</strong></label>
                                    <asp:TextBox ID="txtFdesc" runat="server" CssClass="form-control" MaxLength="55" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Full Description" ControlToValidate="txtFdesc" Font-Size="Small" ForeColor="Red" ValidationGroup="AA1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="mb-0">
                                    <label class="mb-1"><strong>Short Description :</strong></label>
                                    <asp:TextBox ID="txtsdesc" runat="server" CssClass="form-control" MaxLength="15" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Business Short Description" ControlToValidate="txtsdesc" Font-Size="Small" ForeColor="Red" ValidationGroup="AA1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="mb-0">
                                    <label class="mb-1"><strong>Default Group Set :</strong></label>
                                    <asp:DropDownList ID="ddlbu" runat="server" CssClass="form-control"></asp:DropDownList>
                                    <asp:CascadingDropDown ID="CFYear" runat="server" Category="BU" TargetControlID="ddlbu"
                                        BehaviorID="cddlY" LoadingText="Loading Unit..." PromptText="Select Business Unit" ServiceMethod="BindBUdropdown"
                                        ServicePath="~/DropdownWebservice.asmx">
                                    </asp:CascadingDropDown>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Full Description" ControlToValidate="ddlbu" Font-Size="Small" ForeColor="Red" ValidationGroup="AA1"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button class="btn btn-primary" ID="btnpopsave" runat="server" OnClick="btnpopsave_Click" ValidationGroup="AA1" Text="Save changes"></asp:Button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnpopclose1">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                if ($('#ContentPlaceHolder1_grdview tbody tr').length > 0) {
                    var table1 = $('#ContentPlaceHolder1_grdview').DataTable({
                      
                        "searching": true,         //show search box
                        "info": false,      //hide row count
                        "stateSave": true,       //remember user's sort choice
                        "order": [[0, "asc"]],    //default order by this column
                        "columnDefs": [             //individual column settings - count starts at 0  (should not be able to sort by Outcmome, Batch print 
                            { "type": 'custom-id', "targets": [0],
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
            function funPopSetup1(adata, adata1) {
                document.getElementById("<%=hdnCode.ClientID%>").value = adata;
                document.getElementById("<%=hdnname.ClientID%>").value = adata1;
                document.getElementById("<%=lblunit.ClientID%>").innerText = adata1;
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

