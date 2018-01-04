<%@page import="com.cn.shopping.PasswordNotCorrectException"%>
<%@page import="com.cn.shopping.UserNotFoundException"%>
<%@page import="com.cn.shopping.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String action = request.getParameter("action");
lablEreeor:
if(action != null && action.equals("login")) {
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	User u = null;
	if( !username.trim().equals("") || !password.trim().equals("") ) {
		try{
			 u = User.vaildate(username, password);
		}catch(UserNotFoundException e){ 
			out.print("找不到此帳號");
			break lablEreeor;
		}catch(PasswordNotCorrectException e){
			out.print("密碼錯誤");
			break lablEreeor;
		}
		session.setAttribute("user", u);
		response.sendRedirect("Index01.jsp");
	}
	out.println("帳號或密碼不能為空");
	//response.sendRedirect("login.jsp");
	//return;
	
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>小鑫商城</title>
<link rel="alternate icon" href="assets/i/favicon.png">
<link rel="stylesheet" href="assets/css/amazeui.min.css">
<link rel="stylesheet" href="assets/css/app.css">
    <style>
       .button {
                background-color: #4CAF50;
    			border: none;
    			color: white;
    			padding: 8px 12px;
    			text-align: center;
    			text-decoration: none;
    			display: inline-block;
    			font-size: 16px;
    			margin: 4px 2px;
    			cursor: pointer;
               }
               
               body{
               background:#FFF url(http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/03/81/3ed4501ef0fb41bb92a99ee2772ffef9.jpg) repeat -100px 0 fixed 
               }
    </style>
</head>
<body>

<a href="Index01.jsp" ><img src="images/index/index.jpg" width="250" height="100" ></a> 
	<div class="title">
        <div class="am-g am-g-fixed">
            <div class="am-u-sm-12">
                <center><h1 class="am-text-primary">會員登入</h1></center>
            </div>
        </div>
    </div>
    
    
  <div>
	<form action="login.jsp" method="post" >
	<input type="hidden" name="action" value="login"/>
		<table border="0" align="center">	

	    	<tr>
	    		<td>
	    			<div  class="am-input-group am-input-group-primary">
		    			<span class="am-input-group-label"><i class="am-icon-users"></i></span>
		    			 <input id="demo" type="text" name="username" class="am-form-field" placeholder="請輸入帳號"   />
		    		</div>
	    		</td>
	    	</tr>
	    	<tr> <td><br></td></tr>
	    	<tr>
	    		<td>
	    		      <div class="am-input-group am-input-group-primary">
			    		<span class="am-input-group-label"><i class="am-icon-unlock"></i></span>
			    		<input id="dema" type="password"  name="password" class="am-form-field" placeholder="請輸入密碼" /> 
		    		</div>			
	    		</td>
	    	</tr>
	    	<tr> <td><br></td></tr>
	    	<tr>
	    		<td>
	    			<input type="submit" value="登入" class="button" />
					<input type="reset" value="清除" class="button"/>
	    			<input type="button" class="button" value="註冊" onclick="window.location.href='http://localhost:8080/Shopping01/Register.jsp'">
	    		</td>
	    	</tr>
    	</table>
	</form>
</div>

</body>
</html>