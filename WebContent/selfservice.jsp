<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.cn.shopping.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <a href="Index01.jsp" ><img src="images/index/index.jpg" width="250" height="100" ></a> 
<%
	User u = (User)session.getAttribute("user");
	if(u == null){
		out.print("You haven.t logged in");
		return ;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="usermodify.jsp">修改個人訊息</a>
</body>
</html>