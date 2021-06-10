<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="modal fade" id="myModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加商品</h4>
            </div>
            <div class="modal-body">
                <form id="categoryForm" action="" method="post">
                    <div class="form-group" hidden="hidden">
                        <label for="id">商品类别编号</label>
                        <input type="text" class="form-control" id="id" placeholder="id" name="cid">
                    </div>
                    <div class="form-group">
                        <label for="name">商品类别名称</label>
                        <input type="text" class="form-control" id="name" placeholder="name" name="cname" required="required">
                    </div>
                    <button type="submit" class="btn btn-success">提交</button>
                </form>
            </div>
        </div>
    </div>
</div>