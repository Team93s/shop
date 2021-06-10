<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单管理</title>
    <link href="${pageContext.request.contextPath}/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/admin/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/admin/js/jquery-1.11.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/index.js"></script>
</head>
<body>
<%@include file="../nav.jsp"%>
<h1 style="color:red;text-align:center">${msg}</h1>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-lg-6">
            <div class="input-group">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" onclick="selectByName()">查找</button>
                    </span>
                <input type="text" class="form-control" placeholder="Search by name" id="searchName" value="${query}">
            </div>
        </div>
        <div class="col-md-4 col-lg-4">
            <input class="btn btn-danger" type="button" value="删除所有" onclick="deleteAll(0)" />
        </div>
    </div>
    <div class="row">
        <table class="table table-bordered">
            <tr>
                <th style="text-align:center"><input type="checkbox" class="choose_all"></th>
                <th style="text-align:center">订单编号</th>
                <th style="text-align:center">订单所属者</th>
                <th style="text-align:center">订单日期</th>
                <th style="text-align:center">订单状态</th>
                <th style="text-align:center">操作</th>
            </tr>
            <c:forEach items="${vo.list}" var="o">
                <tr class="data" align="center">
                    <td class="datachoose"><input type="checkbox" class="single"></td>
                    <td class="id">${o.oid}</td>
                    <td>${o.name}</td>
                    <td><fmt:formatDate value="${o.ordertime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <c:if test="${o.state==0}">
                        <c:set var="sta" value="未支付"></c:set>
                    </c:if>
                    <c:if test="${o.state==1}">
                        <c:set var="sta" value="已支付"></c:set>
                    </c:if>
                    <td>${sta}</td>
                    <td>
                        <a href="javascript:void(0)" class="btn btn-primary" onclick="showOrderDetail('${o.oid}')">查看订单详情</a>|
                        <a href="javascript:void(0)" class="btn btn-danger" onclick="deleteAll('${o.oid}')">删除</a>
                    </td>
                </tr>
            </c:forEach>
            <tr align="center">
			<td colspan="9">
				<input class="btn btn-success" type="button" value="首页" 
					onclick="firstPage('${pageContext.request.contextPath}/admin?method=findAll&code=order',$('#searchName').val())"/>&nbsp;&nbsp;
				<input class="btn btn-success" type="button" id="pre" value="上一页" 
					onclick="prePage('${pageContext.request.contextPath}/admin?method=findAll&code=order',$('#searchName').val())"/>&nbsp;&nbsp;
				<!-- 当前页 -->
				<input type="text" id="pageNow" value="${vo.pageNow}" style="text-align:center"/>&nbsp;&nbsp;
				<input class="btn btn-success" type="button" value="跳转" 
					onclick="skipPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=order',$('#searchName').val())"/>&nbsp;&nbsp;
				<input class="btn btn-success" type="button" id="next" value="下一页" 
					onclick="nextPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=order',$('#searchName').val())"/>&nbsp;&nbsp;
				<input class="btn btn-success" type="button" value="末页" 
					onclick="lastPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=order',$('#searchName').val())"/>&nbsp;&nbsp;
			</td>
			</tr>
        </table>
    </div>
</div>


<%@include file="showOrderDetails.jsp"%>
<script type="text/javascript">
	
	//模糊查询
	function selectByName(){
		var query = $("#searchName").val();
		window.location.href="${pageContext.request.contextPath}/admin?method=findAll&code=order&query="+query;
	}
	
	//显示当前订单的详情
	function showOrderDetail(id){
        var str = "";
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/admin?method=findOneById&code=order&id="+id,
			success:function(mapList){
                var array = JSON.parse(mapList);
                for(var i=0;i<array.length;i++){
                    var map = array[i];
                    $("#orderUser").text(map.name);
                    $("#orderAddress").text(map.address);
                    $("#orderTotal").text("共计：￥"+map.total+"元");
                    if(map.state==0){
                        $("#orderState").text("订单状态：未支付");
                    }else if(map.state==1){
                        $("#orderState").text("订单状态：已支付");
                    }
                    $("#orderDetails").html("");

                    //一行明细
                    str += "<tr><td>"+map.itemid+"</td><td>"+map.pid+"</td><td>"+map.pname+"</td><td><img width='64px' height='auto' src="+map.pimage+" /></td><td>"+map.subtotal+"</td><td>"+map.count+"</td></tr>";
                }
                $("#orderDetails").append(str);
				$("#myOrderModal").modal();
			}
		});
	}
	
	//删除
	function deleteAll(id){
		var c = window.confirm('确认删除此订单及其订单明细么?');  //是 true  否false
		if(c){
			//删除单条记录
			if(id!=0){
				window.location.href="${pageContext.request.contextPath}/admin?method=delete&code=order&id="+id;
			}else{
				var str = "";
				$(".single").each(function(){
					//判断当前的checkbox有没有被选中
					if($(this).prop("checked")){
						var text = $(this).parents(".data").find(".id").text();
						str = str+"id="+text+"&";
					}
				});
				str = str.substr(0,str.length-1);
				window.location.href="${pageContext.request.contextPath}/admin?method=delete&code=order&"+str;
			}
		}
	}

	
</script>
</body>
</html>
