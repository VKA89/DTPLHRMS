<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmReg.aspx.cs" Inherits="Accounts_FrmReg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration Form</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="keywords" content="" />
    <meta name="author" content="" />
    <meta name="robots" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="HRMS" />
    <meta property="og:title" content="HRMS" />
    <meta property="og:description" content="HRMS" />
    <meta name="format-detection" content="telephone=no" />
    <link rel="icon" type="image/png" sizes="32x32" href="/assets/images/favicon.png" />
    <!-- PAGE TITLE HERE -->
    <link href="/Assets/css/style.css" rel="stylesheet" />
    <style>
        .btn-primary {
            background-color: #910c09;
            border: 1px solid #910c09;
        }

        body {
            background-image: url("Assets/images/background.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            font-family: "Nunito", sans-serif;
        }

        .auth-form {
            box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px;
            margin-top: 130px;
            margin-bottom: 50px;
            background-color: white;
            border-radius: 20px;
        }

            .auth-form div:first-child {
                position: relative;
            }

            .auth-form .imgDesing {
                position: absolute;
                top: -129px;
                left: 0;
                right: 0;
                margin: auto;
                height: 160px;
                width: 160px;
                border-radius: 50%;
                z-index: 0;
            }

            .auth-form a img {
                width: 100%;
                z-index: 99;
                position: relative;
            }

        .authincation {
            background-image: -webkit-linear-gradient(145deg, rgb(175 31 250 / 27%) 0%, rgb(24 237 227 / 13%) 100%);
            z-index: 99;
            position: relative;
        }

            .authincation:after {
                content: "";
                width: 100%;
                height: 100%;
                position: absolute;
                background: url("Assets/images/shape.png") no-repeat scroll center bottom;
                background-size: cover;
                top: 0;
                z-index: 0;
            }

        .welcomeMSG {
            position: absolute;
            right: 1%;
            top: 80%;
            transform: translate(-50%, 0);
            z-index: 999;
            font-size: 20px;
            font-weight: 700;
            font-family: sans-serif;
        }

            .welcomeMSG span {
                color: #910c09;
            }

        @media only screen and (max-width: 575px) {
            .welcomeMSG {
                position: absolute;
                bottom: -22px;
                right: 0;
                width: 100%;
                transform: translate(0%, 0);
                top: auto;
                padding-left: 20%;
                font-size: 13px;
            }

                .welcomeMSG p {
                    font-size: 13px !important;
                    font-weight: normal;
                }
        }
    </style>
</head>
<body>
    
                                    <form id="form1" runat="server">
                                        <div>
                                            <div class="mb-0">
                                                <label class="mb-1"><strong>User Name :</strong></label>
                                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
                                                <asp:RequiredFieldValidator ID="Requ1" runat="server" ErrorMessage="Enter Username" ControlToValidate="txtUsername" Font-Size="Small" ForeColor="Red" ValidationGroup="AA"></asp:RequiredFieldValidator>
                                            </div>

                                            <div class="mb-0">
                                                <label class="mb-1"><strong>Password :</strong></label>
                                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtPassword" Font-Size="Small" ForeColor="Red" ValidationGroup="AA"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="mb-0">
                                                <label class="mb-1"><strong>Name :</strong></label>
                                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Name" ControlToValidate="txtName" Font-Size="Small" ForeColor="Red" ValidationGroup="AA"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="row d-flex text-right mt-0 mb-2">
                                                <div class="mb-1">
                                                     <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                                                </div>
                                            </div>
                                            <div class="text-center">
                                                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn btn-primary btn-block" ValidationGroup="AA" />
                                               
                                            </div>
                                    </form>
                                    
</body>
</html>

