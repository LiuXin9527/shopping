<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<%@ include file="_SessionCheck.jsp" %> 

<% List<Category> productCategories = Category.getCategories(); %>

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
	List<Product> products = new ArrayList<Product>(); //products 是傳入參數 
	int pageCount = ProductMgr.getInstanct().getProducts(products, PageNum,PAGE_SIZE); //執行結果 返回最後頁和 得到得到全部product對象
	if(PageNum > pageCount) {
		PageNum = pageCount ;
	}	
%>


<% 
	String action = request.getParameter("action");
	boolean changeMgr = false; 
	int id =-1 ;
	if(action != null ){
		if(action != null && action.trim().equals("modify")  ){
			 id = Integer.parseInt(request.getParameter("id"));
			Product p = new Product();
			p.setId(id);
			p.setName(request.getParameter("name"));
			p.setDescr(request.getParameter("descr"));
			p.setNormalPrice(Double.parseDouble(request.getParameter("price")));
			p.setCategoryId(Integer.parseInt(request.getParameter("categoryid")));
			changeMgr = ProductMgr.getInstanct().updateProduct(p);
			System.out.println(request.getParameter("descr"));
			 if(changeMgr == true){
				 %>
				 <script type="text/javascript">
				 alert("修改成功")
					document.location.href="ProductList.jsp";
				</script>
				 <% 
			 }else{
				 out.print("修改失敗");
			 }
		}
		
	}

%>

<%
 action = request.getParameter("action");

if(action != null && action.equals("add")) {
	if(action != null && action.trim().equals("add")){
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		double normalPrice = Double.parseDouble(request.getParameter("price"));
		int categoryId = Integer.parseInt(request.getParameter("categoryid"));
		
		Product p = new Product();
		p.setId(-1);
		p.setName(name);
		p.setDescr(descr);
		p.setNormalPrice(normalPrice);
		p.setPdate(new Timestamp(System.currentTimeMillis()));
		p.setCategoryId(categoryId);
		
		ProductMgr.getInstanct().addProduct(p);
		
	}
%>
<script type="text/javascript">
		alert("新增成功")
		document.location.href="ProductList.jsp";
</script>
<%	
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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

<!-- 修改 -->
<script type="text/javascript">
	var arrleaf = new Array();
		function checkdata(){
			if(arrleaf[document.form.categoryid.selectedIndex] == "leaf"){
				alert("只能在子類節點下添加或修改");
				return false;
			}else{
				return true;
			}
			
		}
	
</script>
<!-- 新增 -->
<script type="text/javascript">
	var arrleaf = new Array();
		function checkdata(){
			if(arrleaf[document.form.categoryid.selectedIndex] == "leaf"){
				alert("非底層節點");
				return false;
			}else{
				return true;
			}
			
		}
	
</script>
<title>Insert title here</title>

</head>
<body>

<%@ include file="Header.jsp" %>

<div class="am-cf admin-main">
	<%@ include file="Menu.jsp" %>


<div class=" admin-content">
<div class="daohang">
</div>


<!-- 清單彈跳窗口 -->
<% 
	// strId = "";
String name= request.getParameter("name");
String strId= request.getParameter("id");
if(strId !=null && name.trim().equals("detail") ){
	 id = Integer.parseInt(strId);
	 if(id >= 0){
	Product p = ProductMgr.getInstanct().loadById(id);
	//System.out.println(id);
%>
<script type="text/javascript">
$(document).ready(function () {
    $('#showProductInfo a').click();
});
</script>
<div   id="showProductInfo"><a  class="am-btn am-btn-primary" data-am-modal="{target: '#doc-modal-showProductInfo'}" >詳細清單</a></div>
<div class="am-popup" tabindex="-1" id="doc-modal-showProductInfo">
  <div class="am-popup-inner" >
    <div class="am-popup-bd">
      <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
    </div>
    <div class="am-popup-bd">
      <table  border="1">
	<tr>
		<td>產品說明</td>
		<td>產品展示</td>
	</tr>
	<tr>
	<td>
	<%=p.getDescr() %>
	</td>
	<td>
	<img src=images/uploadproduct/<%=p.getId()%>.jpg width=400 height=330 >
	</td>
	</tr>
</table>
    </div>
  </div>
</div>
<%
	 }
}
%>

<!-- 圖片上傳彈跳窗口 -->
<script type="text/javascript">
function picUpload(id) {
		document.getElementById("form-picUpload").innerHTML="<input type=hidden value="+id+" name=id >";
}
</script>

<div class="am-popup" id="am-popup-picUpload">
	<div class="am-popup-inner" >
	    <div class="am-popup-hd">
      <h4 class="am-popup-title">圖片上傳</h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
    </div>
	
	<div class="am-popup-bd">
	
      <form  class="am-form tjlanmu" method="post" action="/Shopping01/UploadServlet" enctype="multipart/form-data" >
      <div id="form-picUpload"></div>
        <div class="am-form-group am-cf">
          <div class="zuo">產品圖片：</div>
          <div class="you" style="height: 45px;">
            <input type="file" id="doc-ipt-file-1" name="uploadFile">
            <p class="am-form-help">請選擇要上傳的圖片...</p>
          </div>
        </div>
        <div class="am-form-group am-cf">
          <div class="you">
            <p>
              <button type="submit" class="am-btn am-btn-success am-radius">上傳</button>
            </p>
          </div>
        </div>
      </form>
    
    </div>

</div>
</div>	

<!-- 修改彈跳窗口 -->
<% 
	// strId = "";
 name= request.getParameter("name");
 strId= request.getParameter("id");
if(strId !=null && name.trim().equals("modify")  ){
	 id = Integer.parseInt(strId);
	 if(id >= 0){
	Product p = ProductMgr.getInstanct().loadById(id);
	//System.out.println(id);
%>
<script type="text/javascript">
$(document).ready(function () {
    $('#autoclickme a').click();
});
</script>
<div   id="autoclickme"><a  class="am-btn am-btn-primary" data-am-modal="{target: '#am-popup-test'}" >詳細清單</a></div>

<div class="am-popup" id="am-popup-test">
<div class="am-popup-inner" >
   <div class="am-popup-hd">
      <h4 class="am-popup-title">修改產品</h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
    </div>
	
<div class="am-popup-bd">
    <form class="am-form tjlanmu" action="ProductList.jsp" method="post" onsubmit="return checkdata()" name="form">
	<input type="hidden" name="action" value="modify"/>
	<input type="hidden" name="id" value="<%=p.getId()%>"/>
	
        <div class="am-form-group am-cf">
          <div class="zuo">產品名稱：</div>
          <div class="you">
            <input type="text" class="am-input-sm" id="doc-ipt-email-1" placeholder="" name="name" value="<%=p.getName() %>">
          </div>
        </div>
        
         <div class="am-form-group am-cf">
          <div class="zuo">產品價格：</div>
          <div class="you">
            <input type="text" class="am-input-sm" id="doc-ipt-pwd-1" placeholder="" name="price" value="<%=p.getNormalPrice() %>">
          </div>
        </div>
        
          <div class="am-form-group am-cf">
          <div class="zuo">產品描述：</div>
          <div class="you">
            <textarea class="" rows="7" id="doc-ta-1" name="descr"><%=p.getDescr() %></textarea>
          </div>
        </div>
        
          <div class="am-form-group am-cf">
          <div class="zuo">類別ID:</div>
          <div class="you">
            <select name="categoryid" >
						<%
						int index = 0;
							for(Iterator<Category> it =productCategories.iterator();it.hasNext(); ){
								Category c = it.next();
								String preStr ="";
								for(int i=1; i<c.getGrade();i++){
									preStr +="--";
								}
						%>
						<script type="text/javascript">
						arrleaf[<%=index%>] = "<%=c.isLeaf() ? "leaf" : "noleaf"%>"
						</script>
						<option value="<%=c.getId()%>"<%=(p.getCategoryId() == c.getId())? "selected=selected" : ""%> ><%=preStr + c.getName() %></option> 
						<%
						index++;
							}
						%>
					</select>
          </div>
        </div>
        <div class="am-form-group am-cf">
          <div class="you">
            <p>
              <button type="submit" class="am-btn am-btn-success am-radius">修改</button>
            </p>
          </div>
        </div>
      </form>
    
    </div>
</div>
</div>
<%
	}
}
%>

<!-- 添加產品 -->
<div class="am-popup" id="am-popup-add">
<div class="am-popup-inner" >
   <div class="am-popup-hd">
      <h4 class="am-popup-title">添加產品</h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
    </div>
	
<div class="am-popup-bd">
    <form class="am-form tjlanmu" action="ProductList.jsp" method="post" onsubmit="return checkdata()" name="form">
	<input type="hidden" name="action" value="add"/>
	
        <div class="am-form-group am-cf">
          <div class="zuo">產品名稱：</div>
          <div class="you">
            <input type="text" class="am-input-sm" id="doc-ipt-email-1" placeholder="" name="name" value="">
          </div>
        </div>
        
         <div class="am-form-group am-cf">
          <div class="zuo">產品價格：</div>
          <div class="you">
            <input type="text" class="am-input-sm" id="doc-ipt-pwd-1" placeholder="" name="price" value="">
          </div>
        </div>
        
          <div class="am-form-group am-cf">
          <div class="zuo">產品描述：</div>
          <div class="you">
            <textarea class="" rows="2" id="doc-ta-1" name="descr"></textarea>
          </div>
        </div>
        
          <div class="am-form-group am-cf">
          <div class="zuo">類別ID:</div>
          <div class="you">
            <select name="categoryid">
						<%
						int index = 0;
							for(Iterator<Category> it =productCategories.iterator();it.hasNext(); ){
								Category c = it.next();
								String preStr ="";
								for(int i=1; i<c.getGrade();i++){
									preStr +="--";
								}
						%>
						<script type="text/javascript">
						arrleaf[<%=index%>] = "<%=c.isLeaf() ? "leaf" : "noleaf"%>"
						</script>
						<option value="<%=c.getId()%>"><%=preStr + c.getName() %></option> 
						<%
						index++;
							}
						%>
					</select>
          </div>
        </div>
        <div class="am-form-group am-cf">
          <div class="you">
            <p>
              <button type="submit" class="am-btn am-btn-success am-radius">新增</button>
            </p>
          </div>
        </div>
      </form>

    </div>
</div>
</div>
<!-- 主窗口顯示 -->
<div class="admin-biaogelist">
    <div class="listbiaoti am-cf">
      <ul class="am-icon-flag on">商品列表</ul>
      
      <dl class="am-icon-home" style="float: right;"> 當前位置： 首頁 > <a href="#">商品列表</a></dl>
      
      <dl>
      <dd>
        <button type="button" class="am-btn am-btn-danger am-round am-btn-xs am-icon-plus"  data-am-modal="{target: '#am-popup-add'}"> 添加產品</button>
        </dd>
      </dl> 
    </div>
	



    <form class="am-form am-g">
          <table width="100%" class="am-table am-table-bordered am-table-radius am-table-striped">
            <thead>
              <tr class="am-success">
                <th class="table-id">ID</th>
                <th class="table-title">名稱</th>
                <th class="table-type">價格</th>
                <th class="table-date am-hide-sm-only">日期</th>
				<th class="table-type">類別</th>   
				<th class="table-type">詳細清單</th>  
				<th class="table-type">圖片上傳</th> 				          
                <th width="163px" class="table-set">操作</th>
              </tr>
            </thead>
            <tbody>
            
<%
	for(Iterator<Product> it = products.iterator() ; it.hasNext();){
		Product p = it.next();
%>
              <tr>
 
                <td><%=p.getId()%></td>
                <td><a href="#"><%=p.getName()%></a></td>
                <td><%=p.getNormalPrice() %></td>
                <td class="am-hide-sm-only"><%=p.getPdate() %></td>
                <td><%=p.getC().getName() %></td>
                <td><a class="am-btn am-btn-primary"  href="ProductList.jsp?id=<%=p.getId()%>&name=detail">詳細清單</a></td>
                 <th class="table-type"><a class="am-btn am-btn-danger" data-am-modal="{target: '#am-popup-picUpload'}" onclick="picUpload('<%=p.getId()%>')" >圖片上傳</a></th> 
                <td><div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                    <a class="am-btn am-btn-default am-btn-xs am-text-warning  am-round"  href="ProductList.jsp?id=<%=p.getId()%>&name=modify" ><span class="am-icon-pencil-square-o">修改</span></a>
                    	<a class="am-btn am-btn-default am-btn-xs am-text-danger am-round" href="ProductDelete.jsp?id=<%=p.getId()%>"><span class="am-icon-trash-o">刪除</span></a>
                    </div>
                  </div></td>
              </tr>
<%
		} 
%>        
           </tbody>
          </table>

          
          <ul class="am-pagination am-fr">
                <li><a href="ProductList.jsp?pagenum=<%=PageNum-1%>">上一頁</a></li>
                <li class="am-disabled"><a href="#">第<%=PageNum %>頁</a></li>
                <li><a href="ProductList.jsp?pagenum=<%if(PageNum+1 > pageCount){out.print(pageCount);}else{out.print(PageNum+1);}%>">下一頁</a></li>
                <li><a href="ProductList.jsp?pagenum=<%=pageCount%>">最後一頁</a></li>
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