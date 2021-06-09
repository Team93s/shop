<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 登录 注册 购物车... -->
<div class="container-fluid">
	<div class="col-md-4">
		<img src="img/logo.png" />
	</div>
	<div class="col-md-5">
		<img src="img/header.png" />
	</div>
	<div class="col-md-3" style="padding-top:20px">

		<c:if test="${sessionScope.user==null}">
			<ol class="list-inline">
				<li><a href="login.jsp">登录</a></li>
				<li><a href="register.jsp">注册</a></li>
				<li><a href="cart.jsp">购物车</a></li>
				<li><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=3168850469&site=qq&menu=yes">联系客服</a></li>
			</ol>
		</c:if>


		<c:if test="${sessionScope.user!=null}">
			<ol class="list-inline">
				<li>欢迎,<a href="/user?method=logout">${sessionScope.user.username}</a></li>
				<li><a href="cart.jsp">购物车</a></li>
				<li><a href="/orders?method=viewMyOrders">我的订单</a></li>
				<li>
					<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=3168850469&site=qq&menu=yes">联系客服</a>
				</li>
			</ol>
		</c:if>

	</div>
</div>

<c:set var="path" scope="session" value="${pageContext.request.contextPath}"></c:set>

<!-- 导航条 -->
<div class="container-fluid">
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${path}/product?method=index">首页</a>
			</div>

			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav" id="categories"></ul>
				<form class="navbar-form navbar-right" role="search" action="${path}/product?method=findProducts&cid=${vo.query1}" method="post">
					<div class="form-group">
						<c:if test="${vo ne null}">
							<input type="text" class="form-control" placeholder="Search" id="pname" name="pname" value="${vo.query2}">
						</c:if>

						<c:if test="${vo eq null}">
							<input type="text" class="form-control" placeholder="Search" id="pname" name="pname" value="${pname}">
						</c:if>
					</div>
					<button type="submit" class="btn btn-default">Submit</button>
				</form>
			</div>
		</div>
	</nav>

	<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script>
		//查询所有商品分类，并显示在列表中
		$.ajax({
			type:"get",
			url:"${path}/category?method=findAllCategories",
			dataType:"json",
			success:function(list){   //list是json数据串
				for (var i in list) { //i 下标
					console.log(list[i].cid+" : "+list[i].cname)
					var $li = "<li><a href='${path}/product?method=findProducts&cid="+list[i].cid+"'>"+list[i].cname+"</a></li>";
					$("#categories").append($li);
				}
			}
		})
	</script>
</div>