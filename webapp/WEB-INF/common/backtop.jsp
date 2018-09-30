<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style type="text/css">
#d-top {
	right: 10px; bottom: 120px; float: right; position: fixed; z-index: 10;
}
#d-top img {
	width: 42px; filter: alpha(opcity=30); opacity: 0.3; -moz-opacity: 0.3; -khtml-opacity: 0.3;
}
#d-top a:hover img {
	filter: alpha(opcity=100); opacity: 1; -moz-opacity: 1; -khtml-opacity: 1;
}
</style>
<div id="d-top" hidden>
<a id="d-top-a" href="#" title="回到顶部">
<img src="${ctx}/static/cms/images/icon/top.png" alt="TOP" /></a>
</div>
<script type="text/javascript">
    $(function(){
        window.onscroll=function(){
            if($(window).scrollTop()>100){
            	$("#d-top").fadeIn(500);
            }else{
            	$("#d-top").fadeOut(500);
            }
        }
        $('#d-top-a').click(function(){
        	$('body,html').animate({scrollTop:0},500);
        	return false;
        });
    });
</script> 

    