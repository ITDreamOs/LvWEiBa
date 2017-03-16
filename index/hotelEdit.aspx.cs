using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_hotelEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) {
            hotelId.Value =Request.QueryString["id"];
            refreshInfo();
        }
    }

    protected int getHotelId() {
        return int.Parse(hotelId.Value);
    }

    protected void refreshInfo()
    {
        LVWEIBA.BLL.MemberHotel bllhotel = new LVWEIBA.BLL.MemberHotel();
        MemberHotel memberHotel = bllhotel.GetModel(getHotelId());
        hotelname.Text = memberHotel.Name;
        card.Text = memberHotel.Card;
        Mobile.Text = memberHotel.Mobile;
        hotelType.Items.Clear();
        if (memberHotel.Type.Equals("0"))
        {
            hotelType.Items.Add(new ListItem("成人", "0"));
            hotelType.Items.Add(new ListItem("儿童", "1"));
        }
        if (memberHotel.Type.Equals("1"))
        {
            hotelType.Items.Add(new ListItem("儿童", "1"));
            hotelType.Items.Add(new ListItem("成人", "0"));
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        LVWEIBA.BLL.MemberHotel bllhotel = new LVWEIBA.BLL.MemberHotel();
        MemberHotel memberHotel = bllhotel.GetModel(getHotelId());
        memberHotel.Name = hotelname.Text;
        memberHotel.Card = card.Text;
        memberHotel.Mobile = Mobile.Text;
        memberHotel.Type = hotelType.SelectedValue;
        if (bllhotel.Update(memberHotel)) {
            refreshInfo();
            Response.Write(String.Format("<script>alert('信息修改成功');window.location='hotel.aspx';</script>"));
        }
    }        
}