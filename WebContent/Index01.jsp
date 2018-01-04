<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>

<% 
	List<Product> latestProducts = ProductMgr.getInstanct().getLatestProducts(10); 
	User u = (User)session.getAttribute("user");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="alternate icon" href="assets/i/favicon.png">
<link rel="stylesheet" href="assets/css/amazeui.min.css">
<link rel="stylesheet" href="assets/css/app.css">
<link type="text/css" rel="stylesheet" href="//statics.591.com.tw/min/?f=common.css,page-limit.css,house/houseListNew.css,newCommunity/community-list.css" />
<title>小鑫商城</title>
    <style type="text/css">  

    
   #header { }
		#siderbar1{
			float: left;
			width: 22%;

		}
		#siderbar2{
			float: right;
			width: 23%;
			background: #336699; 
		}
		#content{
			margin-left: 23%;
			margin-right: 24%;
		}
		#footer{
			clear: both;
		}
           .menu {
					width:740px;
					float: right;
					margin-top: 25px;
				  }

			.menu ul {
					padding:0; 
					margin:0;
					list-style-type: none;
					 }

			.menu ul li {
					float:left; 
					position:relative;
					z-index: 99999999999999999999999999999999999999999999;
						}

			.menu ul li a, .menu ul li a:visited {
					display:block;
					text-align:center;
					text-decoration:none;
					width:100px;
					height:30px;
					color:#333333;
					line-height:30px;
					font-size:14px;
					letter-spacing:1px;
					border-top-width: 1px;
					border-top-style: solid;
					border-top-color: #fff;
													}

			.menu ul li ul {
					display: none;
							}

			.menu ul li:hover a {
					color:#333333;
					text-decoration: underline;
								}

			.menu ul li:hover ul {
					display:block; 
					position:absolute;
								}

				.menu ul li:hover ul li a {
						display:block;
						height:35px;
						line-height:35px;
						color:#707070;
						font-size:12px;
						background-color: #f4f4f4;
						text-decoration: none;
										}

				.menu ul li:hover ul li a:hover {
						color:#333333;
						text-decoration: underline;
												}
           
    
    

    
           body{
                margin:0 auto; 
               background:#FFF url(http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/03/81/3ed4501ef0fb41bb92a99ee2772ffef9.jpg) repeat -100px 0 fixed; 

               }
           

    </style>
</head>

<div id="header">

    <a href="Index01.jsp" ><img src="images/index/index.jpg" width="250" height="100" ></a> 
<div class="menu" style="position:absolute;width:1000px;height:10px;top:30px;left:250px"> 
  <ul>
    <li><a class="hide" href="Index01.jsp">首頁</a></li>
    <li><a class="hide" href="Cart.jsp">我的購物車</a></li>
	</ul>
</div>
</div>    
     
  
<div style="position:absolute;width:160px;height:10px;top:10px;left:800px">
      <%
      	if(u == null){
      %>
     <a href="login.jsp" >登入</a> &nbsp;&nbsp;&nbsp;<a href="Register.jsp" >註冊</a> 
     <%
      	}else{
      		out.print("您好 " + u.getUsername());
     %>
      &nbsp;&nbsp;&nbsp;<a href="selfservice.jsp">個人中心</a>
     <input type="button"  style="color:white;background-color:red;width:100px;height:30px;font:bold;text-align:center;"  value="登出" onclick="myfunction()">
     &nbsp;&nbsp;&nbsp;
     <%
      	}
     %>
      </div>
      
      <div style="border-top:2px solid #000;width:1400px;height:1px;"> </div>
<div id="content">
	    <div class="rentprice" align="center">
			 <form action="IndexSearch.jsp" method="post" onsubmit="" name="form">
			  <input type="hidden" name="id" value="search"/>
			  <input type="text" name="keyword">
			  <input type="submit" name="search" value="找商品">
	      </form>    
    </div>
   					<center>最新商品</center> 
      <table border='1' width="220" style="word-break: break-all" align="center" >
      <tr>
      <%
	 for(int i=0; i<latestProducts.size(); i++){
		 Product p = latestProducts.get(i);
	 %>
			<!--鞋01  -->
			<td><a href="ProductDetailShow.jsp?id=<%=p.getId()%>" ><img src="admin/images/uploadproduct/<%=p.getId() %>.jpg" width="130" height="100" class="am-radius">
					<br><%=p.getName() %> <br>價格:$ <%=p.getNormalPrice() %>
					</a>
					</td>
		
		<%if((i+1)%5 == 0){out.print("</tr><tr>");}%>
	 <% 
	 }
	 
	 %>
	 </tr>
	 	</table>
</div>     
   
  <div  id="siderbar1" style="position:absolute;width:200px;height:200px;top:130px;left:0px" >
     <table><fieldset>    
     <legend><input type="button" style="color:brown;background-color:#FFA042;font-weight:bold;width:150px;height:40px;" disabled="disabled"   value="商品類別 " ></legend>  	
     </fieldset></table>
<div class="sh-title">縮小搜尋範圍</div>
    <div class="sh-list sh-info">
	    <dl class="rentprice">
		    <dd class="long">
			      <form action="IndexSearch.jsp" method="post" onsubmit="" name="form">
			  <input type="hidden" name="id" value="search"/>
			  <input type="text" name="keyword">
			  <input type="submit" name="search" value="關鍵字搜尋">
	      </form>
		    </dd>
	    </dl>
    </div>
  </div>

  
  <div id="siderbar2"> 
  </div>

    
    <script type="text/javascript">
    function myfunction()
    {
    	var r=confirm("確定要登出？");
    	if(r==true)
    		{
    		window.location.href='http://localhost:8080/Shopping01/loginOut.jsp';
    		}
    	
    }
    
    </script>

</body>
    <hr size="1" >
<div id="footer" class="foot_txt"  align=center>
		Established since: 2017 9 17 <br> 所有著作權by劉Sir 
		<a href="karta8931798828@gmail.com"></a>2017
</div>
</html>