<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>  

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:url value="/ahm/alarmhandle" var="alarmhandleurl" />

<style type="text/css">
#d-remind {
	right: 10px; top: 150px; float: right; position: fixed; z-index: 10;
	border-radius:5px;
/* background-color:#F5F5F5; */ 
/* 	border:1px solid #CCCCCC; */
	height:400px;
	width:110px;
}

#d-remind .lick {
 border-radius: 0.25em;
 background-color: #5BC0DE;
 padding:5px 5px 5px 10px;
 margin:5px 0px ;
 font-weight: bold;
 
}


#d-remind img {
	width: 42px; filter: alpha(opcity=30); opacity: 0.3; -moz-opacity: 0.3; -khtml-opacity: 0.3;
}
#d-remind a:hover img {
	filter: alpha(opcity=100); opacity: 1; -moz-opacity: 1; -khtml-opacity: 1;
}
</style>
<div id="d-remind" >
	<marquee id="remind_scroll" scrollamount="2" height="400" behavior="scroll"   direction="up"  onmouseover="this.stop();" onmouseout="this.start();">
<!--     <div class="label label-primary">B-5211<span class="badge" style="margin-left:10px;background-color: #d9534f;">50</span></div> -->
	</marquee>

</div>
<script type="text/javascript">
$(document).ready(function(){
	
	$(document).on('click','#toggle_remind',function(){
		if($(this).is('.glyphicon-eye-open')){
			$(this).removeClass('glyphicon-eye-open').addClass('glyphicon-eye-close');
			$('#d-remind').hide();
		}else{
            $(this).removeClass('glyphicon-eye-close').addClass('glyphicon-eye-open');
            $('#d-remind').show();
		}
	});
	
 <c:if  test="${sessionScope.custom.left_bar == true }" >	
	remindReload();
	
    window.setInterval(function(){
    	remindReload();                                        
    }, 1000*60*5 );
 </c:if>
    
    function remindReload(){
    	$('#remind_scroll').html('');
    	  $.get("${ctx}/ahm/alarmRemind/alarmCount", function(data){
    		 $.each(data, function(i, field){
    			 var tempurl='${alarmhandleurl}?tailNo='+field.aircraftNo;
    			 var inhtml = '<div class="lick" ><a href="javascript:{}" style="color:white" '
    			 +'onclick ="window.location.href=\''+tempurl+'\';"'
    			 +'>'+field.aircraftNo+'</a><span class="badge" style="margin-left:10px;background-color:#d9534f;">'+field.count+'</span></div>';
    			  $('#remind_scroll').append(inhtml);
    		  });
    	});  
 
    	
    }
	   

 });
</script> 

    