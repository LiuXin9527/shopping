<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.cn.shopping.*" %>
<%@ page import="java.sql.*" %>
 <a href="Index01.jsp" ><img src="images/index/index.jpg" width="250" height="100" ></a> 
<%
	User u = (User)session.getAttribute("user");
	if(u == null){
		out.print("You haven.t logged in");
		return ;
	}
%>
    
    <!-- 在我們這個頁面絕對不會應用到數據庫 絕對不會  只會跟業務邏輯打交道-->
  
<%
	request.setCharacterEncoding("UTF-8");
 	String action = request.getParameter("action");
 	if(action != null && action.trim().equals("modify")){
 		String password = request.getParameter("password");
 		String phone = request.getParameter("phone");
		
		u.setPassword(password);
		u.setPhone(phone);

		//u.save();
		u.update();
		out.print("修改成功"); 
	} 
%>

<html>
<head>

<title>Insert title here</title>
</head>
<body>
					<h1>個人訊息</h1>  
	<form method="post" name="form" action="usermodify.jsp" >
		<input type="hidden" name="action" value="modify"/>
		
		<table class="tableborder" align="center" cellpadding="4" cellspacing="1" width="97%">
		<tbody><tr> 
		</tr>
		<tr>
		<td class="altbg1" width="21%" >用戶名稱:</td>
		<td class="altbg2">
		<input id="userid" name="password"   type="text" value=<%=u.getUsername()%> disabled="disabled" > 
		<span id="usermsg"></span>
		</tr>
	
		<tr>
			<td class="altbg1">密碼;:</td>
			<td class="altbg2"><input name="password" type="text" id="phone" value=<%=u.getPassword()%>></td>
		</tr>
		<tr>
			<td class="altbg1" valign="top">電話:</td>
			<td class="altbg2">
			<input type="text" name="phone"  id="addr" value="<%=u.getPhone()%>" ></td>
		</tr>
		</tbody></table>
		<br>
		<center><input value="提 交" type="submit">
		<input type="reset" value="重製"></center>
	</form>

</body>
</html>