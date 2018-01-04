<%@page import="com.cn.shopping.PasswordNotCorrectException"%>
<%@page import="com.cn.shopping.UserNotFoundException"%>
<%@page import="com.cn.shopping.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
session.removeAttribute("user");
response.sendRedirect("Index01.jsp");
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>小鑫商城</title>

</head>
<body>


</body>
</html>