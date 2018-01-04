<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("utf-8");
	User u = (User)session.getAttribute("user");
	if(u == null ){
		out.print("尚未登入，無法購買");
		out.print("<br><a href=login.jsp >登入</a> &nbsp;&nbsp;&nbsp;<a href=Register.jsp >註冊</a>");
		return;
	}
	
	Cart cart = (Cart)session.getAttribute("cart");
	if(cart == null && SalesOrder.getsingleCart() == null){
		out.print("尚未購買任何產品");
		return;
	}else{
		
	}
	String filter = request.getParameter("filter");
	if( filter == null){
		out.print("禁止跳轉頁面");
		return;
	}
	
	String addr = request.getParameter("addr");
	String strDelivery = request.getParameter("delivery");
	String strPhoneTitle = request.getParameter("phonetitle");
	String strPhone = request.getParameter("phone");
	
	
	if( SalesOrder.getsingleCart() == null && cart != null ){
		SalesOrder.setsingleCart(null);//先把SalesOrder初始化
		//out.print("購物車購買");
		SalesOrder so = new SalesOrder();
		strPhone = strPhoneTitle + strPhone;
		int delivery =  Integer.parseInt(strDelivery);
		
		so.setUser(u);
		so.setAddr(addr);
		so.setPhone(strPhone);
		so.setCart(cart);
		so.setDelivery(delivery);
		so.setoDate(new Timestamp(System.currentTimeMillis()));
		so.setStatus(0);
		OrderMgr.getInstanct().save(so);
		session.removeAttribute("cart");
	}else if(SalesOrder.getsingleCart() != null ){
		//out.print("單一購買");
		SalesOrder so = new SalesOrder();
		strPhone = strPhoneTitle + strPhone;
		int delivery =  Integer.parseInt(strDelivery);
		
		so.setUser(u);
		so.setAddr(addr);
		so.setPhone(strPhone);
		so.setCart(SalesOrder.getsingleCart());
		so.setDelivery(delivery);
		so.setoDate(new Timestamp(System.currentTimeMillis()));
		so.setStatus(0);
		OrderMgr.getInstanct().save(so);
		SalesOrder.setsingleCart(null);
	}else{
		out.print("失敗");
	}
	out.print("恭喜你 您買的商品已經下單 !");	
	
	
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<body>
<a href="Index01.jsp"><center>返回主頁</center></a>
</body>
</html>