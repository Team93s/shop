<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品类别管理</title>
    <link href="${pageContext.request.contextPath}/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/admin/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/admin/js/jquery-1.11.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/index.js"></script>
</head>
<body>
<%@include file="../nav.jsp"%>

<div class="container">
        <div class="row">
            <div class="col-md-6 col-lg-6">
                <div class="input-group">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" onclick="selectByLikeName()">查找</button>
                    </span>
                    <input type="text" class="form-control" placeholder="Search by name" id="searchName" value="${query}">
                </div>
            </div>
            <div class="col-md-4 col-lg-4">
                <input class="btn btn-primary" type="button" value="增加商品类别" onclick="addCategory()">
                <input class="btn btn-danger" type="button" value="删除所有" onclick="deleteAll()">
            </div>
        </div>
        <div class="row">
            <table class="table table-bordered">
                <tr align="center">
                    <th style="text-align:center"><input type="checkbox" class="choose_all"></th>
                    <th style="text-align:center">商品类别编号</th>
                    <th style="text-align:center">商品类别名称</th>
                    <th style="text-align:center">操作</th>
                </tr>
                <c:forEach items="${vo.list}" var="c">
                    <tr class="data" align="center">
                        <td class="datachoose"><input type="checkbox" class="single"></td>
                        <td class="id">${c.cid}</td>
                        <td>${c.cname}</td>
                        <td>
                            <a href="javascript:void(0)" class="btn btn-primary" onclick="updateCategory('${c.cid}')">修改</a>|
                            <a href="${pageContext.request.contextPath}/admin?method=delete&code=category&id=${c.cid}" class="btn btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>

                <%-- 分页 --%>
                <tr align="center">
                    <td colspan="4">
                        <input class="btn btn-success" type="button" value="首页"
                               onclick="firstPage('${pageContext.request.contextPath}/admin?method=findAll&code=category',$('#searchName').val())"/>&nbsp;&nbsp;
                        <input class="btn btn-success" type="button" id="pre" value="上一页"
                               onclick="prePage('${pageContext.request.contextPath}/admin?method=findAll&code=category',$('#searchName').val())"/>&nbsp;&nbsp;
                        <!-- 当前页 -->
                        <input type="text" id="pageNow" value="${vo.pageNow}" style="text-align:center"/>&nbsp;&nbsp;
                        <input class="btn btn-success" type="button" value="跳转"
                               onclick="skipPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=category',$('#searchName').val())"/>&nbsp;&nbsp;
                        <input class="btn btn-success" type="button" id="next" value="下一页"
                               onclick="nextPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=category',$('#searchName').val())"/>&nbsp;&nbsp;
                        <input class="btn btn-success" type="button" value="末页"
                               onclick="lastPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=category',$('#searchName').val())"/>&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </div>


<%@include file="addModal.jsp"%>
<script type="text/javascript">

	/*添加商品*/
	function addCategory(){
		$("#id").val("");
		$("#name").val("");
		
		$("#myModalLabel").text("添加商品");
		$("#categoryForm").attr("action","${pageContext.request.contextPath}/admin?method=updateCategory&code=add");
		$("#myModal").modal();
	}

	
	/*修改商品*/
	function updateCategory(id){
		$.ajax({
			method:"get",
			dataType:"json",
			url:"${pageContext.request.contextPath}/admin?method=findOneById&code=category&id="+id,
			success:function(mapList){
			    for(var i=0;i<mapList.length;i++){
			        var map = mapList[i];
                    $("#id").val(map.cid);
                    $("#name").val(map.cname);
                }
				
				$("#myModalLabel").text("修改商品");
				$("#categoryForm").attr("action","${pageContext.request.contextPath}/admin?method=updateCategory&code=update");
				$("#myModal").modal();
			}
		});
	}
	
	/*通过名称模糊查询*/
	function selectByLikeName(){
		window.location.href="${pageContext.request.contextPath}/admin?method=findAll&code=category&query="+$("#searchName").val();
	}
	
	/*删除所有*/
	function deleteAll(){
        var str = "";
	    var flag = confirm("确定要删除该商品类别么？")
        if(flag){
            $(".single").each(function(){
                //判断当前的checkbox有没有被选中
                if($(this).prop("checked")){
                    var text = $(this).parents(".data").find(".id").text();
                    str = str+"id="+text+"&";
                }
            });
            str = str.substr(0,str.length-1);  //id=1&id=2&id=3
            window.location.href="${pageContext.request.contextPath}/admin?method=delete&code=category&"+str;
        }
	}
	
</script>    
</body>
</html>
