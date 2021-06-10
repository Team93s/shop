//实现多选框全选效果
$(function(){
	//全选按钮  checkbox
	//1、为表头的checkbox 全选按钮绑定click事件
	$(".choose_all").on("click", function() {
		//2、每次点击全查看全选按钮的状态(checked true)
		var state = $(this).prop("checked");
		//3、将所有checkbox的状态改为全选按钮的状态
		$(".single").prop("checked", state);
	});

	//单个 checkbox按钮 
	$(".single").on("click", function() {
		if ($(".single:checked").length == $(".single").length) {
			$(".choose_all").prop("checked", true);
		} else {
			$(".choose_all").prop("checked", false);
		}
	});
});


// 实现分页效果
//首页
function firstPage(url,query){
	var pageNow = $("#pageNow").val();
	pageNow=1;
	window.location.href=url+"&pageNow="+pageNow+"&query="+query;
}
//末页
function lastPage(myPages,url,query){
	var pageNow = $("#pageNow").val();
	pageNow=myPages;
	window.location.href=url+"&pageNow="+pageNow+"&query="+query;
}
//上一页
function prePage(url,query){
	var pageNow = $("#pageNow").val();
	if(pageNow>1){
		pageNow = pageNow-1;
	}else if(pageNow==1){
		pageNow = 1;
		alert("已至首页");
	}
	window.location.href=url+"&pageNow="+pageNow+"&query="+query;
}
//下一页
function nextPage(myPages,url,query){
	var pageNow = $("#pageNow").val();
	if(pageNow < myPages){
		pageNow = pageNow-(-1);
	}else if(pageNow == myPages){
		pageNow = myPages;
		alert("已至末页");
	}
	window.location.href=url+"&pageNow="+pageNow+"&query="+query;
}
//跳转
function skipPage(myPages,url,query){
	var pageNow = $("#pageNow").val();
	if(pageNow>=1 && pageNow<=myPages){
		window.location.href=url+"&pageNow="+pageNow+"&query="+query;
	}else{
		alert("超出页数范围");
	}
}