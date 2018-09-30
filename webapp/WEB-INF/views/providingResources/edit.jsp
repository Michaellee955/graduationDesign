<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
<!--
.inputCss{
	width:50%;
	display:inline;
}
.labelCss{
	float:right;
}
-->
</style>
<div id='messageAlert' class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      	 <h4 class="modal-title">提示</h4>
      </div>
      <div class="modal-body">
        <p id="textP">...</p>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<form id="prForm" class="form-horizontal" method="post"  action="${ctx}/providingResources/saveOrUpdatePr">
		<input type="hidden" id="pr_id" name="id" value="${pr.id }">
		<input type="hidden" id="servicePhoto" name="servicePhoto" value="${pr.servicePhoto}">
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="resourcesCode">服务编号：</label></div>
		         <div class="col-md-6">
		        	<input type="text" id="pr_resourcesCode" maxlength="32" name="resourcesCode" class="form-control input-sm inputCss" placeholder="服务编号(唯一)" value="${pr.resourcesCode}">
		        	<span style="color: red">*</span>
		        </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="providingName">服务名称：</label></div>
		        <div class="col-md-6">
			        <input type="text" id="pr_providingName" maxlength="50" name="providingName" class="form-control input-sm inputCss" placeholder="服务名称" value="${pr.providingName}">
			        <span style="color: red">*</span>
		        </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="productId">服务产品：</label></div>
		         <div class="col-md-6">
		         	 <select id="serialId" name="serialId" class="input-sm" >
					 	<option value="">--Select--</option>
			        	<c:forEach items="${cvList}" var="cv">
			        		<option value="${cv.fkey}" <c:out value="${pr.serialId==cv.fkey?'selected':'' }"/>>${cv.fvalue}</option>
			        	</c:forEach>
			        </select>
			        <input type="text" id="pr_productName"  name="productName" onfocus="showdiv()" class="form-control input-sm inputCss" placeholder="服务产品" value="${pr.productName}">
			        <input type="hidden" value="${pr.productId}" id="productId" name="productId"/>
			        <span style="color: red">*</span>
			      </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="serviceType">服务类型：</label></div>
		        <div class="col-md-6">
		        	 <select id="pr_serviceType" name="serviceType" class="input-sm">
		        	<option value="1" <c:out value="${pr.serviceType==1?'selected':'' }"/>>设计</option>
		        	<option value="2" <c:out value="${pr.serviceType==2?'selected':'' }"/>>制造</option>
		        	<option value="3" <c:out value="${pr.serviceType==3?'selected':'' }"/>>测试</option>
		        	<option value="4" <c:out value="${pr.serviceType==4?'selected':'' }"/>>仿真</option>
		        	<option value="5" <c:out value="${pr.serviceType==5?'selected':'' }"/>>软件</option>
		        </select>
		        </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="serviceAbility">服务能力：</label></div>
		        <div class="col-md-6">
		        <input type="text" id="pr_serviceAbility" maxlength="10" name="serviceAbility" class="input-sm inputCss" placeholder="服务能力" value="${pr.serviceAbility}">
		        <span style="color: red">*</span>
		        </div>
		     </div>
		     <div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="abilityUint">服务能力单位：</label></div>
		        <div class="col-md-6">
		        <select id="pr_abilityUint" name="abilityUint" class="input-sm">
		        	<option value="4" <c:out value="${pr.abilityUint==4?'selected':'' }"/>>个</option>
		        </select>
		        </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="productQualify">产品认证：</label></div>
		        <div class="col-md-6">
		          <select id="pr_productQualify" name="productQualify" class="input-sm">
		          	<option value="1" <c:out value="${pr.productQualify==1?'selected':'' }"/>>GE认证</option>
		        	<option value="2" <c:out value="${pr.productQualify==2?'selected':'' }"/>>3C认证</option>
		        	<option value="3" <c:out value="${pr.productQualify==3?'selected':'' }"/>>rosh认证</option>
		        </select>
		        </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="servicePrive">产品价格：</label></div>
		        <div class="col-md-6">
		       	<input type="text" id="pr_servicePrive" maxlength="10" name="servicePrive" class="form-control input-sm inputCss" placeholder="产品价格" value="${pr.servicePrive}">
		       	<span style="color: red">*</span>
		       	</div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="pricingMode">计价方式：</label></div>
		        <div class="col-md-6">
		         <select id="pr_pricingMode" name="pricingMode" class="input-sm">
		        	<option value="1" <c:out value="${pr.pricingMode==1?'selected':'' }"/>>按数量计价</option>
		        	<option value="2" <c:out value="${pr.pricingMode==2?'selected':'' }"/>>按时间计价</option>
		        </select>
		       	<span style="color: red">*</span>
		       	</div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="serviceStarttime">服务开始时间：</label></div>
		        <div class="col-md-6">
		       	<input type="text" id="pr_serviceStarttime" name="serviceStarttime" class="form-control input-sm inputCss" placeholder="服务开始时间" value="${pr.serviceStarttime}">
		       	<span style="color: red">*</span>
		       	</div>
		      </div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="serviceEndtime">服务截止时间：</label></div>
		        <div class="col-md-6">
		       	<input type="text" id="pr_serviceEndtime"  name="serviceEndtime" class="form-control input-sm inputCss" placeholder="服务截止时间" value="${pr.serviceEndtime}">
		       	<span style="color: red">*</span>
		       	</div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="serviceArea">服务区域：</label></div>
		        <div class="col-md-6">
		       	<input type="text" id="pr_serviceArea" maxlength="50" name="serviceArea" class="form-control input-sm inputCss" placeholder="服务区域" value="${pr.serviceArea}">
		       	<span style="color: red">*</span>
		       	</div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="serviceProfile">服务简介：</label></div>
		        <div class="col-md-6">
		       	 <textarea id="pr_serviceProfile" maxlength="1500"  rows="5" name="serviceProfile" class="form-control inputCss"  placeholder="服务简介" >${pr.serviceProfile}</textarea>
		       	 <span style="color: red">*</span>
		       	 </div>
			</div>
			<div class="row">
					<div class="col-md-2"><label class="control-label labelCss" for="servicePhoto">服务照片：</label></div>
					<div class="col-md-4">
                   		<input type="file" name="files"  class="filestyle"> 
                   	</div>
                   	<div class="col-md-1" style="padding-left: 0px;line-height: 34px;display: none;">
                   		<div class="glyphicon glyphicon-remove" onclick="clearFile(this)" style="cursor: pointer;"></div>
                    </div>
	         </div>
	         <div class="row">
	         	<div class="col-md-2">&nbsp;</div>
	         	<div class="col-md-4">
                   		<input type="file" name="files"  class="filestyle"> 
                   	</div>
                   	<div class="col-md-1" style="padding-left: 0px;line-height: 34px;display: none;">
                   		<div class="glyphicon glyphicon-remove" onclick="clearFile(this)" style="cursor: pointer;"></div>
                    </div>
	         </div>
	         <div class="row">
	         	<div class="col-md-2">&nbsp;</div>
	         	<div class="col-md-4">
                   		<input type="file" name="files"  class="filestyle"> 
                   	</div>
                   	<div class="col-md-1" style="padding-left: 0px;line-height: 34px;display: none;">
                   		<div class="glyphicon glyphicon-remove" onclick="clearFile(this)" style="cursor: pointer;"></div>
                    </div>
	         </div>
	          <div class="row">
	         	<div class="col-md-2">&nbsp;&nbsp;</div>
	         	<div class="col-md-4">
	         		<div id="servicePhotoDiv" style="display: inline;"></div>
	         	</div>
	         </div>
	         
	      <div id='structTreeDiv' style='display:none;color:#666; background-color: white; border: 1px #ccc solid; position:absolute;  text-align: left;'>
	     	<ul id="structTree" class="ztree" style="border: 0px; height:300px; width: 250px; background-color: #f7f7f7; overflow:auto; "></ul>
			<div class="Form_button" style="margin-top: 5px;margin-bottom: 5px;text-align: center;">
				 <button type="button" class="btn btn-primary btn-sm" onclick="setCheckedVal();">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</div>
</form>
 <div class="modal-footer">
		<div class="bootstrap-dialog-footer">
			<div class="bootstrap-dialog-footer-buttons">
				<button class="btn btn-default" onClick="closeWindow();">关闭</button>&nbsp;&nbsp;
				<button class="btn btn-primary" id="btnSubmit" onClick="save();">提交</button>
			</div>
		</div>
<script type="text/javascript">
var setting = {
        data: {simpleData:{enable: true}},
        callback: {onClick: zTreeOnClick},
        check: {enable: true,chkStyle: "radio",radioType: "all"}};
var id = '';
var hasTree = false;
var servicePhoto = '${pr.servicePhoto}';
$(document).ready(function(){
	$("#currPos").html("资源提供<label class='icon-double-angle-right'/>服务注册");
	
	
	$("label.btn-default").html('<span class="glyphicon glyphicon-folder-open"></span> Select');
	 $(".filestyle").change(function () {
        //显示X按钮
        $(this).parent().next().show();
    });
		id = '${pr.id}' == '' ? genUUID()+addFlag : '${pr.id}';
		$("#pr_id").val(id);
		$("[id^='pr_']").each(function(){
			$(this).attr("id",$(this).attr("id").replace('pr_',id+"_"));
		});
		
		$("[id^='"+id+"']").attr("isAssist",'');
		assistAttr($("#"+id+"_resourcesCode"), '服务编号',['required','unique:/providingResources/checkCode']);
		assistAttr($("#"+id+"_providingName"), '服务名称',['required']);
		assistAttr($("#"+id+"_productName"), '服务产品',['required']);
		assistAttr($("#"+id+"_serviceAbility"), '服务能力',['required']);
		assistAttr($("#"+id+"_servicePrive"), '产品价格',['required']);
		assistAttr($("#"+id+"_serviceStarttime"), '服务开始时间',['required']);
		assistAttr($("#"+id+"_serviceEndtime"), '服务截止时间',['required']);
		assistAttr($("#"+id+"_serviceArea"), '服务区域',['required']);
		assistAttr($("#"+id+"_serviceProfile"), '服务简介',['required']);
		addMaxLen(id);
		
		
		$("#"+id+"_serviceStarttime,#"+id+"_serviceEndtime").datetimepicker({
				autoclose: 1,
				minView: 2,
				format: "yyyy-mm-dd",
				todayBtn:  1,
				language:'zh-CN'
			});
		
		
		
		$("#serialId").change(function(){
			$("#structTree").html('');
    		$("#structTreeDiv").hide();
    		
    		$("#"+id+"_productName,#productId").val('');
    		hasTree = false;
			
			var sid = $(this).val();
			if(!sid){
				$("#structTree").html('');
				return false;
			}
			generPsTree(sid);
		});
		
		if( '${pr.id}'){
			generPsTree('${pr.serialId}',function(){
				$("#structTreeDiv").hide();
			});
		}
		
		
		if(servicePhoto){
			var photoArr = servicePhoto.split(",");
			$(photoArr).each(function(i, val){
				$("#servicePhotoDiv").append("<a href='#' onclick=\"return  downloadAttach('"+val+"')\">照片"+(i+1)+"</a>&nbsp;&nbsp;");
			});
		}
});

function generPsTree(sid, callback){
	$.ajax({
        type: "POST",
        url: "${ctx}/productStruct/getPsListTree",
        data:{'sid':sid},
        dataType: "text",
        success: function(result) {
        	if(result){
            	zTreeObj = $.fn.zTree.init($("#structTree"), setting, eval("("+result+")"));
	    		hasTree = true;
            	showdiv();
            	var nodes = zTreeObj.getNodes();
	            var node = zTreeObj.getNodeByParam("id",$("#productId").val(),null);
	            if(nodes!=null && nodes.length>0){
	            	if(node != null){
	            		zTreeObj.checkNode(node, true, false);
	            	}
	            }
	            
	            if(callback){
	            	callback();
	            }
        	}
        },
        error: function(xhr, msg, e) { alert(msg); }
    });
}
	function save(){
		var myform = $("#prForm").serializeArray();
		var keysArr = new Array();
		var data = {};
		$.each(myform, function(i, field){
			data[field.name] = field.value;
			keysArr.push(field.name);
		});
		var jsonArr= new Array();
		jsonArr.push(data);
	 	if(!dataCheck(jsonArr,keysArr,'50%')){
		   return;
	   	}
	 	$("#btnSubmit").attr("disabled",true);
	 	saveOrUpdateData(data);
	}
	
	//修改数据
	function saveOrUpdateData(){	
		$("#prForm").ajaxSubmit(function(result){
			var message = "提交数据失败！";
			if(true == result.success){
				message = "提交数据成功！";
			}
			showMsg(message,2000);
		});
	}
	
	function showMsg(message,delay){
    	$("#messageAlert").modal();
    	$("#textP").text(message);
    	window.setTimeout(function() {
    		$('#messageAlert').modal('hide');
    		$("#btnSubmit").attr("disabled",false);
    	}, delay);
    }
	
	  function clearFile(btn) {
	        $(btn).parent().prev().find(".filestyle").filestyle('clear');
	        //隐藏X按钮
	        $(btn).parent().hide();
	    }
	  
      
	  function zTreeOnClick(event, treeId, treeNode) {
	    	var childNodes = zTreeObj.transformToArray(treeNode); 
	        if(treeNode.isParent){
	        	if(treeNode.open){
	        		zTreeObj.expandNode(childNodes[0], false);
	        	}else{
	        		zTreeObj.expandNode(childNodes[0], true);
	        	}
	        }
	   	 zTreeObj.checkNode(treeNode, true, false);
	    }
	  
	  function setCheckedVal(){
			var nodes = zTreeObj.getCheckedNodes();
			if(nodes!=null && nodes.length>0){
				$("#"+id+"_productName").val(nodes[0].name);
				$("#productId").val(nodes[0].id);
			}
			$("#structTreeDiv").hide();
		}
	  
	  function showdiv(){
		  if(hasTree){
			 	$("#structTreeDiv").show();
	    		$("#structTreeDiv").css({"left":$("#"+id+"_productName").offset().left,"top":$("#"+id+"_productName").offset().top+30});
		  }
	  }
</script>