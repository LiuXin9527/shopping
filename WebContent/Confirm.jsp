<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<%
	//如果session有紀錄 就取出
	request.setCharacterEncoding("utf-8");
	String strId = request.getParameter("id");
	Cart cart = (Cart)session.getAttribute("cart");
	if(cart == null && strId == null){ // 第一次按加入購物車cart id都等於空 創建新session 如果第一次按購買 會傳ID值則不創建新session
		cart = new Cart();
		session.setAttribute("cart", cart);
	}
	
	User u = (User)session.getAttribute("user");
	if(u == null){
		out.print("尚未登入，無法購買");
		out.print("<br><a href=login.jsp >登入</a> &nbsp;&nbsp;&nbsp;<a href=Register.jsp >註冊</a>");
		return;
	}
%>
<%
	if(strId != null ){ //strId 不等於空代表有傳值 則執行 並不會add到session裡 是一個單獨純在
		int productCount = Integer.parseInt(request.getParameter("productcount"));
		out.print("單一購買");
		int id = Integer.parseInt(strId);
		Product p = ProductMgr.getInstanct().loadById(id);
		CartItem ci = new CartItem();
		ci.setId(id);
		ci.setPrice(p.getNormalPrice());
		ci.setCount(productCount);
		cart = new Cart();
		cart.add(ci);
		SalesOrder.setsingleCart(cart);
		
		
		//Buy.jspresponse.sendRedirect("Cart.jsp");
	}else{ //strId 等於空 代表沒傳ID值 則是session AddCart已經add好session 所以不需要加入
		out.print("購物車購買");
	}
		%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="Order.jsp" method="post" onsubmit="" name="form">
<input type="hidden" name="filter" value="filter"/>
		<div align="center">
			<table border="1" >
				<tr>
					<td>商品ID</td>
					<td>商品名稱</td>
					<td>商品價格</td>
					<td>商品數量</td>
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
						<td></td>
					</tr>
				<% 
					}
				%>
			</table>
				總共:<%=cart.totalPrice()%>元
				<p>送貨地址:<input type="text" name="addr" >
				<p>配送方式:
				<select name="delivery">
					<option value="0">7-11取貨付款</option>
					<option value="1">郵寄寄送</option>
					<option value="2">宅配/快遞 </option>
				</select>
				<p>買家電話:
				<select name="phonetitle">
					<option value="02">02</option>
					<option value="09">09</option>
				</select>
				<input type="text" name="phone" >
				<p><input type="submit" onclick="checkbutton(buy)" name="buy" value="確認購買"/>
		</div>
		
	</form>
</body>
</html>