Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Data.Filtering
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView

Partial Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub grid_ProcessColumnAutoFilter(ByVal sender As Object, ByVal e As ASPxGridViewAutoFilterEventArgs)
        If e.Column.FieldName <> "Roles" Then
            Return
        End If

        If e.Kind = GridViewAutoFilterEventKind.CreateCriteria Then
            If e.Value = "" Then
                Return
            End If
            Dim values() As String = e.Value.Split(","c)
            Dim criteria As String = String.Empty

            Dim group As New GroupOperator()
            If popupMenu.Items(0).Checked Then
                group.OperatorType = GroupOperatorType.Or
            Else
                group.OperatorType = GroupOperatorType.And
            End If
            For Each value As String In values
                Dim leftOperand As String = e.Column.FieldName
                Dim rightOperand As String = String.Format("%{0}%", value)
                Dim op As New BinaryOperator(leftOperand, rightOperand, BinaryOperatorType.Like)
                group.Operands.Add(op)
            Next value
            e.Criteria = group
        End If
    End Sub
End Class