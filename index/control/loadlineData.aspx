<%@ Page Language="C#" AutoEventWireup="true" CodeFile="loadlineData.aspx.cs" Inherits="index_control_loadlineData" %>
<asp:repeater id="rptList" runat="server"><ItemTemplate>
                              <a href="showline.aspx?code=<%#Eval("ProNumCode") %>&lineid=<%#Eval("id") %>" class="picks">
              <div class="head">
                 <%#Convert.ToDateTime(Eval("sdate").ToString()).ToString("yyyy-MM-dd") %> <%#Eval("Splace") %>出发
                <div class="seat">余位<em><%#Eval("adultTicketCount") %></em></div>
              </div>
              <div class="box">
                <img src="<%#Eval("Spicc") %>" alt="">
                <div class="mask">
                 <%#subttl(Eval("TTl").ToString()) %> 
                  <div class="price">￥<%#Eval("adultSellPrice") %></div>
                </div>
                <div class="agio"><%#zhekou(Eval("adultSellPrice").ToString(),Eval("adultTicketPrice").ToString()) %>折</div>
                <div class="type"><%#typeget(Eval("kindof").ToString()) %></div>
              </div>
              <div class="foot">
                 <%#Eval("provider") %>
                <div class="time">剩<em><%#Diffdatebynow(Eval("sdate").ToString()) %></em></div>
              </div>
            </a>
              </ItemTemplate></asp:repeater>
