<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<form id="sysRoleForm" class="form-horizontal">
<input type="hidden" id="sysUserId" value="${id}"/>
<div class="row">
<label class="control-label">
<span id="cbAll" style="cursor: pointer;">全选</span>&nbsp;&nbsp;
<span id="cbAllNot" style="cursor: pointer;">全不选</span>&nbsp;&nbsp;
<span id="cbReverse" style="cursor: pointer;">反选</span>
</label>
  		<div id="roleDiv"  style="height:300px;overflow:auto;">
  			<table id="roleTab" border="0" style="width:100%">
  			</table>
  		</div>
</div>
</form>
<script>
$(function(){
	 $.ajax({
	        type: "POST",
	        data:{"userId":'${id}'},
	        url: "${ctx}/sysRole/getUserRoleList",
	        dataType: "json",
	        success: function(data) {
				if(data != null){
					var trStr = '<tr>';
					var len = data.length;
					$.each(data, function(i, item) {
						trStr += "<td width='25%'><input type='checkbox' name='roleId' value='"+item.id+"' "+(item.isChecked == 'true'?'checked':'')+" />"+item.roleName+"</td>";
						if(i%4 == 0 || i == len){
							$("#roleTab").prepend(trStr+"</tr>");
							trStr = "<tr>";
						}
			        });
				}	    		
	        },
	        error: function(xhr, msg, e) { alert(msg); }
	    });
	 
	 $("#cbAll").click(function(){  
			$("[name='roleId']").prop("checked",true);
	});  
	 $("#cbAllNot").click(function(){  
			$("[name='roleId']").prop("checked",false);
	});  
	 $("#cbReverse").click(function(){  
		 $("[name='roleId']").each(function () {  
             $(this).prop("checked", !$(this).prop("checked"));  
        });
	});  
});
</script>
