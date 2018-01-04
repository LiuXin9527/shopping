<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="nav-navicon admin-main admin-sidebar">
    
    <div class="sideMenu am-icon-dashboard" style="color:#aeb2b7; margin: 10px 0 0 0;"> 歡迎系統管理員：小鑫</div>
    <div class="sideMenu">
	    <h3 class="am-icon-users"><em></em> <a href="UserList.jsp" >會員管理</a></h3>
	      <ul>
	        <li> <a href="UserList.jsp" >會員列表</a></li>
	        <li>添加會員 </li>
	      </ul>
	      
      <h3 class="am-icon-flag"><em></em> <a href="#">類別管理</a></h3>
      <ul>
        <li><a href="CategoryList.jsp">類別列表</a></li>
        <li><a  href="CategoryList.jsp" data-am-modal="{target: '#am-popup-add'}" >添加類別</a></li>
        <li><a href="CategoryListjs.jsp">類別樹狀圖</a></li>
        <li class="func" dataType='html' dataLink='msn.htm' iconImg='images/msn.gif'>不知</li>
      </ul>
      
      <h3 class="am-icon-flag"><em></em> <a href="#">商品管理</a></h3>
      <ul>
        <li><a href="ProductList.jsp">商品列表</a></li>
        <li><a href="ProductList.jsp">添加商品</a></li>
        <li><a href="ProductSearch.jsp">商品搜索</a></li>
        <li class="func" dataType='html' dataLink='msn.htm' iconImg='images/msn.gif'>添加新商品</li>
      </ul>
      
      <h3 class="am-icon-cart-plus"><em></em> <a href="#">訂單管理</a></h3>
      <ul>
        <li><a href="OrderList.jsp">訂單列表</a></li>
      </ul>
      
    </div>
    <!-- sideMenu End --> 
    
    <script type="text/javascript">
			jQuery(".sideMenu").slide({
				titCell:"h3", //鼠标触发对象
				targetCell:"ul", //与titCell一一对应，第n个titCell控制第n个targetCell的显示隐藏
				effect:"slideDown", //targetCell下拉效果
				delayTime:300 , //效果时间
				triggerTime:150, //鼠标延迟触发时间（默认150）
				defaultPlay:true,//默认是否执行效果（默认true）
				returnDefault:true //鼠标从.sideMen移走后返回默认状态（默认false）
				});
		</script> 
    
</div>

