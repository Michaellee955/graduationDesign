<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
<!--
.inputCss{
	width:80%;
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
<form id="mbiForm" class="form-horizontal" method="post" action="${ctx}/personal/saveOrUpdateMbi">
		<input type="hidden" id="mbi_id" name="id" value="">
		<input type="hidden" name="dataType" value="2">
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="code">代码：</label></div>
		         <div class="col-md-6">
			        <input type="text" id="mbi_code" maxlength="32" name="code" class="form-control input-sm inputCss" placeholder="代码(唯一)" value="">
			        <span style="color: red">*</span>
		        </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="name">名称：</label></div>
		         <div class="col-md-6">
			        <input type="text" id="mbi_name" maxlength="60" name="name" class="form-control input-sm inputCss" placeholder="名称" value="">
			        <span style="color: red">*</span>
			      </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="addr">地址：</label></div>
		        <div class="col-md-6">
		        <input type="text" id="mbi_addr" maxlength="100" name="addr" class="input-sm inputCss" placeholder="地址" value="">
		        </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="type">类型：</label></div>
		        <div class="col-md-6">
		        <select id="mbi_type" name="type" class="input-sm">
		        	<option value="1">资源提供</option>
		        	<option value="2">服务需求</option>
		        	<option value="3">两者都有</option>
		        </select>
		        </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="contactPerson">联系人：</label></div>
		        <div class="col-md-6">
		       	<input type="text" id="mbi_contactPerson" maxlength="20" name="contactPerson" class="form-control input-sm inputCss" placeholder="联系人" value="">
		       	<span style="color: red">*</span>
		       	</div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="contactNumber">联系电话：</label></div>
		        <div class="col-md-6">
		        <input type="text" id="mbi_contactNumber" maxlength="20" name="contactNumber" class="form-control input-sm inputCss" placeholder="联系电话" value="">
		        <span style="color: red">*</span>
		        </div>
			</div>
			<div class="row">
		        <div class="col-md-2"><label class="control-label labelCss" for="enterpriseQualification">资质：</label></div>
		        <div class="col-md-6">
		         <select id="mbi_enterpriseQualification" name="enterpriseQualification" class="input-sm">
		        	<option value="1">GE认证</option>
		        	<option value="2">IOS900</option>
		        	<option value="3">高新技术企业</option>
		        	<option value="4">一级设计企业</option>
		        	<option value="5">二级设计企业</option>
		        </select>
		        </div>
			</div>
			<div class="row">
		       <div class="col-md-2"> <label class="control-label labelCss" for="enterpriseProfile">简介：</label></div>
		       <div class="col-md-6">
		       	 <textarea id="mbi_enterpriseProfile" maxlength="1500"  rows="5" name="enterpriseProfile" class="form-control inputCss"  placeholder="简介" ></textarea>
		       	</div>
			</div>
			<div class="row">
					<div class="col-md-2"><label class="control-label labelCss" for="enterprisePhoto">照片：</label></div>
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
 </form>
 <div class="modal-footer">
		<div class="bootstrap-dialog-footer">
			<div class="bootstrap-dialog-footer-buttons">
				<button class="btn btn-warning" id="btnBack" onClick="back()">返回登录</button>
				<button class="btn btn-primary" id="btnSubmit" onClick="save();">提交</button>
			</div>
		</div>
<script type="text/javascript">
$(document).ready(function(){
	 $("label.btn-default").html('<span class="glyphicon glyphicon-folder-open"></span> Select');
	 $(".filestyle").change(function () {
         //显示X按钮
         $(this).parent().next().show();
     });
	 
		var id = '${mbi.id}' == '' ? genUUID()+addFlag : '${mbi.id}';
		$("#mbi_id").val(id);
		$("[id^='mbi_']").each(function(){
			$(this).attr("id",$(this).attr("id").replace('mbi_',id+"_"));
		});
		
		$("[id^='"+id+"']").attr("isAssist",'');
		assistAttr($("#"+id+"_code"), '代码',['required','unique:/personal/checkCode']);
		assistAttr($("#"+id+"_name"), '名称',['required']);
		assistAttr($("#"+id+"_contactPerson"), '联系人',['required']);
		assistAttr($("#"+id+"_contactNumber"), '联系电话',['required']);
		addMaxLen(id);
});
	function save(){
		var myform = $("#mbiForm").serializeArray();
		var keysArr = new Array();
		var data = {};
		$.each(myform, function(i, field){
			data[field.name] = field.value;
			keysArr.push(field.name);
		});
		var jsonArr= new Array();
		jsonArr.push(data);
	 	if(!dataCheck(jsonArr,keysArr,'80%')){
		   return;
	   	}
	 	$("#btnSubmit").attr("disabled",true);
	 	saveOrUpdateData();
	}
	
	//修改数据
	function saveOrUpdateData(){	
		$("#mbiForm").ajaxSubmit(function(result){
			var message = "注册失败！";
			if(true == result.success){
				message = "注册成功！等待管理员审核。";
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
	  
	  function back(){
		  location="${ctx}/";
	  }
</script>