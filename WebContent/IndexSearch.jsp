<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="//statics.591.com.tw/min/?f=common.css,page-limit.css,house/houseListNew.css,newCommunity/community-list.css" />
</head>
<body>
 <a href="Index01.jsp" ><img src="images/index/index.jpg" width="250" height="100" ></a> 
<%
	request.setCharacterEncoding("utf-8");
	String keyWord = request.getParameter("keyword");
	List<Product> list = ProductMgr.getInstanct().findIndexProducts(keyWord);
	for(int i=0; i<list.size(); i++){
			Product p = list.get(i);
%> 

<div class="shList  " >
    <ul class="shInfo"   >
        <li class="info">
       
            <div class="left" data-bind="5848175" data-img-length="6">
                <a href="ProductDetailShow.jsp?id=<%=p.getId()%>" class="imgbd" target="_blank" title=""   ><img src="admin/images/uploadproduct/<%=p.getId() %>.jpg" width="128" height="92" alt="" /></a>
                <!-- 更多圖片 -->
            </div>
            <div class="right">
                <p class="title"><a href="ProductDetailShow.jsp?id=<%=p.getId()%>" target="_blank" class="house_url" title=""><strong><%=p.getName() %></strong></a><em class="recomTag">已搜尋</em></p>
                <strong class=""><%=p.getNormalPrice()%>元</strong>
            </div>
        </li>
        <li class="price fc-org">
        	<p><span class="oldprice"><strong></strong></span></p>
        	
        </li>
    </ul>
</div>

 <%
	}
  %>

</body>
</html>