<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.cn.shopping.*" %>
<%@ page import="java.sql.*" %>

    
    <!-- 在我們這個頁面絕對不會應用到數據庫 絕對不會  只會跟業務邏輯打交道-->
<%
	request.setCharacterEncoding("UTF-8");
 	String action = request.getParameter("action");
 	if(action != null && action.trim().equals("register")){
 		String username = request.getParameter("username");
 		String password = request.getParameter("pwd");
 		String phone = request.getParameter("phone");
		User u = new User();
		u.setUsername(username);
		u.setPassword(password);
		u.setPhone(phone);
		u.setRdate(new Timestamp(System.currentTimeMillis()));
		u.save();
	} 
%>
<html>
<head>

<title>小鑫商城</title>
<link rel="alternate icon" href="assets/i/favicon.png">
<link rel="stylesheet" href="assets/css/amazeui.min.css">
<link rel="stylesheet" href="assets/css/app.css">
<script type="text/javascript" src="script/regcheckdata.js"></script>
<style type="text/css">
	 body{
               background:#FFF url(http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/03/81/3ed4501ef0fb41bb92a99ee2772ffef9.jpg) repeat -100px 0 fixed 
               }
</style>
</head>
<body>
<a href="Index01.jsp" ><img src="images/index/index.jpg" width="250" height="100" ></a> 
<a href="Index01.jsp">返回主頁</a>
	 <div class="title">
        <div class="am-g am-g-fixed">
            <div class="am-u-sm-12">
                <h1 class="am-text-primary">帳號註冊</h1>
            </div>
        </div>
    </div>  
	<form method="post" name="form" action="Register.jsp" onSubmit="return checkdata() ">
		<input type="hidden" name="action" value="register"/>
	
		<table class="tableborder" align="center" cellpadding="4" cellspacing="1" width="97%">
		<tbody><tr> 
		</tr>
		<tr>
		<td class="altbg1" width="21%" >帳號:</td>
		<td class="altbg2"><input id="userid" name="username" size="25" maxlength="25" type="text" onblur="validate()"> 
		<span id="usermsg"></span>
		</tr>
	
		<tr>
			<td class="altbg1">密碼:</td>
			<td class="altbg2"><input name="pwd" size="25" type="password"></td>
		</tr><tr>
			<td class="altbg1">密碼確認:</td>
			<td class="altbg2"><input name="pwd2" size="25" type="password"></td>
		</tr>
		
		<tr>
			<td class="altbg1">電話</td>
			<td class="altbg2"><input name="phone" type="text" id="phone" size="25"></td>
		</tr>
		
		</tbody></table>
		<br>
		<center><input value="提 交" type="submit">
		<input type="reset" value="重製"></center>
	</form>

<%
	if(action != null){
		out.print("<center>Congraution Registered OK</center>"); 
	}
%>
</body>
</html>