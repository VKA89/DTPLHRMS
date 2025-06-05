<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FrmLocAndCom.aspx.cs" Inherits="Admin_FrmLocAndCom" %>

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

        hr.hr-1 {
            border: 0;
            border-top: 1px solid #8c8c8c;
            border-bottom: 1px solid #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="card shadow-none border my-4" data-component-card="data-component-card">
        <div class="card-header p-4 border-bottom bg-body">
            <div class="row g-3 justify-content-between align-items-center">
                <div class="col-12 col-md">
                    <h4 class="text-body mb-0">Company And Location Manager</h4>
                </div>
                <div class="col col-md-auto">
                    <nav class="nav justify-content-end doc-tab-nav align-items-center" role="tablist">
                        <!-- Keep the collapse toggle as is -->
                        <a id="aenter" class="btn btn-sm btn-phoenix-primary code-btn ms-2 collapsed"
                            style="width: 15.4375rem !important;"
                            data-bs-toggle="collapse" href="#example-code" role="button" aria-controls="example-code" aria-expanded="false">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round" class="feather feather-code me-2">
                                <polyline points="16 18 22 12 16 6"></polyline>
                                <polyline points="8 6 2 12 8 18"></polyline>
                            </svg>
                            Add Company Location
                        </a>
                        <a style="width: 15.4375rem !important;" class="btn btn-sm btn-phoenix-primary preview-btn ms-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round" class="feather feather-eye me-2">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                            Add Company Location
                        </a>




                    </nav>
                </div>
            </div>
        </div>

        <div class="card-body p-0">
            <div class="col-md-6" style="padding: 1% !important;">
                <label class="form-label" for="basic-url">
                    <strong>Company :</strong>
                </label>
                <div class="input-group mb-3">
                    <asp:TextBox ID="txtcompnameReadonly" ReadOnly="true" runat="server" CssClass="form-control"></asp:TextBox>
                    <span class="input-group-text" id="basic-addon2">
                        <a id="aComp" class="btn btn-sm btn-phoenix-primary code-btn ms-2 collapsed"
                            onclick="funPopSetupaddcomp();">+</a>
                    </span>
                </div>
            </div>
            <hr class="hr-1" />
            <!-- Collapse content -->
            <div class="code-collapse collapse" id="example-code" style="padding: 1%;margin-top: -4%;">
                <!-- Tabs Content -->
                <div class="tab-content mt-3" id="companyLocationTabsContent">
                    <!-- Company Location Tab Pane -->
                    <div class="tab-pane fade show active" id="company-location" role="tabpanel" aria-labelledby="company-location-tab">
                        <!-- Location Container -->
                        <div class="card mt-4">
                            <div class="card-header">
                                <h5 class="mb-0">Location</h5>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <!-- Effective Date -->
                                    <div class="col-md-4">
                                        <label class="form-label"><strong>Effective Date</strong></label>
                                        <asp:TextBox ID="txtEffectiveDate" runat="server" CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfvEffectiveDate" runat="server" 
                                            ControlToValidate="txtEffectiveDate" 
                                            ErrorMessage="Effective Date is required." 
                                            ForeColor="Red" 
                                            Display="Dynamic"
                                            ValidationGroup="CompanyForm"/>
                                        <asp:CalendarExtender ID="calExtEffectiveDate" runat="server"
                                            TargetControlID="txtEffectiveDate" Format="yyyy-MM-dd" />
                                    </div>

                                    <!-- Status Dropdown -->
                                    <div class="col-md-4">
                                        <label class="form-label"><strong>Status</strong></label>
                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                                            <asp:ListItem Text="-- Select Status --" Value="" />
                                            <asp:ListItem Text="Active" Value="Active" />
                                            <asp:ListItem Text="Inactive" Value="Inactive" />
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvStatus" runat="server" 
                                            ControlToValidate="ddlStatus" 
                                            InitialValue="-- Select Status --" 
                                            ErrorMessage="Status is required." 
                                            ForeColor="Red" 
                                            Display="Dynamic" 
                                            ValidationGroup="CompanyForm"/>
                                    </div>

                                    <!-- Description -->
                                    <div class="col-md-4">
                                        <label class="form-label"><strong>Description</strong></label>
                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                                         <asp:RequiredFieldValidator ID="rfvDescription" runat="server" 
                                            ControlToValidate="txtDescription" 
                                            ErrorMessage="Description is required." 
                                            ForeColor="Red" 
                                            Display="Dynamic"
                                            ValidationGroup="CompanyForm"/>
                                    </div>

                                    <!-- Short Description -->
                                    <div class="col-md-4">
                                        <label class="form-label"><strong>Short Description</strong></label>
                                        <asp:TextBox ID="txtShortDescr" runat="server" CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfvShortDescr" runat="server" 
                                            ControlToValidate="txtShortDescr" 
                                            ErrorMessage="Short Description is required." 
                                            ForeColor="Red" 
                                            Display="Dynamic"
                                            ValidationGroup="CompanyForm"/>
                                    </div>

                                    <!-- Location Set ID -->
                                    <%--<div class="col-md-4">
                                        <label class="form-label"><strong>Location Set ID</strong></label>
                                        <asp:TextBox ID="txtLocationSetID" runat="server" CssClass="form-control" />
                                    </div>--%>

                                    <!-- Location -->
                                    <div class="col-md-4">
                                        <label class="form-label"><strong>Location</strong></label>
                                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server" 
                                            ControlToValidate="txtLocation" 
                                            ErrorMessage="Location is required." 
                                            ForeColor="Red" 
                                            Display="Dynamic"
                                            ValidationGroup="CompanyForm"/>
                                    </div>

                                    <!-- Default Set ID -->
                                    <div class="col-md-4">
                                        <label class="form-label"><strong>Default Set ID</strong></label>
                                        <asp:DropDownList ID="txtDefaultSetID" runat="server" CssClass="form-select">
                                            <asp:ListItem>Select Set Id</asp:ListItem>
                                            <asp:ListItem Value="1">A</asp:ListItem>
                                            <asp:ListItem Value="1">B</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvDefaultSetID" runat="server" 
                                            ControlToValidate="txtDefaultSetID" 
                                            InitialValue="Select Set Id" 
                                            ErrorMessage="Default Set ID is required." 
                                            ForeColor="Red" 
                                            Display="Dynamic"
                                             ValidationGroup="CompanyForm"/>
                                    </div>

                                    <!-- Country -->
                                    <div class="col-md-4">
                                        <label class="form-label"><strong>Country</strong></label>
                                        <asp:DropDownList ID="txtCountry" runat="server" CssClass="form-select">
                                             <asp:ListItem>Select Set Id</asp:ListItem>
                                             <asp:ListItem Value="1">India</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvCountry" runat="server" 
                                            ControlToValidate="txtCountry" 
                                            InitialValue="Select Country" 
                                            ErrorMessage="Country is required." 
                                            ForeColor="Red" 
                                            Display="Dynamic"
                                            ValidationGroup="CompanyForm"/>
                                    </div>

                                    <!-- Address -->
                                    <div class="col-md-12">
                                        <label class="form-label"><strong>Address</strong></label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtAddress" ReadOnly="true" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                                            <span class="input-group-text">
                                            <a href="javascript:void(0);" onclick="popeditadd();">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit-2 text-body fs-5"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path></svg>
                                            </a>
                                            </span>
                                        </div>
                                    </div>
                                    <hr class="hr-1" />
                                    <!-- Email Address Section -->
                                    <div class="card mt-4" style="margin-top: -1% !important;">
                                        <div class="card-header">
                                            <h5 class="mb-0">Email Addresses</h5>
                                        </div>
                                        <div class="card-body">
                                            <table class="table table-bordered" id="emailTable">
                                                <thead class="">
                                                    <tr>
                                                        <th style="width: 40%;">Address Type</th>
                                                        <th style="width: 50%;">Email Address</th>
                                                        <th style="width: 10%;padding-left: 4%;">
                                                            <a href="javascript:void(0);" onclick="addEmailRow()">+</a>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="emailBody">
                                                    <!-- Dynamic Rows Go Here -->
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="text-centre mt-3" style="text-align: center;">
                                        <button type="button" ID="btnSaveComapnyfinal" runat="server" Class="btn btn-primary" Text="Save" onclick="return funcsaveCompfinal();">Submit</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr class="hr-1" />
                    </div>

                </div>
            </div>

        </div>
    </div>
    <div class="card shadow-none border my-4" data-component-card="data-component-card">
        <div class="card-header p-4 border-bottom bg-body">
            <div class="row g-3 justify-content-between align-items-center">
                <div class="col-12 col-md">
                    <h4 class="text-body mb-0">Company Phones</h4>
                </div>
                <div class="col col-md-auto">
                    <nav class="nav justify-content-end doc-tab-nav align-items-center" role="tablist">
                        <a id="aphones" class="btn btn-sm btn-phoenix-primary code-btn ms-2 collapsed"
                            style="width: 10.4375rem !important;"
                            data-bs-toggle="collapse" href="#example-code1" role="button" aria-controls="example-code1" aria-expanded="false">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round" class="feather feather-code me-2">
                                <polyline points="16 18 22 12 16 6"></polyline>
                                <polyline points="8 6 2 12 8 18"></polyline>
                            </svg>
                            Phones
                        </a>
                        <a style="width: 10.4375rem !important;" class="btn btn-sm btn-phoenix-primary preview-btn ms-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round" class="feather feather-eye me-2">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                            Phones
                        </a>


                    </nav>
                </div>
            </div>
        </div>

        <div class="card-body p-0">
            <div class="code-collapse collapse" id="example-code1" style="padding: 1%;">
                <!-- Phones Tab Pane -->
                <div class="tab-content mt-3" id="phones-content" style="margin-top: 20px;">
                    <div class="tab-pane fade show active" id="company-phone" role="tabpanel" aria-labelledby="phones-content-tab">
                        <div class="mb-3 row">
                            <label for="txtCompany" class="col-sm-2 col-form-label">Company</label>
                            <div class="col-sm-10">
                                <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" Placeholder="Enter company name" />
                                <asp:RequiredFieldValidator ID="rfvCompany" runat="server" 
                                    ControlToValidate="txtCompany" 
                                    ErrorMessage="Company name is required." 
                                    ForeColor="Red" 
                                    Display="Dynamic"
                                    ValidationGroup="CompanyForm"/>
                            </div>
                        </div>
                        <div class="card mt-3">

                            <div class="card-header">
                                <%--<h5 class="mb-0">Phones / Processing Controls</h5>--%>
                            </div>
                            <div class="card-body">
                                <!-- Company Textbox -->


                                <!-- First Nested Container -->
                                <div class="border p-3 mb-3 bg-light">
                                    <h6 class="mb-3">Phones/Processing Controls</h6>

                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <label for="txtEffectiveDate" class="form-label">Effective Date</label>
                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Placeholder="MM/DD/YYYY" />
                                            <asp:RequiredFieldValidator ID="rfvPhoneEffectiveDate" runat="server" 
                                                ControlToValidate="TextBox1" 
                                                ErrorMessage="Effective Date is required." 
                                                ForeColor="Red" 
                                                Display="Dynamic"
                                                ValidationGroup="CompanyForm"/>
                                            <asp:CalendarExtender ID="ceEffectiveDate" runat="server"
                                                TargetControlID="txtEffectiveDate" Format="MM/dd/yyyy" />
                                        </div>

                                        <div class="col-md-4">
                                            <label for="ddlStatus" class="form-label">Status</label>
                                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select">
                                                <asp:ListItem Text="-- Select Status --" Value="" />
                                                <asp:ListItem Text="Active" Value="Active" />
                                                <asp:ListItem Text="Inactive" Value="Inactive" />
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvPhoneStatus" runat="server" 
                                                ControlToValidate="DropDownList1" 
                                                InitialValue="-- Select Status --" 
                                                ErrorMessage="Status is required." 
                                                ForeColor="Red" 
                                                Display="Dynamic"
                                                ValidationGroup="CompanyForm"/>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="txtDescription" class="form-label">Description</label>
                                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Placeholder="Enter description" />
                                             <asp:RequiredFieldValidator ID="rfvPhoneDescription" runat="server" 
                                                ControlToValidate="TextBox2" 
                                                ErrorMessage="Description is required." 
                                                ForeColor="Red" 
                                                Display="Dynamic" 
                                                ValidationGroup="CompanyForm"/>
                                        </div>
                                    </div>

                                    <!-- Second Nested Container -->
                                    <div class="border p-3 bg-white">
                                        <h6 class="mb-3">Processing Controls</h6>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="ddlIndustry" class="form-label">Industry</label>
                                                <asp:DropDownList ID="ddlIndustry" runat="server" CssClass="form-select">
                                                    <asp:ListItem Text="-- Select Industry --" Value="0" />
                                                    <asp:ListItem Text="It Sector" Value="1"></asp:ListItem>

                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfvIndustry" runat="server" 
                                                    ControlToValidate="ddlIndustry" 
                                                    InitialValue="0" 
                                                    ErrorMessage="Industry is required." 
                                                    ForeColor="Red" 
                                                    Display="Dynamic"
                                                    ValidationGroup="CompanyForm"/>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="ddlIndustrySector" class="form-label">Industry Sector</label>
                                                <asp:DropDownList ID="ddlIndustrySector" runat="server" CssClass="form-select">
                                                    <asp:ListItem Text="-- Select Sector --" Value="" />
                                                    <asp:ListItem Text="It Sector" Value="1"></asp:ListItem>

                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfvIndustrySector" runat="server" 
                                                    ControlToValidate="ddlIndustrySector" 
                                                    InitialValue="" 
                                                    ErrorMessage="Industry Sector is required." 
                                                    ForeColor="Red" 
                                                    Display="Dynamic"
                                                    ValidationGroup="CompanyForm"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <table class="table table-bordered" id="phonesTable">
                                    <thead class="table-light">
                                        <tr>
                                            <th style="width: 30%;">Phone Type</th>
                                            <th style="width: 40%;">Telephone</th>
                                            <th style="width: 20%;">Country Code</th>
                                            <th style="width: 10%;padding-left: 4%;"">
                                                <a href="javascript:void(0);" onclick="addPhoneRow()">+</a>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="phonesBody">
                                        <!-- Dynamic Phone Rows will be appended here -->
                                    </tbody>
                                </table>
                                 <div class="text-centre mt-3" style="text-align: center;">
     <button type="button" ID="btnsavecompphone" runat="server" Class="btn btn-primary" Text="Save" ValidationGroup="CompanyForm" onclick="return funcsaveCompfinalPhone();">Submit</button>
 </div>
                            </div>
                        </div>
                        <hr class="hr-1" />
                    </div>
                </div>
            </div>


        </div>
    </div>
    <div class="modal" id="popaddcomp" tabindex="-1" role="dialog" aria-labelledby="popaddcomp" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Company</h5>
                </div>
                <div class="modal-body">
                    <div class="col-md-12">
                        <label class="form-label" for="basic-url">
                            <strong>Company Name :</strong><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Add Company Name" ControlToValidate="txtcompname" Font-Size="Small" ForeColor="Red" ValidationGroup="CompanyForm"></asp:RequiredFieldValidator>
                            <asp:HiddenField runat="server" ID="hdnCode" />
                            <asp:HiddenField runat="server" ID="hdnname" />
                        </label>
                        <div class="input-group mb-3">
                            <asp:TextBox ID="txtcompname" runat="server" MaxLength="6"
                                class="form-control" type="text" placeholder="Enter Unit Name" aria-label="Enter Unit Name" aria-describedby="basic-addon2" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="funPopSetupaddsave();return false;">Save changes</button>
                    <button type="button" class="btn btn-secondary" onclick="funPopSetupaddcomplose();return false;" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="popaddcompAdd" tabindex="-1" role="dialog" aria-labelledby="popaddcompAdd" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Address</h5>
            </div>
            <div class="modal-body">
               <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label"><strong>Effective Date</strong></label>
                            <asp:TextBox ID="txtcompAddEfDate" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvCompAddEfDate" runat="server" 
                                ControlToValidate="txtcompAddEfDate" 
                                ErrorMessage="Effective Date is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                                ValidationGroup="CompanyForm"/>
                            <asp:CalendarExtender ID="CalendarExtender1" runat="server"
                                TargetControlID="txtcompAddEfDate" Format="yyyy-MM-dd" />
                        </div>
                         <div class="col-md-6">
                            <label for="ddlcompAddStatus" class="form-label">Status</label>
                            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select">
                                <asp:ListItem Text="-- Select Status --" Value="" />
                                <asp:ListItem Text="Active" Value="Active" />
                                <asp:ListItem Text="Inactive" Value="Inactive" />
                            </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvCompAddStatus" runat="server" 
                                ControlToValidate="DropDownList2" 
                                InitialValue="-- Select Status --" 
                                ErrorMessage="Status is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                                ValidationGroup="CompanyForm"/>
                    </div>
                        <div class="col-md-6">
                        <label class="form-label"><strong>Description</strong></label>
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                            <asp:RequiredFieldValidator ID="rfvCompAddDescription" runat="server" 
                                ControlToValidate="TextBox3" 
                                ErrorMessage="Description is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                                ValidationGroup="CompanyForm"/>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label"><strong>Short Description</strong></label>
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="rfvCompAddShortDescr" runat="server" 
                                ControlToValidate="TextBox4" 
                                ErrorMessage="Short Description is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                            ValidationGroup="CompanyForm"/>
                    </div>
                       <div class="col-md-6">
                        <label class="form-label"><strong>Building</strong></label>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                           <asp:RequiredFieldValidator ID="rfvCompAddBuilding" runat="server" 
                                ControlToValidate="TextBox5" 
                                ErrorMessage="Building is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                               ValidationGroup="CompanyForm"/>
                    </div>
                       <div class="col-md-6">
                        <label class="form-label"><strong>Floor Number</strong></label>
                        <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                           <asp:RequiredFieldValidator ID="rfvCompAddFloor" runat="server" 
                                ControlToValidate="TextBox6" 
                                ErrorMessage="Floor Number is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                               ValidationGroup="CompanyForm"/>
                    </div>
                        <div class="col-md-6">
                                    <label for="ddlcompAddStatus" class="form-label">Language Code</label>
                                    <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="-- Select Status --" Value="" />
                                        <asp:ListItem Text="Language1" Value="Language1" />
                                        <asp:ListItem Text="Language2" Value="Language2" />
                                    </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCompAddLanguage" runat="server" 
                                ControlToValidate="DropDownList3" 
                                InitialValue="-- Select Language --" 
                                ErrorMessage="Language Code is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                                ValidationGroup="CompanyForm"/>
                            </div>
                   <div class="col-md-12">
                    <label class="form-label"><strong>Address</strong></label>
                    <div class="input-group">
                        <asp:TextBox ID="TextBox7" ReadOnly="true" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                        <span class="input-group-text">
                        <a href="javascript:void(0);" onclick="popeditaddadd();">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit-2 text-body fs-5"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path></svg>
                        </a>
                        </span>
                    </div>
</div>
                   </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="popeditaddsave();return false;">Save changes</button>
                <button type="button" class="btn btn-secondary" onclick="popeditaddclose();return false;" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
    
        <div class="modal" id="popeditaddadd" tabindex="-1" role="dialog" aria-labelledby="popaddcompAdd" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Address</h5>
            </div>
            <div class="modal-body">
               <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label"><strong>Country</strong></label>
                            <asp:TextBox ReadOnly="true" ID="txtpopeditaddaddcountry" runat="server" CssClass="form-control" />
                        </div>
                         <div class="col-md-4">
                            <label for="ddlpopeditaddaddcountrystate" class="form-label">State</label>
                            <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-select">
                                <asp:ListItem Text="-- Select State --" Value="" />
                                <asp:ListItem Text="State1" Value="1" />
                                <asp:ListItem Text="State2" Value="2" />
                                <asp:ListItem Text="State3" Value="3" />
                                <asp:ListItem Text="State4" Value="4" />
                            </asp:DropDownList>
                              <asp:RequiredFieldValidator ID="rfvState" runat="server" 
                                ControlToValidate="DropDownList4" 
                                InitialValue="-- Select State --" 
                                ErrorMessage="State is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                                  ValidationGroup="CompanyForm"/>
                    </div>
                             <div class="col-md-4">
                                    <label for="ddlpopeditaddaddcountrydistrict" class="form-label">District</label>
                                    <asp:DropDownList ID="DropDownList6" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="-- Select State --" Value="" />
                                        <asp:ListItem Text="District1" Value="1" />
                                        <asp:ListItem Text="District2" Value="2" />
                                        <asp:ListItem Text="District3" Value="3" />
                                        <asp:ListItem Text="District4" Value="4" />
                                    </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                                ControlToValidate="DropDownList6" 
                                InitialValue="-- Select District --" 
                                ErrorMessage="District is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                                ValidationGroup="CompanyForm"/>
                            </div>
                    <div class="col-md-12">
                        <label class="form-label"><strong>Address 1</strong></label>
                        <asp:TextBox ID="txtpopeditaddaddcountryAdd1" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                        <asp:RequiredFieldValidator ID="rfvAddress1" runat="server" 
                                ControlToValidate="txtpopeditaddaddcountryAdd1" 
                                ErrorMessage="Address 1 is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                            ValidationGroup="CompanyForm"/>
                    </div>
                       <div class="col-md-12">
                        <label class="form-label"><strong>Address 2</strong></label>
                        <asp:TextBox ID="txtpopeditaddaddcountryadd2" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                           <asp:RequiredFieldValidator ID="rfvAddress2" runat="server" 
                                ControlToValidate="txtpopeditaddaddcountryadd2" 
                                ErrorMessage="Address 2 is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                               ValidationGroup="CompanyForm"/>
                    </div>
                       <div class="col-md-6">
                        <label class="form-label"><strong>Pin Code</strong></label>
                        <asp:TextBox ID="txtpopeditaddaddcountrypincode" MaxLength="6" runat="server" CssClass="form-control" />
                           <asp:RequiredFieldValidator ID="rfvPinCode" runat="server" 
                                ControlToValidate="txtpopeditaddaddcountrypincode" 
                                ErrorMessage="Pin Code is required." 
                                ForeColor="Red" 
                                Display="Dynamic"
                               ValidationGroup="CompanyForm"/>
                    </div>
                   </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="popeditaddaddsave();return false;">Save changes</button>
                <button type="button" class="btn btn-secondary" onclick="popeditaddaddclose();return false;" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Include Bootstrap JS (needed for tabs and collapse) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        function addPhoneRow() {
            const rowId = Date.now();
            const row = `
            <tr id="phoneRow-${rowId}">
                <td>
                    <select name="ddlPhoneType" class="form-select">
                        <option value="">-- Select Type --</option>
                        <option value="Mobile">Mobile</option>
                        <option value="Home">Home</option>
                        <option value="Work">Work</option>
                        <option value="Other">Other</option>
                    </select>
                </td>
                <td>
                    <input type="text" name="txtTelephone" class="form-control" placeholder="Enter Telephone" />
                </td>
                <td>
                    <input type="text" name="txtCountryCode" class="form-control" placeholder="Country Code" />
                </td>
                <td style='padding-left: 4%;"'>
                    <a style='color:red;' onclick="removePhoneRow('${rowId}')">x</button>
                </td>
            </tr>
        `;
            $('#phonesBody').append(row);
        }

        function removePhoneRow(rowId) {
            $(`#phoneRow-${rowId}`).remove();
        }

        function addEmailRow() {
            const rowId = Date.now(); // Unique ID per row
            const row = `
            <tr id="row-${rowId}">
                <td>
                    <select name="ddlAddressType" class="form-select">
                        <option value="">-- Select Type --</option>
                        <option value="Personal">Personal</option>
                        <option value="Work">Work</option>
                        <option value="Other">Other</option>
                    </select>
                </td>
                <td>
                    <input type="text" name="txtEmail" class="form-control" placeholder="Enter Email Address" />
                </td>
                <td style='padding-left: 4%;"'>
                    <a href="javascript:void(0);" style="color:red;" onclick="removeRow('${rowId}')">x</button>
                </td>
            </tr>
        `;
            $('#emailBody').append(row);
        }

        function removeRow(rowId) {
            $(`#row-${rowId}`).remove();
        }

        function funPopSetupaddcomp() {
            $('#popaddcomp').show();
        }
        function funPopSetupaddcomplose() {
            $('#popaddcomp').hide();
        }
        function popeditadd() {
            $("#popaddcompAdd").show();
        }
        function popeditaddclose() {
            $("#popaddcompAdd").hide();
        }
        function popeditaddadd() {
            $("#popeditaddadd").show();
        }
        function popeditaddaddclose() {
            $("#popeditaddadd").hide();
        }
        function popeditaddsave() {
            var adtxt = "";
            adtxt += "Efective Date :" + document.getElementById("<%=txtcompAddEfDate.ClientID%>").value + "\n";
            adtxt += "Status :" + $("#<%=DropDownList2.ClientID%>").val() + "\n";
            adtxt += "Description :" + document.getElementById("<%=TextBox3.ClientID%>").value + "\n";
            adtxt += "Short Description :" + document.getElementById("<%=TextBox4.ClientID%>").value + "\n";
            adtxt += "Building :" + document.getElementById("<%=TextBox5.ClientID%>").value + "\n";
            adtxt += "Floor No :" + document.getElementById("<%=TextBox6.ClientID%>").value + "\n";
            adtxt += "Language Code :" + $("#<%=DropDownList3.ClientID%>").val() + "\n";
            adtxt += "Country :" + document.getElementById("<%=txtpopeditaddaddcountry.ClientID%>").value + "\n";
            adtxt += "State :" + $("#<%=DropDownList4.ClientID%>").val() + "\n";
            adtxt += "District :" + $("#<%=DropDownList6.ClientID%>").val() + "\n";
            adtxt += "Add1 :" + document.getElementById("<%=txtpopeditaddaddcountryAdd1.ClientID%>").value + "\n";
            adtxt += "Add2 :" + document.getElementById("<%=txtpopeditaddaddcountryadd2.ClientID%>").value + "\n";
            adtxt += "Pin-Code :" + document.getElementById("<%=txtpopeditaddaddcountrypincode.ClientID%>").value + "\n";
            document.getElementById("<%=txtAddress.ClientID%>").value = adtxt;
            popeditaddclose();
        }
        function popeditaddaddsave() {
            var adtxt = "";
            adtxt += "Country :" + document.getElementById("<%=txtpopeditaddaddcountry.ClientID%>").value + "\n";
            adtxt += "State :" + $("#<%=DropDownList4.ClientID%>").val() + "\n";
            adtxt += "District :" + $("#<%=DropDownList6.ClientID%>").val() + "\n";
            adtxt += "Add1 :" + document.getElementById("<%=txtpopeditaddaddcountryAdd1.ClientID%>").value + "\n";
            adtxt += "Add2 :" + document.getElementById("<%=txtpopeditaddaddcountryadd2.ClientID%>").value + "\n";
            adtxt += "Pin-Code :" + document.getElementById("<%=txtpopeditaddaddcountrypincode.ClientID%>").value + "\n";
            document.getElementById("<%=TextBox7.ClientID%>").value = adtxt;
            popeditaddaddclose();
        }
        function funcsaveCompfinal() {
            
            document.getElementById("<%=TextBox1.ClientID%>").value = document.getElementById("<%=txtEffectiveDate.ClientID%>").value;
            $("#<%=DropDownList1.ClientID%>").val($("#<%=ddlStatus.ClientID%>").val());
            document.getElementById("<%=TextBox2.ClientID%>").value = document.getElementById("<%=txtDescription.ClientID%>").value;
            funPopSetupclose();
            funPopSetup1();
            return false;
        }
        function funPopSetup() {
            $("#example-code").addClass("show");
        }
        function funPopSetupclose() {
            $("#example-code").removeClass("show");
        }
        function funPopSetup1() {
            $("#example-code1").addClass("show");
        }
        function funPopSetup1close() {
            $("#example-code1").removeClass("show");
        }
        function funPopSetupaddsave() {
            document.getElementById('<%=txtcompnameReadonly.ClientID%>').value = document.getElementById('<%=txtcompname.ClientID%>').value;
            document.getElementById('<%=txtCompany.ClientID%>').value = document.getElementById('<%=txtcompname.ClientID%>').value;
            document.getElementById('<%=txtpopeditaddaddcountry.ClientID%>').value = document.getElementById('<%=txtcompname.ClientID%>').value;
            funPopSetupaddcomplose();
            funPopSetup();
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                return false;
            }
        }
        function funcsaveCompfinalPhone() {
            if (Page_ClientValidate('CompanyForm')) {
                var dataTable = [];
                dataTable.push({
                    companyName: document.getElementById("<%=txtcompnameReadonly.ClientID%>").value,
                    effectiveDate: document.getElementById("<%=txtEffectiveDate.ClientID%>").value,
                    status: $("#<%=ddlStatus.ClientID%>").val(),
                    description: document.getElementById("<%=txtDescription.ClientID%>").value,
                    shortDescription: document.getElementById("<%=txtShortDescr.ClientID%>").value,
                    location: document.getElementById("<%=txtLocation.ClientID%>").value,
                    defaultSetID: $("#<%=txtDefaultSetID.ClientID%>").val(),
                    country: $("#<%=txtCountry.ClientID%>").val(),
                    building: document.getElementById("<%=TextBox5.ClientID%>").value,
                    Floor_No: document.getElementById("<%=TextBox6.ClientID%>").value,
            languageCode: $("#<%=DropDownList3.ClientID%>").val(),
            state: $("#<%=DropDownList4.ClientID%>").val(),
            district: $("#<%=DropDownList6.ClientID%>").val(),
            address1: document.getElementById("<%=txtpopeditaddaddcountryAdd1.ClientID%>").value,
            address2: document.getElementById("<%=txtpopeditaddaddcountryadd2.ClientID%>").value,
            pinCode: document.getElementById("<%=txtpopeditaddaddcountrypincode.ClientID%>").value,
            industry: $("#<%=ddlIndustry.ClientID%>").val(),
            industrySector: $("#<%=ddlIndustrySector.ClientID%>").val(),
            ip: document.getElementById("<%=txtpopeditaddaddcountry.ClientID%>").value
                });

                // Add email data
                var emailData = [];
                $("#emailBody tr").each(function () {
                    var row = $(this);
                    var addressType = row.find("select[name='ddlAddressType']").val();
                    var emailAddress = row.find("input[name='txtEmail']").val();
                    if (emailAddress) {
                        emailData.push({ addressType: addressType, emailAddress: emailAddress });
                    }
                });

                // Collect Phone Data (Company Phone Info)
                var phoneData = [];
                $("#phonesBody tr").each(function () {
                    var row = $(this);
                    var phoneType = row.find("select[name='ddlPhoneType']").val();
                    var telephone = row.find("input[name='txtTelephone']").val();
                    var countryCode = row.find("input[name='txtCountryCode']").val();
                    if (telephone) {
                        phoneData.push({ phoneType: phoneType, telephone: telephone, countryCode: countryCode });
                    }
                });

                // Combine all data into a single object
                var dataToSend = {
                    companyData: dataTable,
                    emailData: emailData,
                    phoneData: phoneData
                };

                // Log the data being sent
                console.log("Data to send:", JSON.stringify(dataToSend));

                // Send the DataTable to the server
                $.ajax({
                    type: "POST",
                    url: "/DropdownWebservice.asmx/SaveCompanyFullData",
                    data: JSON.stringify({ jsonData: JSON.stringify(dataToSend) }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert("Company full data saved successfully.");
                    },
                    error: function (xhr, status, error) {
                        console.error("Error details:", xhr.responseText);
                        alert("Error saving company data: " + xhr.responseText);
                    }
                });
            } else {
                return false; // Prevent default form submission
            }
        }


    </script>
</asp:Content>

