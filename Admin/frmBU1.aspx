<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="frmBU1.aspx.cs" Inherits="Admin_frmBU1" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .dataTables_wrapper .dataTables_paginate .paginate_button.previous, .dataTables_wrapper .dataTables_paginate .paginate_button.next {
            width: 4.6875rem !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="Server" AsyncPostBackTimeout="36000"
        EnableHistory="true" EnablePageMethods="true" EnablePartialRendering="true" EnableScriptGlobalization="true"
        EnableScriptLocalization="true" ScriptMode="Release">
    </asp:ScriptManager>
    <div class="content-body">
        <!-- row -->


        <div class="container-fluid">
            <div class="card">
                <div class="card-header p-4 border-bottom bg-body">
                    <div class="p-4 code-to-copy">
                      <ul class="nav nav-underline fs-9" id="myTab" role="tablist">
                        <li class="nav-item active" role="presentation"><a class="nav-link" id="home-tab" data-bs-toggle="tab" href="#tab-home" role="tab" aria-controls="tab-home" aria-selected="true" tabindex="-1">Search Unit</a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link active" id="profile-tab" data-bs-toggle="tab" href="#tab-profile" role="tab" aria-controls="tab-profile" aria-selected="false" tabindex="-1">Add Unit</a></li>
                      </ul>
                        <div class="tab-content mt-3" id="myTabContent">
     <div class="tab-pane fade active show" id="tab-home" role="tabpanel" aria-labelledby="home-tab">
         <div class="row">
             <div class="col-md-4">
                 <div class="mb-0">
                     <label class="mb-1"><strong>Business Unit Name :</strong></label>
                     <div class="input-group mb-3">
                         <asp:DropDownList ID="ddlbu" runat="server" CssClass="form-control"></asp:DropDownList>
                         <asp:CascadingDropDown ID="CFYear" runat="server" Category="BU" TargetControlID="ddlbu"
                             BehaviorID="cddlY" LoadingText="Loading Unit..." PromptText="Select Business Unit" ServiceMethod="BindBUdropdown"
                             ServicePath="/DropdownWebService.asmx">
                         </asp:CascadingDropDown>
                         <div class="input-group-append">
                             <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success btn-sm btnsearchs" OnClick="btnSearch_Click" ValidationGroup="AB" Text="Search" Style="line-height: 25px; margin-top: 0px;" />
                         </div>
                     </div>

                 </div>
             </div>
         </div>
         <div class="row" style="padding:1%!important">
             <div class="table-responsive scrollbar">
                 <asp:GridView ID="grdview" runat="server" AutoGenerateColumns="false" CssClass="table fs-9 mb-0">
                     <Columns>
                         <asp:TemplateField HeaderText="SL.No" HeaderStyle-Width="10%">
                             <ItemTemplate>
                                 <%# Container.DataItemIndex + 1 %>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:BoundField DataField="unitcode" HeaderText="Code" />
                         <asp:BoundField DataField="Name" HeaderText="Unit" />
                         <asp:BoundField DataField="FD" HeaderText="Full Description" />
                         <asp:BoundField DataField="SD" HeaderText="Short Description" />
                         <asp:BoundField DataField="Status" HeaderText="Status" />
                     </Columns>
                 </asp:GridView>
             </div>
         </div>
     </div>

    <div class="tab-pane fade" id="tab-profile" role="tabpanel" aria-labelledby="profile-tab">
         <div class="row">
             <div class="col-md-6">

                 <div class="mb-0">
                     <label class="mb-1"><strong>Unit Name :</strong></label>
                     <div class="input-group mb-3">
                         <asp:TextBox ID="txtbuname" runat="server" CssClass="form-control" />
                         <div class="input-group-append">
                             <asp:HiddenField runat="server" ID="hdnCode" Value=""></asp:HiddenField>
                             <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success btn-sm" Style="padding: 9.5px 15px!important;" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="AA" />
                         </div>
                         <asp:RequiredFieldValidator ID="Requ1" runat="server" ErrorMessage="Enter Business Unit Name" ControlToValidate="txtbuname" Font-Size="Small" ForeColor="Red" ValidationGroup="AA"></asp:RequiredFieldValidator>
                     </div>
                 </div>
             </div>

         </div>
         <div class="row" style="padding:1%!important">
             <div class="table-responsive scrollbar">
                 <asp:GridView ID="GData" runat="server" AutoGenerateColumns="false" CssClass="table fs-9 mb-0">
                     <Columns>
                         <asp:TemplateField HeaderText="SL.No" HeaderStyle-Width="10%">
                             <ItemTemplate>
                                 <%# Container.DataItemIndex + 1 %>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:BoundField DataField="Name" HeaderText="Unit" />
                         <asp:TemplateField HeaderText="Action">
                             <ItemTemplate>
                                 <a href="javascript:void(0);" onclick="return funPopSetup('<%#Eval("Code")%>');"><i class="flaticon-381-notebook" style="color: #500073;"></i>show</a>
                             </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                 </asp:GridView>
             </div>
         </div>
     </div>
 </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="modal" tabindex="-1" role="dialog" id="myModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">ERP Setup Page</h5>
                    <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btnpopclose">
          <span aria-hidden="true">&times;</span>
        </button>--%>
                </div>
                <div class="modal-body">
                    <div class="row">
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
            var table = $('#ContentPlaceHolder1_GData,#ContentPlaceHolder1_grdview').DataTable({
                select: false,
                "columnDefs": [{
                    bLengthChange: true,
                    lengthMenu: [[20, 50, -1], [20, 50, "All"]],
                    bFilter: true,
                    bSort: true,
                    bPaginate: true
                }]
            });
        });
        function funPopSetup(adata) {
            document.getElementById('<%=hdnCode.ClientID%>').value = adata;
            $('#myModal').show();
        }
        $("#btnpopclose,#btnpopclose1").click(function () {
            $('#myModal').hide();
            return false;
        });
    </script>
</asp:Content>

