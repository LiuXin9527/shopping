<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<%@ include file="_SessionCheck.jsp" %> 

<!doctype html>

<html class="no-js">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="这是一个 index 页面">
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="assets/css/admin.css">
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/app.js"></script>
<title>Insert title here</title>


</head>
<body>
<%@ include file="Header.jsp" %>

<div class="am-cf admin-main">
	<%@ include file="Menu.jsp" %>


<div class=" admin-content">
		<div class="daohang">
</div>



	
	
	
	


<div class="admin-biaogelist">
    <div class="listbiaoti am-cf">
      <ul class="am-icon-users">會員管理</ul>
      <dl class="am-icon-home" style="float: right;">當前位置： 首頁 > <a href="#">會員管理</a></dl>
      <dl>
        <button type="button" class="am-btn am-btn-danger am-round am-btn-xs am-icon-plus" >手動添加會員</button>
      </dl>
      <!--这里打开的是新页面-->
    </div>
    		
			
    <form class="am-form am-g">
          <table width="100%" class="am-table am-table-bordered am-table-radius am-table-striped">
            <thead>
              <tr class="am-success">
                <th class="table-id">ID</th>
                <th class="table-title">會員名稱</th>
                <th class="table-author am-hide-sm-only">手機</th>
                <th class="table-author am-hide-sm-only">註冊日期</th>
                 <th width="130px" class="table-set">操作</th>
              </tr>
            </thead>
            <tbody>
            <%
			List<User> user = User.getUsers();
			for(Iterator<User> it = user.iterator() ; it.hasNext();){
				User u = it.next();
			%>
              <tr>
                <td><%=u.getId() %></td>
                <td><%=u.getUsername() %></td>
                <td><%=u.getPhone() %></td>
                 <td class="am-hide-sm-only"><%=u.getRdate() %></td>
                <td>
                	<div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                      <div class="am-btn am-btn-default am-btn-xs am-text-danger am-round">
                      	<a href="UserDelete.jsp?id=<%=u.getId()%> " target="detail"><span class="am-icon-trash-o" >刪除</span></a>
                      </div> 

                    </div>
                  </div>
                </td>
              </tr>
              <%
				}
              %>
              
            </tbody>
          </table>
        
      
          <hr />
          <p>注：.....</p>
        </form>
 

 <div class="foods">
  <ul>
  <li>
所有著作權by劉承鑫		
</li>
  </ul>
  <dl>
    <a href="" title="返回头部" class="am-icon-btn am-icon-arrow-up"></a>
  </dl>
</div>
</div>
</div>
</div>


<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/polyfill/rem.min.js"></script>
<script src="assets/js/polyfill/respond.min.js"></script>
<script src="assets/js/amazeui.legacy.js"></script>
<![endif]--> 

<!--[if (gte IE 9)|!(IE)]><!--> 
<script src="assets/js/amazeui.min.js"></script>
<!--<![endif]-->
</body>
</html>