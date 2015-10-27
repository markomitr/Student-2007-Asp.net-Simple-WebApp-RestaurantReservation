<%@ Page Language="C#" MasterPageFile="MasterRestoran.master" AutoEventWireup="true" CodeFile="Rezervacii.aspx.cs" Inherits="Rezervacii" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript" src="Scripti/jquery-1.4.2.min.js"></script>
      <script src="Scripti/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripti/Proverki.js"></script>
    <link href="Stilovi/jquery-ui-1.8.2.custom1.css" rel="stylesheet" type="text/css" />
    <link href="Stilovi/Stil.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<img class="slikaRez" src="Images/Rezervacija.jpg" />
<div>
<fieldset>
<legend>Резервација</legend>
    <table>
    <tr>
    <td>Ресторан</td>
    <td><asp:DropDownList class="restoraniRez" ID="ddlRestorani" runat="server"></asp:DropDownList></td>
    <td>Време</td>
    <td>
        <asp:DropDownList class="vremeRez" ID="ddlVreme" runat="server">
        <asp:ListItem Text="9" Value="9" ></asp:ListItem>
        <asp:ListItem Text="10" Value="10" ></asp:ListItem>
        <asp:ListItem Text="11" Value="11" ></asp:ListItem>
        <asp:ListItem Text="12" Value="12" ></asp:ListItem>
        <asp:ListItem Text="13" Value="13" ></asp:ListItem>
        <asp:ListItem Text="14" Value="14" ></asp:ListItem>
        <asp:ListItem Text="15" Value="15" ></asp:ListItem>
        <asp:ListItem Text="16" Value="16" ></asp:ListItem>
        <asp:ListItem Text="17" Value="17" ></asp:ListItem>
        <asp:ListItem Text="18" Value="18" ></asp:ListItem>
        <asp:ListItem Text="19" Value="19" ></asp:ListItem>
        <asp:ListItem Text="20" Value="20" ></asp:ListItem>
        <asp:ListItem Text="21" Value="21" ></asp:ListItem>
        <asp:ListItem Text="22" Value="22" ></asp:ListItem>
        </asp:DropDownList>

    </td>
    </tr>
    <tr>
    <td>Датум</td>
    <td><asp:TextBox ID="txtBoxDatum" tip="Datum" runat="server"></asp:TextBox></td>
    <td>Број на Лица</td>
    <td>
        <asp:TextBox Width="50px" ID="txtBoxBrLica" onkeyup="zabraniRezervacii(event,this.id)" runat="server"></asp:TextBox></td>
    </tr> 
    <tr>
    <td>
        <asp:RequiredFieldValidator ID="ReqFieldDatum" Display="None" ValidationGroup="Rezervacija"  runat="server" ControlToValidate="txtBoxDatum" ErrorMessage="Внесете датум"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="ReqFieldLica" Display="None" ValidationGroup="Rezervacija"  runat="server" ControlToValidate="txtBoxBrLica" ErrorMessage="Внесете број на лица"></asp:RequiredFieldValidator>
     </td>
    </tr>
    </table>
    </fieldset>
    
    <fieldset>
    <legend>Информации</legend>
    <table>
    <tr>
    <td>Име</td>
    <td> <asp:TextBox ID="txtBoxIme" runat="server"></asp:TextBox></td>
    <td>Тел</td>
    <td> <asp:TextBox ID="txtBoxTel" runat="server"></asp:TextBox></td>
    <td></td>
    <td></td>
    </tr>
    <tr>
    <td>е-пошта</td>
    <td><asp:TextBox ID="txtBoxEmail" runat="server"></asp:TextBox></td>
    <td>Барања</td>
    <td colspan="2"><asp:TextBox ID="txtBoxBaranje" TextMode="MultiLine"  runat="server"></asp:TextBox></td>
    </tr>
    <tr>
    <td class="tdKopcinja" colspan="5">
     <asp:Button ID="btnOtkazi" runat="server" Text="Откажи" 
            onclick="btnOtkazi_Click" />
    <asp:Button ID="btnRezerviraj" ValidationGroup="Rezervacija"  runat="server" Text="Резервирај" onclick="Rezerviraj_Click" />
    </td>
    </tr>
    <tr>
    <td>
        <asp:RequiredFieldValidator ID="ReqFieldIme" Display="None" ValidationGroup="Rezervacija"  runat="server" ControlToValidate="txtBoxIme" ErrorMessage="Внесете име"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="ReqFieldTel" Display="None" ValidationGroup="Rezervacija"  runat="server" ControlToValidate="txtBoxTel" ErrorMessage="Внесете Телефон"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="ReqFieldEmail" Display="None" ValidationGroup="Rezervacija"  runat="server" ControlToValidate="txtBoxEmail" ErrorMessage="Внесете е-пошта"></asp:RequiredFieldValidator>
     </td>
    </tr>
    </table>
    </fieldset> 
    <fieldset>
    <legend>Статус</legend>
    <table>
    <tr>
    <td><asp:ValidationSummary CssClass="validatorGreski" ID="ValidationSummary1" ValidationGroup="Rezervacija"  runat="server" HeaderText="Страната ги има следните гршки" /></td>
    </tr>
    <tr>
    <td><div id="statusDiv" class="statusInfo" runat="server"></div></td>
    </tr>
    <tr>
    <td><div id="greskiDiv" class="greskaServer" runat="server"></div></td>
    </tr>
    </table>
    </fieldset>
    </div>
    
</asp:Content>