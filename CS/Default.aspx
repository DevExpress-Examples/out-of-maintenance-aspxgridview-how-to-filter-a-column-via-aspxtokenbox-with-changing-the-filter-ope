<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript">
        var tokenCollection;
        function ApplyTokenFilter() {
            tokenCollection = FilterTokenBox.GetTokenCollection()
            grid.AutoFilterByColumn("Roles", tokenCollection);
        }
        function OnEndCallback(s, e) {
            if (tokenCollection != null)
                FilterTokenBox.SetTokenCollection(tokenCollection);
        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxGridView ID="grid" runat="server" AutoGenerateColumns="False" Width="600" DataSourceID="dsUsers" KeyFieldName="ID" OnProcessColumnAutoFilter="grid_ProcessColumnAutoFilter">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="UserName" Caption="User Name" ReadOnly="true" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTokenBoxColumn FieldName="Roles" VisibleIndex="2">
                    <Settings SortMode="DisplayText" FilterMode="DisplayText" />
                    <PropertiesTokenBox DataSourceID="dsUserRoles" TextField="Name" ValueField="ID" AllowCustomTokens="false" IncrementalFilteringMode="Contains" ShowDropDownOnFocus="Always"></PropertiesTokenBox>
                    <FilterTemplate>
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <dx:ASPxImage ID="filterOperator" runat="server" AlternateText="Operator">
                                        <EmptyImage IconID="filter_masterfilter_16x16" AlternateText="Operator">
                                        </EmptyImage>
                                        <ClientSideEvents Click="function(s, e){ popupMenu.ShowAtElement(s.GetMainElement()); }" />
                                    </dx:ASPxImage>
                                </td>
                                <td style="width: 100%">
                                    <dx:ASPxTokenBox ID="FilterTokenBox" ClientInstanceName="FilterTokenBox" Width="100%" runat="server" DataSourceID="dsUserRoles" TextField="Name" ValueField="ID" AllowCustomTokens="false" IncrementalFilteringMode="Contains" ShowDropDownOnFocus="Always">
                                    </dx:ASPxTokenBox>
                                </td>
                                <td>
                                    <dx:ASPxHyperLink ID="ApplyFilterHL" runat="server" Text="Apply">
                                        <ClientSideEvents Click="function(s, e){ ApplyTokenFilter(); }" />
                                    </dx:ASPxHyperLink>
                                </td>
                            </tr>
                        </table>
                    </FilterTemplate>
                </dx:GridViewDataTokenBoxColumn>
            </Columns>
            <Settings ShowFilterRow="true" />
            <ClientSideEvents EndCallback="OnEndCallback" />
        </dx:ASPxGridView>
        <asp:AccessDataSource ID="dsUsers" runat="server" DataFile="~/App_Data/EditorsSampleDB.mdb"
            SelectCommand="SELECT [ID], [UserName], [Roles] FROM [Users]"></asp:AccessDataSource>
        <asp:AccessDataSource ID="dsUserRoles" runat="server" DataFile="~/App_Data/EditorsSampleDB.mdb"
            SelectCommand="SELECT [ID], [Name] FROM [UserRoles]"></asp:AccessDataSource>
        <dx:ASPxPopupMenu ID="popupMenu" runat="server" ClientInstanceName="popupMenu" PopupAction="LeftMouseClick">
            <Items>
                <dx:MenuItem Text="Or" Checked="true" GroupName="operator">
                </dx:MenuItem>
                <dx:MenuItem Text="And" GroupName="operator">
                </dx:MenuItem>
            </Items>
        </dx:ASPxPopupMenu>
    </form>
</body>
</html>
