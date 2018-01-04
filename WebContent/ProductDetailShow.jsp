<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>


<%
	request.setCharacterEncoding("utf-8");
	String strId = request.getParameter("id");
	int id;
	System.out.print(strId);
	if(strId != null){
		id = Integer.parseInt(strId);
		Product p = ProductMgr.getInstanct().loadById(id);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>小鑫商城</title>
<link type="text/css" rel="stylesheet" href="//statics.591.com.tw/min/?f=common.css,public.css,jq-popbox.css" />
<link rel="stylesheet" type="text/css" href="//statics.591.com.tw/css/index/house-detailRent.css?20171030" />
<link rel="stylesheet" type="text/css" media="screen and (max-width: 1500px)" href="//statics.591.com.tw/css/index/house/small-detail.css?201710-31">
<link rel="stylesheet" type="text/css" media="print" href="//statics.591.com.tw/css/index/house/housePrint.css?v=20170821-1" />
<link rel="image_src" href="https://hp2.591.com.tw/house/active/2017/12/03/151227325054195600_94x68.jpg" />
<link href="//statics.591.com.tw/css/index/public/head.new.css?2016090203" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkbutton(name){
	if( name.name == "buy"){
		document.form.action="Confirm.jsp";
	}else{
		document.form.action="AddCart.jsp";
	}
}

</script>
</head>
<body class="RentSale" id="RentSale_R" id="newVersion" >

 <a href="Index01.jsp" ><img src="images/index/index.jpg" width="300" height="100" ></a> 
<div class="h1" align="center">
<a href="Index01.jsp">返回主頁</a>
             <h1> <span class="houseInfoTitle"><%=p.getName() %></span></h1>
            </div>
    
	<form action="" method="post" onsubmit="" name="form">
	<input type="hidden" name="id" value="<%=p.getId() %>"/>
		 <div class="detailInfo clearfix" >
                          <div class="price clearfix" a>
                                 <i><%=p.getNormalPrice() %><b>元</b> </i>
                                 <i><img src="admin/images/uploadproduct/<%=p.getId() %>.jpg" width="400" height="330" alt="商品" title="" style="border: none;"/></i>
                               </div>                       
                         <ul class="attr" style="border-color:#FF30FF;border:2px #ccc solid;padding:10px;" >
                            <li>價格&nbsp;:&nbsp;&nbsp;<%=p.getNormalPrice() %>元</li>
							<li>數量:<select name="productcount">	
							<%for( int i=1; i<=10; i++){  %>															
							<option value="<%=i%>"><%=i %></option>
								<% 
								}
								%>
							</select>
							</li>                 
                        </ul>
					 </div>
	<div class="detailBox clearfix"  >
		<div class="leftBox" >                             
	  	<div class="others"><span>商品說明</span><i></i></div>
		<div class="houseIntro" onselectstart="return false;" style="-moz-user-select:none;user-select:none;">
			<%=p.getDescr().replaceAll("\n","<br>") %>
		</div>
	</div>
</div>
				<br>	
					<input type="submit" onclick="checkbutton(buy)" name="buy" value="我要買"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" onclick="checkbutton(cart)" name="cart" value="加入購物車"/>
		<% 
			}
		%>
	</form>
	<hr size="1">
	<div align="center">
			Established since: 2017 9 17 <br> 所有著作權by劉Sir 
		<a href="karta8931798828@gmail.com"></a>2017
	</div>
</body>
</html>