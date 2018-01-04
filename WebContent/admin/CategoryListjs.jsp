<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.* , com.cn.shopping.* , java.util.*"%>
<%@ include file="_SessionCheck.jsp" %> 

<%
List<Category> Categories = Category.getCategories();
String Categoriestree= Category.getCategoriesTree(Categories);
%>
<%
String action = request.getParameter("action");
String strid = request.getParameter("id");
if(action != null && action.equals("add")) {
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	int id = Integer.parseInt(strid);
	
	if(id == 0){
		Category.addTopCategory(name, descr);
	}else{
		Category parent =  Category.loadById(id);
		Category child = new Category();
		child.setId(-1);
		child.setName(name);
		child.setDescr(descr);
		parent.addChild(child);
		
		//Category.addChildCategory(pid , name, descr);
	}
	
	out.print("resgistered ok");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>Insert title here</title>
	<script language="javascript" src="script/TV20.js"></script>
 	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="themes/icon.css">
    <link rel="stylesheet" type="text/css" href="css/demo.css">
    <script type="text/javascript" src="script/jquery.min.js"></script>
	<script type="text/javascript" src="script/jquery.easyui.min.js"></script>
    
</head>
<body >
<div style="margin:20px 0;"></div>
<div  class="easyui-panel" style="padding:5px" >
	<ul   id="tree1" class="easyui-tree" data-options="url:'tree_data1.json',method:'get',animate:true">
		<%=Categoriestree %> 
	</ul>
	<form name="form1" action="CategoryListjs.jsp" method="post">
	<input type="hidden" name="action" value="add"/>
		<input name="id" type="text" readonly /><br>
		<input name="name" type="text" /><br>
		<input name="descr" type="text" /><br>
		<input type="submit"  value="提交"/>
	</form>
</div>

<script type="text/javascript">
$(document).ready(function(){
    $("#tree1").tree({
      //lines:true,
      //url:"government-3.json",
    	  onClick:function(node){	  
    		  document.forms["form1"].id.value = node.id;
    		 //window.parent.frames["detail"].location.href="CategoryListjs.jsp";
    	        }
      });
    });

</script>
</body>
</html>

