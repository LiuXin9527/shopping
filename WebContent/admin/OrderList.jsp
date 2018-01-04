<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<%@ include file="_SessionCheck.jsp" %> 
<%!private static final int PAGE_SIZE = 20; %>
<%
	request.setCharacterEncoding("utf-8");
	String strPageNum = request.getParameter("pagenum");
	int PageNum = 1;
	if(strPageNum != null){
		PageNum = Integer.parseInt(strPageNum);
	}
	if(PageNum < 1)PageNum=1;
%>
<% 
	List<SalesOrder> orders = new ArrayList<SalesOrder>(); //products 是傳入參數 
	int pageCount = OrderMgr.getInstanct().getOrders(orders, PageNum,PAGE_SIZE); //執行結果 返回最後頁和 得到得到全部product對象
	if(PageNum > pageCount) {
		PageNum = pageCount ;
	}	
%>
<!-- 訂單修改狀態 -->
<% 
	
	String strId = request.getParameter("id");
	String strStayus = request.getParameter("status");
	boolean changeMgr; 
	int id =-1 ;
	if(strId != null && strStayus != null){
			id = Integer.parseInt(strId);
			String status = request.getParameter("status");

			changeMgr = OrderMgr.getInstanct().updateSalesOrder(id, status);
%>
			 <script type="text/javascript">
					document.location.href="OrderList.jsp";
				</script>
<%
	}
%>

<html>
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

<script type="text/javascript">
	function showProductInfo(descr) {
		if(descr != null){
			document.getElementById("productInfo").innerHTML="<center><font size=3 color=red>" + descr + "</font></center>";
		}
		
	}
</script>
</head>
<body>
	<%@ include file="Header.jsp" %>

<div class="am-cf admin-main">
	<%@ include file="Menu.jsp" %>


<div class=" admin-content">
<div class="daohang">
</div>


<!--訂單內容 -->
<%
	List<SalesItem> items = new ArrayList<SalesItem>();
	SalesOrder soDetail = new SalesOrder();
	 strId = request.getParameter("id");
	 id = -1;
	if( strId != null){
		System.out.println(strId);
		 id = Integer.parseInt(strId);
		 soDetail = OrderMgr.getInstanct().loadById(id);
		items = OrderMgr.getInstanct().getItem(soDetail);
%>
<script type="text/javascript">
$(document).ready(function () {
    $('#autoclickme a').click();
});
</script>
<div   id="autoclickme"><a  class="am-btn am-btn-primary" data-am-modal="{target: '#am-popup-showProductInfo'}" >詳細清單</a></div>
<div class="am-popup" id="am-popup-showProductInfo">
<div class="am-popup-inner" >
      <div class="am-popup-hd">
      	<h4 class="am-popup-title">買家:<%=soDetail.getUser().getUsername()%></h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
    </div>
    <div class="am-modal-bd">
      <table width="100%" class="am-table am-table-bordered am-table-radius am-table-striped" border="0">
	<tr>
		<td>商品名稱</td>
		<td>商品價格</td>
		<td>購買數量</td>
		<td>商品圖片</td>
	</tr>
<%
		for(Iterator<SalesItem> it = items.iterator() ; it.hasNext();){
			SalesItem si = it.next();
%>
	<tr>
		<td onmousemove="showProductInfo('<%=si.getProduct().getDescr()%>')"><%=si.getProduct().getName()%></td>  
		<td><%=si.getPrice() %></td>
		<td><%=si.getCount() %></td>
		<td><img src="images/uploadproduct/<%=si.getProduct().getId() %>.jpg" width="128" height="92" alt="" /></td>
	</tr>
<%
		} 
%>
	</table>
	<a href="OrderList.jsp?id=<%=id%>&status=1">審核通過</a> <a href="OrderList.jsp?id=<%=id%>&status=2">註銷</a>
	<div  id="productInfo"  >
</div>
  </div>
    
  </div>
</div>
<%
	}
%>


<div class="admin-biaogelist">
    <div class="listbiaoti am-cf">
      <ul class="am-icon-flag on">訂單列表</ul>
      
      <dl class="am-icon-home" style="float: right;"> 當前位置： 首頁 > <a href="#">訂單列表</a></dl>
 
    </div>
	
	<div class="am-btn-toolbars am-btn-toolbar am-kg am-cf">
</div>

    <form class="am-form am-g">
          <table width="100%" class="am-table am-table-bordered am-table-radius am-table-striped">
            <thead>
              <tr class="am-success">
                <th class="table-id">ID</th>
                <th class="table-title">名稱</th>
                <th class="table-type">地址</th>
                <th class="table-date am-hide-sm-only">日期</th>
				<th class="table-type">手機</th>   
				<th class="table-type">配貨方式</th>  
				<th class="table-type">訂單狀態</th> 		
				<th class="table-type">訂單內容</th>		          
                <th width="163px" class="table-set">操作</th>
              </tr>
            </thead>
            <tbody>
            
<%
		for(Iterator<SalesOrder> it = orders.iterator() ; it.hasNext();){
			SalesOrder so = it.next();
%>
              <tr>
                <td><%=so.getId()%></td>
                <td><a href="#"><%=so.getUser().getUsername()%></a></td>
                <td><%=so.getAddr()%></td>
                <td class="am-hide-sm-only"><%=so.getoDate() %></td>
                <td><%=so.getPhone() %></td>
                <td><% if(so.getDelivery() == 0){out.print("7-11取貨付款");} else if(so.getDelivery() == 1){out.print("郵寄寄送");}else{out.print("宅配/快遞");}%></td>
                <td><% if(so.getStatus() == 0){out.print("待審核");}else if(so.getStatus() == 1){out.print("已審核");}else{out.print("註銷");} %></td>
                <td><a  class="am-btn am-btn-primary" href="OrderList.jsp?id=<%=so.getId()%>">訂單明細</a></td>  
                <td><div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                    	<%-- <a class="am-btn am-btn-default am-btn-xs am-text-warning  am-round" href="ProductModify.jsp?id=<%=p.getId()%>"><span class="am-icon-pencil-square-o">修改</span></a>
                    	<a class="am-btn am-btn-default am-btn-xs am-text-danger am-round" href="ProductDelete.jsp?id=<%=p.getId()%>"><span class="am-icon-trash-o">刪除</span></a> --%>
                    	<a href="OrderList.jsp?id=<%=so.getId()%>&status=1">審核通過</a> 
                    	<a href="OrderList.jsp?id=<%=so.getId()%>&status=2">註銷</a>
                    </div>
                  </div></td>
              </tr>
<%
		} 
%>        
           </tbody>
          </table>
	
          <ul class="am-pagination am-fr">
                <li><a href="OrderList.jsp?pagenum=<%=PageNum-1%>">上一頁</a></li>
                <li class="am-disabled"><a href="#">第<%=PageNum %>頁</a></li>
                <li><a href="OrderList.jsp?pagenum=<%if(PageNum+1 > pageCount){out.print(pageCount);}else{out.print(PageNum+1);}%>">下一頁</a></li>
                <li><a href="OrderList.jsp?pagenum=<%=pageCount%>">最後一頁</a></li>
                <li>共<%=pageCount %>頁</li>
              </ul>
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