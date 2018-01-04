<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<%@ include file="_SessionCheck.jsp" %> 

<%
List<Category> Categories = Category.getCategories();
String Categoriestree= Category.getCategoriesTree(Categories);
%>
<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");
String strpid = request.getParameter("pid"); //1
int pid =0;
if(strpid != null){
	pid = Integer.parseInt(strpid);
}

if(action != null && action.equals("add")) {
	String name = request.getParameter("name");
	String descr = "";
	
	if(pid == 0){
		Category.addTopCategory(name, descr);
	}else{
		Category parent =  Category.loadById(pid);
		Category child = new Category();
		child.setId(-1);
		child.setName(name);
		child.setDescr(descr);
		parent.addChild(child);
		
		//Category.addChildCategory(pid , name, descr);
	}
%>
	 <script type="text/javascript">
					document.location.href="CategoryList.jsp";
				</script>
<% 
}
%>

<%
String strid = request.getParameter("id");
strpid = request.getParameter("pid");
if(strid !=null && strpid !=null){
	int id = Integer.parseInt(strid);
	 pid = Integer.parseInt(strpid);
	String  deleteMsg = "" ;
	deleteMsg = Category.deleteCategory(id , pid);

		%>
		<script type="text/javascript">
			alert("<%=deleteMsg%>")
			document.location.href="CategoryList.jsp";
		</script>
		<%
	
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Amaze UI Admin index Examples</title>
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

</head>
<body>

<%@ include file="Header.jsp" %>

<div class="am-cf admin-main">
	<%@ include file="Menu.jsp" %>

<div class=" admin-content">
<div class="daohang">
</div>

<!-- 類別增加窗口 -->
<% 
if(strpid != null){
	pid = Integer.parseInt(strpid);

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
      <h4 class="am-popup-title">類別新增</h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
    </div>
	
	<div class="am-popup-bd">
      <form class="am-form tjlanmu" action="CategoryList.jsp" method="post">
		<input type="hidden" name="action" value="add"/>
		<input type="hidden" name="pid" value="<%=pid %>"/>

        <div class="am-form-group am-cf">
          <div class="zuo">類別名稱:</div>
          <div class="you">
            <input type="text" class="am-input-sm" id="doc-ipt-email-1" placeholder="" name="name">
          </div>
        </div>
        
         <div class="am-form-group am-cf">
          <div class="you">
            <p>
              <button type="submit" class="am-btn am-btn-success am-radius" value="add">新增</button>
            </p>
          </div>
        </div>
        
      </form>
    
    </div>

</div>
</div>	

	
<%
	 }
%>

<!-- 一級類別新增 -->
<div class="am-popup" id="am-popup-add">
	<div class="am-popup-inner" >
	    <div class="am-popup-hd">
      <h4 class="am-popup-title">類別新增</h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
    </div>
	
	<div class="am-popup-bd">
      <form class="am-form tjlanmu" action="CategoryList.jsp" method="post">
		<input type="hidden" name="action" value="add"/>

        <div class="am-form-group am-cf">
          <div class="zuo">類別名稱:</div>
          <div class="you">
            <input type="text" class="am-input-sm" id="doc-ipt-email-1" placeholder="" name="name">
          </div>
        </div>
        
         <div class="am-form-group am-cf">
          <div class="you">
            <p>
              <button type="submit" class="am-btn am-btn-success am-radius" value="add">新增</button>
            </p>
          </div>
        </div>
        
      </form>
    
    </div>

</div>
</div>

<div class="admin-biaogelist">
      <div class="listbiaoti am-cf">
        <ul class="am-icon-flag on">
          類別列表
        </ul>
        <dl class="am-icon-home" style="float: right;">
          當前位置：首頁 > <a href="#">類別管理</a>
        </dl>
        <dl>
          <button type="button" class="am-btn am-btn-danger am-round am-btn-xs am-icon-plus"  data-am-modal="{target: '#am-popup-add'}"> 添加一级類別</button>
        </dl>
        <!--data-am-modal="{target: '#my-popup'}" 弹出层 ID  弹出层 190行 开始  271行结束-->      
      </div>
      
      <form class="am-form am-g">
        <table width="100%" class="am-table am-table-bordered am-table-radius am-table-striped am-table-hover">
          <thead>
            <tr class="am-success">
              <th class="table-id am-text-center">ID</th>
              <th class="table-title">類別名稱</th>
              <th class="table-type">父類ID</th>
              <th class="table-author am-hide-sm-only">級別</th>
              <th class="table-date am-hide-sm-only">操作</th>
            </tr>
          </thead>
          <tbody>
          	<%
			 Categories = Category.getCategories();
			for(Iterator<Category> it = Categories.iterator() ; it.hasNext();){
				Category c = it.next();
				String prestr = "";
				for(int x=1;x<c.getGrade();x++){
					prestr+="├─";
				}
			%>
            <tr>
              <td class="am-text-center"><%=c.getId() %></td>
              <td><a href="#"><%=prestr+c.getName() %></a></td>
              <td><%=c.getPid() %></td>
              <td class="am-hide-sm-only"><%=c.getGrade() %></td>
              <td><div class="am-btn-toolbar">
                  <div class="am-btn-group am-btn-group-xs">
                  <a href="CategoryList.jsp?pid=<%=c.getId() %>" class="am-btn am-btn-default am-btn-xs am-text-success am-round am-icon-file" data-am-modal="{target: '#my-popups'}" title="添加子類">添加子類</a>

                    <div class="am-btn am-btn-default am-btn-xs am-text-danger am-round"  title="删除">
                    <span class="am-icon-trash-o"><a href="CategoryList.jsp?id=<%=c.getId() %>&pid=<%=c.getPid() %>">刪除</a></span>
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
        <p>
       備註：操作圖標含義
         <a class="am-text-success am-icon-file" title="添加子類別"> 添加子類別</a> 
         <a class="am-icon-trash-o am-text-danger" title="删除"> 删除類別</a>
     
        </p>
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