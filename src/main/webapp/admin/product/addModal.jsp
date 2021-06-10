<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="modal fade" id="myModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加商品</h4>
            </div>
            <div class="modal-body">
                <form id="goodsform" action="" method="post" enctype="multipart/form-data">
                    <div class="form-group" hidden="hidden">
                        <label for="pid">商品id</label>
                        <input type="text" class="form-control" id="pid" placeholder="pid" name="pid">
                    </div>
                    <div class="form-group">
                        <label for="pname">商品名称</label>
                        <input type="text" class="form-control" id="pname" placeholder="pname" name="pname" required="required">
                    </div>
                    <div class="form-group">
                        <label for="pdesc">商品描述</label>
                        <input type="text" class="form-control" id="pdesc" placeholder="pdesc" name="pdesc">
                    </div>
                    <div class="form-group">
                        <label for="market_price">商品参考价格</label>
                        <input type="text" class="form-control" id="market_price" placeholder="market_price" name="market_price" required="required">
                    </div>
                    <div class="form-group">
                        <label for="shop_price">商品实际价格</label>
                        <input type="text" class="form-control" id="shop_price" placeholder="shop_price" name="shop_price" required="required">
                    </div>
                    <div class="form-group">
                        <label for="pimage">商品图片</label>
                        <img id="pic" width="100" height="100" />
                        <input type="file" class="form-control" id="pimage" placeholder="pimage" name="file" onchange="showPreview(this)">
                    </div>
                    <div class="form-group">
                        <label for="pdate">商品生产日期</label>
                        <input type="date" class="form-control" id="pdate" placeholder="pdate" name="pdate">
                    </div>
                    <div class="form-group">
                        <label for="category">商品类别</label>
                        <select class="form-control" id="category" name="categoryId"></select>
                    </div>
                    <button type="submit" class="btn btn-success">提交</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
//将文件流以url形式读取，实现图片实时显示：
function showPreview(source){
	var file = source.files[0];
	if(window.FileReader){
		var fr = new FileReader();
			fr.onloadend = function(e){
			document.getElementById("pic").src=e.target.result;
		}
		fr.readAsDataURL(file);
	}
}
</script>
