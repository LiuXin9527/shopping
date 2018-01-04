<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<%@ include file="_SessionCheck.jsp" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% List<Category> categories = Category.getCategories(); %>
<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");

if(action != null && action.trim().equals("complexsearch")) {
		String keyWord = request.getParameter("keyword");
		double lowNormalPrice = Double.parseDouble(request.getParameter("lownormalprice"));
		double hightNormalPrice = Double.parseDouble(request.getParameter("hightnormalprice"));
		int categoryId = Integer.parseInt(request.getParameter("categoryid"));
		int[] idArray = null ;
		if(categoryId == 0){
			idArray = null;
		}else{
			List<Integer> list = Category.findCategoriesOfSon(categoryId);  //找子節點
			idArray = new int[list.size()];
			for(int i=0;i<list.size();i++){
				idArray[i] = list.get(i);
			}
		}
		Timestamp startDate = null;
		String strStarDate = request.getParameter("startdate");
		if(strStarDate == null || strStarDate.trim().equals("")){
			
		}else{
			 startDate = Timestamp.valueOf(strStarDate+" 00:00:00");
		}
		Timestamp endDate = null;
		String strEndDate = request.getParameter("enddate");
		if(strEndDate == null || strEndDate.trim().equals("")){
			
		}else{
			 endDate = Timestamp.valueOf(strEndDate+" 00:00:00");
		}		
		List<Product> list = ProductMgr.getInstanct().findProducts(idArray,
				keyWord, lowNormalPrice, hightNormalPrice,  startDate, endDate, 1, 3);
	

%>
	<table align="center" border="1">
	<tr>
		<td>ID</td>
		<td>名稱</td>
		<td>描述</td>
		<td>普通價格</td>
		<td>日期</td>
		<td>categoryId</td>
		<td></td>
	</tr>
		<%
			for(Iterator<Product> it = list.iterator() ; it.hasNext();){
				Product p = it.next();
		%>
	<tr>
		<td><%=p.getId()%></td>
		<td><%=p.getName()%></td>
		<td><%=p.getDescr()%></td>
		<td><%=p.getNormalPrice() %></td>
		<td><%=p.getPdate() %></td>
		<td><%=p.getC().getName() %></td>
		<td>
			<a href="ProductDelete.jsp?id=<%=p.getId()%> " target="detail">刪除</a>
			&nbsp;&nbsp;
			<a href="ProductModify.jsp?id=<%=p.getId()%> " target="detail">修改</a>
		</td>
	</tr>
		<%
			} 
		%>
	
</table>

<%
	return;
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<script type="text/javascript">
	function checkdata(){
	 	with(document.forms["complex"]){
	 		if(lownormalprice.value == null || lownormalprice.value == ""){
	 			lownormalprice.value = -1;
	 		}
	 		if(hightnormalprice.value == null || hightnormalprice.value == ""){
	 			hightnormalprice.value = -1;
	 		}
	 	}
	}
	$(function(){
	    $('#datepicker').datepicker({
	   	 		dateFormat: 'yy-mm-dd'
	    });
	    $('#datepicker1').datepicker({
   	 		dateFormat: 'yy-mm-dd'
    });
	});	
</script>
</head>
<body>

	<center>完整搜索</center>
	<form action="ProductSearch.jsp" method="post" onsubmit="checkdata()" name="complex">
		<input type="hidden" name="action" value="complexsearch"/>
		<table>
			<tr>
				<td>category:</td>
				<td>
					<select name="categoryid">
						<option value="0">全部類別</option>
						<%
							for(Iterator<Category> it =categories.iterator();it.hasNext(); ){
								Category c = it.next();
								String preStr ="";
								for(int i=1; i<c.getGrade();i++){
									preStr +="--";
								}
							
						%>
						<option value="<%=c.getId()%>"><%=preStr + c.getName() %></option> 
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>關鍵字:</td>
				<td><input type="text"  name="keyword"/></td>
			</tr>
			<tr>
				<td>普通價格:</td>
				<td>
					從<input type="text"  name="lownormalprice"/>
					到<input type="text"  name="hightnormalprice"/>
				</td>
			</tr>
			<tr>
				<td>日期</td>
				<td>
					從<input type="text"  name="startdate" id="datepicker1"/>
					到<input type="text"  name="enddate" id="datepicker"/>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="搜索"/></td>
			</tr>
		</table>
	</form>

</body>
</html>