using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Data.Filtering;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;

public partial class _Default : System.Web.UI.Page
{
    protected void grid_ProcessColumnAutoFilter(object sender, ASPxGridViewAutoFilterEventArgs e)
    {
        if (e.Column.FieldName != "Roles")
            return;

        if (e.Kind == GridViewAutoFilterEventKind.CreateCriteria)
        {
            if (e.Value == "")
                return;
            string[] values = e.Value.Split(',');
            string criteria = string.Empty;

            GroupOperator group = new GroupOperator();
            if (popupMenu.Items[0].Checked)
                group.OperatorType = GroupOperatorType.Or;
            else
                group.OperatorType = GroupOperatorType.And;
            foreach (string value in values)
            {
                string leftOperand = e.Column.FieldName;
                string rightOperand = string.Format("%{0}%", value);
                BinaryOperator op = new BinaryOperator(leftOperand, rightOperand, BinaryOperatorType.Like);
                group.Operands.Add(op);
            }
            e.Criteria = group;
        }
    }
}