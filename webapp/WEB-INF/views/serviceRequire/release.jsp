<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
<!--
.inputCss{
	width:50%;display:inline;
}
.labelCss{
	width: 20%;
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
<form id="prForm" class="form-horizontal">
	<div class="row">
		<div class="col-md-12 dictForm">
		<input type="hidden" id="sr_id" name="id" value="${sr.id }">
			<div class="form-group">
		        <label class="control-label labelCss" for="requireCode">需求编号：</label>
		        <input type="text" id="sr_requireCode" maxlength="32" name="requireCode" class="form-control input-sm inputCss" placeholder="需求编号(唯一)" value="${sr.requireCode}">
		        <span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireName">需求名称：</label>
		        <input type="text" id="sr_requireName" maxlength="50" name="requireName" class="form-control input-sm inputCss" placeholder="需求名称" value="${sr.requireName}">
		        <span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="productId">需求产品：</label>
		         <select id="serialId" name="serialId" class="input-sm" >
					 	<option value="">--Select--</option>
			        	<c:forEach items="${cvList}" var="cv">
			        		<option value="${cv.fkey}">${cv.fvalue}</option>
			        	</c:forEach>
			        </select>
			        <input type="text" id="sr_productName"  name="productName" onfocus="showdiv()" class="form-control input-sm inputCss" placeholder="需求产品" value="${sr.productName}">
			        <input type="hidden" value="${sr.productId}" id="productId" name="productId"/>
		        <span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="serviceType">需求类型：</label>
		         <select id="sr_serviceType" name="serviceType" class="input-sm">
		        	<option value="1">设计</option>
		        	<option value="2">制造</option>
		        	<option value="3">测试</option>
		        	<option value="4">仿真</option>
		        	<option value="5">软件</option>
		        </select>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireCount">需求数量：</label>
		        <input type="text" id="sr_requireCount" maxlength="10" name="requireCount" class="input-sm inputCss" placeholder="需求数量" value="${sr.requireCount}">
		        <span style="color: red">*</span>
		     </div>
		     <div class="form-group">
		        <label class="control-label labelCss" for="requireUint">需求单位：</label>
		         <select id="sr_requireUint" name="requireUint" class="input-sm">
		        	<option value="4">个</option>
		        </select>
		       	<span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireQualify">需求质量：</label>
		          <select id="sr_requireQualify" name="requireQualify" class="input-sm">
		        	<option value="1">GE认证</option>
		        	<option value="2">3C认证</option>
		        	<option value="3">rosh认证</option>
		        </select>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requirePrive">采购价格：</label>
		       	<input type="text" id="sr_requirePrive" maxlength="10" name="requirePrive" class="form-control input-sm inputCss" placeholder="采购价格" value="${sr.requirePrive}">
		       	<span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireStarttime">需求开始时间：</label>
		       	<input type="text" id="sr_requireStarttime" name="requireStarttime" class="form-control input-sm inputCss" placeholder="需求开始时间" value="${sr.requireStarttime}">
		       	<span style="color: red">*</span>
		      </div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireEndtime">需求截止时间：</label>
		       	<input type="text" id="sr_requireEndtime"  name="requireEndtime" class="form-control input-sm inputCss" placeholder="需求截止时间" value="${sr.requireEndtime}">
		       	<span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireArea">需求区域：</label>
		       	<input type="text" id="sr_requireArea" maxlength="50" name="requireArea" class="form-control input-sm inputCss" placeholder="需求区域" value="${sr.requireArea}">
		       	<span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireProfile">需求简介：</label>
		       	 <textarea id="sr_requireProfile" maxlength="1500"  rows="5" name="requireProfile" class="form-control inputCss"  placeholder="需求简介" >${sr.requireProfile}</textarea>
		       	 <span style="color: red">*</span>
			</div>
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
$(document).ready(function(){
	$("#currPos").html("服务需求<label class='icon-double-angle-right'/>需求发布");
	
		id = '${sr.id}' == '' ? genUUID()+addFlag : '${sr.id}';
		$("#sr_id").val(id);
		$("[id^='sr_']").each(function(){
			$(this).attr("id",$(this).attr("id").replace('sr_',id+"_"));
		});
		
		$("[id^='"+id+"']").attr("isAssist",'');
		assistAttr($("#"+id+"_requireCode"), '需求编号',['required','unique:/serviceRequire/checkCode']);
		assistAttr($("#"+id+"_requireName"), '需求名称',['required']);
		assistAttr($("#"+id+"_productName"), '需求产品',['required']);
		assistAttr($("#"+id+"_requireCount"), '需求数量',['required']);
		assistAttr($("#"+id+"_requirePrive"), '采购价格',['required']);
		assistAttr($("#"+id+"_requireStarttime"), '需求开始时间',['required']);
		assistAttr($("#"+id+"_requireEndtime"), '需求截止时间',['required']);
		assistAttr($("#"+id+"_requireArea"), '需求区域',['required']);
		assistAttr($("#"+id+"_requireProfile"), '需求简介',['required']);
		addMaxLen(id);
		
		
		$("#"+id+"_requireStarttime,#"+id+"_requireEndtime").datetimepicker({
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
			        	}
			        },
			        error: function(xhr, msg, e) { alert(msg); }
			    });
		});
});
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
	function saveOrUpdateData(data){	
		$.post("${ctx}/serviceRequire/saveOrUpdateSr",data,function(result){
			var message = "提交数据失败！";
			if(true == result.success){
				message = "提交数据成功！";
			}
			showMsg(message,2000);
		},'json');
	}
	
	function showMsg(message,delay){
    	$("#messageAlert").modal();
    	$("#textP").text(message);
    	window.setTimeout(function() {
    		$('#messageAlert').modal('hide');
    		$("#btnSubmit").attr("disabled",false);
    	}, delay);
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