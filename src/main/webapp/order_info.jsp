<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>会员登录</title>
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet" href="css/style.css" type="text/css" />
<style>
body {
	margin-top: 20px;
	margin: 0 auto;
}

.carousel-inner .item img {
	width: 100%;
	height: 300px;
}
</style>
</head>

<body>
	<!-- 引入header.jsp -->
	<jsp:include page="/header.jsp"></jsp:include>
	
	<div class="container">
		<div class="row">
			<div style="margin: 0 auto; margin-top: 10px; width: 950px;">
				<strong>订单详情</strong>
				<table class="table table-bordered">
					<tbody>
						<tr class="warning">
							<th colspan="5">订单编号:${sessionScope.orders.oid}</th>
						</tr>
						<tr class="warning">
							<th>图片</th>
							<th>商品</th>
							<th>价格</th>
							<th>数量</th>
							<th>小计</th>
						</tr>
						<c:forEach items="${sessionScope.orders.list}" var="item">
							<tr class="active">
								<td width="60" width="40%">
									<input type="hidden" name="id" value="${item.itemid}">
									<img src="${item.product.pimage}" width="70" height="60"></td>
								<td width="30%"><a target="_blank">${item.product.pname}</a></td>
								<td width="20%">￥${item.product.shop_price}</td>
								<td width="10%">${item.count}</td>
								<td width="15%"><span class="subtotal">￥${item.subtotal}</span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div style="text-align: right; margin-right: 120px;">
				商品金额: <strong style="color: #ff6600;">￥${sessionScope.orders.total}元</strong>
			</div>

		</div>

		<div>
			<hr />
			<form class="form-horizontal" style="margin-top: 5px; margin-left: 150px;" id="orderForm" method="post" action="/orders?method=confirmOrders">
				<div class="form-group">
					<label for="address" class="col-sm-1 control-label">地址</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="address" name="address"
							placeholder="请输入收货地址" value="${sessionScope.user.address}">
					</div>
				</div>
				<div class="form-group">
					<label for="name" class="col-sm-1 control-label">姓名</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="name" name="name"
							placeholder="请输收货人姓名" value="${sessionScope.user.name}">
					</div>
				</div>
				<div class="form-group">
					<label for="telephone" class="col-sm-1 control-label">电话</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="telephone" name="telephone"
							placeholder="请输入联系方式" value="${sessionScope.user.telephone}">
					</div>
				</div>


			<hr />

			<div style="margin-top: 5px; margin-left: 150px;">
				<strong>选择银行：</strong>
				<p>
					<br />
					<input type="radio" name="pd_FrpId" value="ICBC-NET-B2C" checked="checked" />
					工商银行 <img src="./bank_img/icbc.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="pd_FrpId" value="BOC-NET-B2C" />
					中国银行 <img src="./bank_img/bc.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="pd_FrpId" value="ABC-NET-B2C" />
					农业银行 <img src="./bank_img/abc.bmp" align="middle" /> <br /> <br />
					<input type="radio" name="pd_FrpId" value="BOCO-NET-B2C" />
					交通银行 <img src="./bank_img/bcc.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="pd_FrpId" value="PINGANBANK-NET" />
					平安银行 <img src="./bank_img/pingan.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="pd_FrpId" value="CCB-NET-B2C" />
					建设银行 <img src="./bank_img/ccb.bmp" align="middle" /> <br /> <br />
					<input type="radio" name="pd_FrpId" value="CEB-NET-B2C" />
					光大银行 <img src="./bank_img/guangda.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="pd_FrpId" value="CMBCHINA-NET-B2C" />
					招商银行 <img src="./bank_img/cmb.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="pd_FrpId" value="alipay"  />
					支付宝 <img src="img/alipay.jpg" align="middle" width="154px" height="33px" />
				</p>
				<hr />
				<p style="text-align: right; margin-right: 100px;">
					<%--<input type="submit" class="btn btn-warning">--%>
					<a href="javascript:document.getElementById('orderForm').submit();">
						<img src="./images/finalbutton.gif" width="204" height="51" border="0" />
					</a>
					<font color="red">${msg}</font>
				</p>
				<hr />

			</div>

			</form>
		</div>

	</div>

	<!-- 引入footer.jsp -->
	<jsp:include page="/footer.jsp"></jsp:include>

</body>

</html>