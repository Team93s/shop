<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品管理</title>
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
                        <button class="btn btn-default" type="button" onclick="">查找</button>
                    </span>
                    <input type="text" class="form-control" placeholder="Search by name" id="searchName" value="">
                </div>
            </div>
            <div class="col-md-4 col-lg-4">
                <input class="btn btn-primary" type="button" value="增加商品" onclick="">
                <input class="btn btn-danger" type="button" value="批量下架" onclick="">
            </div>
        </div>
        <div class="row">
            <table class="table table-bordered">
                <tr align="center">
                    <th style="text-align:center"><input type="checkbox" class="choose_all"></th>
                    <th style="text-align:center">商品编号</th>
                    <th style="text-align:center">商品名称</th>
                    <th style="text-align:center">商品日期</th>
                    <th style="text-align:center">商品价格</th>
                    <th style="text-align:center">商品图片</th>
                    <th style="text-align:center">操作</th>
                </tr>
                <c:forEach items="${vo.list}" var="good">
                    <tr class="data" align="center">
                        <td class="datachoose"><input type="checkbox" class="single"></td>
                        <td class="id">${good.pid}</td>
                        <td>${good.pname}</td>
                        <td>${good.pdate}</td>
                        <td>${good.shop_price}</td>
                        <td>
                            <c:if test="${good.pimage !=null && good.pimage !=''}">
                                <img src="${good.pimage}" width="64px" height="auto"/>
                            </c:if>
                        </td>
                        <td>
                            <a href="javascript:void(0)" class="btn btn-primary" onclick="update('${good.pid}')">修改</a>|
                            <a href="${pageContext.request.contextPath}/admin?method=delete&code=product&id=${good.pid}" class="btn btn-danger">下架</a>
                        </td>
                    </tr>
                </c:forEach>

                <tr align="right"><td colspan="8"><input class="btn btn-warning" type="button" value="导出excel" onclick="window.location.href='${pageContext.request.contextPath}/admin?method=download'"></td></tr>

                <tr align="center">
                    <td colspan="8">
                        <input class="btn btn-success" type="button" value="首页"
                               onclick="firstPage('${pageContext.request.contextPath}/admin?method=findAll&code=product',$('#searchName').val())"/>&nbsp;&nbsp;
                        <input class="btn btn-success" type="button" id="pre" value="上一页"
                               onclick="prePage('${pageContext.request.contextPath}/admin?method=findAll&code=product',$('#searchName').val())"/>&nbsp;&nbsp;
                        <!-- 当前页 -->
                        <input type="text" id="pageNow" value="${vo.pageNow}" style="text-align:center"/>&nbsp;&nbsp;
                        <input class="btn btn-success" type="button" value="跳转"
                               onclick="skipPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=product',$('#searchName').val())"/>&nbsp;&nbsp;
                        <input class="btn btn-success" type="button" id="next" value="下一页"
                               onclick="nextPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=product',$('#searchName').val())"/>&nbsp;&nbsp;
                        <input class="btn btn-success" type="button" value="末页"
                               onclick="lastPage(${vo.myPages},'${pageContext.request.contextPath}/admin?method=findAll&code=product',$('#searchName').val())"/>&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </div>

<%-- BootStrap  模态层  --%>
<%@include file="addModal.jsp"%>

<script>

    //更新功能
    function update(pid) {
        //1.ajax查询商品信息
        $.ajax({
            type:"get",
            url:"${pageContext.request.contextPath}/admin?method=findOneById&pid="+pid,
            success:function (list) {   //List<Map<String,Object>>   json数据
                //ps集合的JS对象
                var ps = JSON.parse(list);
                //ps[下标] -> Map项
                //console.log(ps[0]);
                //Map.key
                //console.log(ps[0].pid);

                //渲染数据
                $("#pid").val(ps[0].pid);
                $("#pname").val(ps[0].pname);
                $("#pdesc").val(ps[0].pdesc);
                $("#market_price").val(ps[0].market_price);
                $("#shop_price").val(ps[0].shop_price);
                $("#pdate").val(ps[0].pdate);
                $("#pic").attr("src",ps[0].pimage);

                $("#category").html("");
                //2.ajax查询所有的商品类别信息
                $.ajax({
                    type:"get",
                    url:"${pageContext.request.contextPath}/admin?method=findAllCategory",
                    dataType:"json",
                    success:function (categories) {   //categories  List<Category>所有商品类别
                        for (var i in categories){
                            var c = categories[i];   //c 单个商品类别
                            console.log(c.cid);     //商品类别编号
                            console.log(c.cname);   //商品类别名称

                            //ps[0].cid 当前商品的类别  c.cid循环迭代商品的类别
                            if(ps[0].cid == c.cid){
                                $option = "<option value='"+c.cid+"' selected='selected'>"+c.cname+"</option>";
                            }else{
                                $option = "<option value='"+c.cid+"'>"+c.cname+"</option>";
                            }
                           $("#category").append($option);
                        }
                    }
                });


                //显示更新的模态层
                $("#myModalLabel").text("更新商品");
                $("#goodsform").attr("action","${pageContext.request.contextPath}/admin?method=update");
                $("#myModal").modal();
            }
        });
    }


</script>

</body>
</html>
