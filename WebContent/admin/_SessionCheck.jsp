<%
String admin = (String)session.getAttribute("admin");
if(admin == null  || !admin.equals("admin")) {
	response.sendRedirect("Login.jsp");
}
%>