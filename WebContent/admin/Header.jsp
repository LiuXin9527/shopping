<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<header class="am-topbar admin-header">
  <div class="am-topbar-brand"><img src="assets/i/logo.png"></div>
  <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
    <ul class="am-nav am-nav-pills am-topbar-nav admin-header-list">
   <li class="am-dropdown tognzhi" data-am-dropdown>
  <button class="am-btn am-btn-primary am-dropdown-toggle am-btn-xs am-radius am-icon-bell-o" data-am-dropdown-toggle> 消息管理<span class="am-badge am-badge-danger am-round">1</span></button>
  <ul class="am-dropdown-content">
  		
    <li class="am-dropdown-header">所有消息</li>
   
    <li><a href="#">公告欄 <span class="am-badge am-badge-danger am-round">1</span></a></li>
    
  </ul>
</li>

 <li class="kuanjie">
 	<a href="UserList.jsp">會員管理</a>          
 	<a href="OrderList.jsp">訂單管理</a>   
 	<a href="ProductList.jsp">產品管理</a> 
 	<a href="#">個人中心</a> 
 	 <a href="#">系統設置</a>
 </li>

      <li class="am-hide-sm-only" style="float: right;"><a href="javascript:;" id="admin-fullscreen"><span class="am-icon-arrows-alt"></span> <span class="admin-fullText">开启全屏</span></a></li>
    </ul>
  </div>
</header>
