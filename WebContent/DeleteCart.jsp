<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<%
	//如果session有紀錄 就取出
	Cart cart = (Cart)session.getAttribute("cart");
	if(cart == null){
		return;
	}
%>
<%
	request.setCharacterEncoding("utf-8");
	String strId = request.getParameter("id");
	System.out.print(strId);
	if(strId != null){
		int id = Integer.parseInt(strId);
		cart.delete(id);
		response.sendRedirect("Cart.jsp");
	}
		%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>