<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>会员管理</title>
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
                <th style="text-align:center">会员编号</th>
                <th style="text-align:center">会员名称</th>
                <th style="text-align:center">会员邮箱</th>
                <th style="text-align:center">会员电话</th>
                <th style="text-align:center">会员生日</th>
                <th style="text-align:center">会员地址</th>
                <th style="text-align:center">会员状态</th>
                <th style="text-align:center">操作</th>
            </tr>
            <c:forEach items="${vo.list}" var="user">
                <tr class="data" align="center">
                    <td class="datachoose"><input type="checkbox" class="single"></td>
                    <td class="id">${user.uid}</td>
                    <td>${user.username}</td>
                    <td>${user.email}</td>
                    <td>${user.telephone}</td>
                    <td>${user.birthday}</td>
                    <td>${user.address}</td>
                    <c:if test="${user.state==0}">
                        <td>未激活</td>
                    </c:if>
                    <c:if test="${user.state==1}">
                        <td>已激活</td>
                    </c:if>
                    <td>
                        <a href="javascript:void(0)" class="btn btn-primary" onclick="showUserOrder('${user.uid}')">查看订单</a>|
                        <a href="javascript:void(0)" class="btn btn-danger" onclick="deleteAll('${user.uid}')">删除</a>|
                    </td>
                </tr>
            </c:forEach>
            <tr align="center">
                <td colspan="9">
                    <input class="btn btn-success" type="button" value="首页"
                        onclick="firstPage('${pageContext.request.contextPath}/admin?method=findAll&code=user',$('#searchName').val())"/>&nbsp;&nbsp;
                    <input class="btn btn-success" type="button" id="pre" value="上一页"
                        onclick="prePage('${pageContext.request.contextPath}/admin?method=findAll&code=user',$('#searchName').val())"/>&nbsp;&nbsp;
                    <!-- 当前页 -->
                    <input type="text" id="pageNow" value="${vo.pageNow}" style="text-align:center"/>&nbsp;&nbsp;
                    <input class="btn btn-success" type="button" value="跳转"
                        onclick="skipPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=user',$('#searchName').val())"/>&nbsp;&nbsp;
                    <input class="btn btn-success" type="button" id="next" value="下一页"
                        onclick="nextPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=user',$('#searchName').val())"/>&nbsp;&nbsp;
                    <input class="btn btn-success" type="button" value="末页"
                        onclick="lastPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=user',$('#searchName').val())"/>&nbsp;&nbsp;
                </td>
		    </tr>
        </table>
    </div>
</div>


<%@include file="showOrder.jsp"%>

<script type="text/javascript">

	//模糊查询
	function selectByName(){
		var query = $("#searchName").val();
		window.location.href="${pageContext.request.contextPath}/admin?method=findAll&code=user&query="+query;
	}
	
	//显示顾客拥有的订单
	function showUserOrder(id){
	    var str = "";
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/admin?method=findOneById&code=user&id="+id,
            datatype:"json",
			success:function(mapList){
                $("#customOrders").html("");
                $("#orderOwner").text("");

                var array = JSON.parse(mapList);
                if(array.length==0){
                    alert("当前没有订单");
                }else{
                    for(var i=0;i<array.length;i++){
                        $("#orderOwner").text(array[i].username);

                        //此顾客拥有的所有订单
                        var oid = array[i].oid;
                        var addr = array[i].address;
                        var ordertime = new Date(array[i].ordertime);
                        //状态
                        var status = "";
                        switch(array[i].state){
                            case 0:status="未付款"; break;
                            case 1:status="已付款"; break;
                        }

                        str += "<tr><td>"+oid+"</td><td>"+addr+"</td><td>"+ordertime.toLocaleString()+"</td><td>"+status+"</td></tr>";
                    }

                    $("#customOrders").append(str);
                    $("#myOrderModal").modal();
                }

			}
		});
	}
	
	//删除
	function deleteAll(id){
		var c = window.confirm('确认删除信息?');  //是 true  否false
		if(c){
			//删除单条记录
			if(id!=0){
				window.location.href="${pageContext.request.contextPath}/admin?method=delete&code=user&id="+id;
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
				window.location.href="${pageContext.request.contextPath}/admin?method=delete&code=user&"+str;
			}
		}
	}


</script>
</body>
</html>
