<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="Index01.jsp" ><img src="images/index/index.jpg" width="300" height="100" ></a>
<%
	//如果session有紀錄 就取出
	Cart cart = (Cart)session.getAttribute("cart");
	if(cart == null){
		out.print("沒有任何購物選項");
		return;
	}
	SalesOrder.setsingleCart(null);
%>
	<form action="Confirm.jsp" method="post" onsubmit="" name="form">
		<div align="center">
			<table border="1" >
				<tr>
					<td>商品ID</td>
					<td>商品名稱</td>
					<td>商品價格</td>
					<td>商品數量</td>
					<td>商品圖片</td>
					<td></td>
				</tr>
			
				<%
				List<CartItem> items = cart.getItems();
					for(int i=0; i<items.size(); i++){
						CartItem ci = items.get(i);
						%>
					<tr>
						<td><%=ci.getId() %></td>
						<td><%=ProductMgr.getInstanct().loadById(ci.getId()).getName() %></td>
						<td><%=ci.getPrice() %></td>
						<td><%=ci.getCount() %></td>
						<td><img src="admin/images/uploadproduct/<%=ci.getId() %>.jpg" width="92" height="80" alt="" /></td>
						<td><a href="DeleteCart.jsp?id=<%=ci.getId()%> ">刪除</a></td>
					</tr>
				<% 
					}
				%>
			</table>
				總共:<%=cart.totalPrice()%>元<br>
				<input type="submit" onclick="checkbutton(buy)" name="buy" value="購買"/>
		</div>
		
	</form>
</body>
</html>