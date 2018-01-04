<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.cn.shopping.* , java.sql.*" %>
<%@ include file="_SessionCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	User.deleteUser(id);
%>

<script type="text/javascript">
document.location.href="UserList.jsp";
alert("刪除成功")
</script>

</body>
</html>