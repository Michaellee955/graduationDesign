<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<form id="updatepwd_form" class="form-horizontal">
    <div class="form-group">
        <label class="col-lg-3 col-md-3 control-label" for="currentPassword">当前密码：</label>
        <div class="col-lg-6 col-md-6" >
            <input type="password" id="currentPassword"  name="currentPassword" class="form-control input-sm" placeholder="旧密码" required><span style="color: red;" id="oldPswMsg"> </span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-lg-3 col-md-3 control-label" for="newPassword">新密码：</label>
        <div class="col-lg-6 col-md-6">
            <input type="password" id="newPassword" name="newPassword" class="form-control input-sm" placeholder="新密码" required><span style="color: red;" id="newPswMsg"> </span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-lg-3 col-md-3 control-label" for="newPassword_again">确认密码：</label>
        <div class="col-lg-6 col-md-6">
            <input type="password" id="newPassword_again" name="newPassword_again" class="form-control input-sm" placeholder="确认新密码" required>
            <span style="color: red;" id="reNewPswMsg"> </span>
        </div>
    </div>
    <div align="right">
    	<button type="button" id ='cancel' data-dismiss="modal" class="btn btn-default btn-sm" tabindex="1001">取消</button>
		<button type="button" id ='do_save' class="btn btn-primary btn-sm" tabindex="1000">提交</button>
	</div>
</form>
<script>
	$(function(){
		$("#do_save").click(function(){
			var noBlankMark = 0; 
			var oldPwd = $("#currentPassword").val();
			var newPwd = $("#newPassword").val();
			var reNewPwd = $("#newPassword_again").val();
			
			if(oldPwd=='') { 
				$("#oldPswMsg").text('输入旧密码'); 
			}
			else{
				$("#oldPswMsg").text('');
				 noBlankMark++;
			}
			if(newPwd=='') { 
				$("#newPswMsg").text('输入新密码'); 
			}else{
				$("#newPswMsg").text('');
				 noBlankMark++;
			}
			if(reNewPwd=='') { 
				$("#reNewPswMsg").text('确认新密码'); 
			}else{
				$("#reNewPswMsg").text(''); 
				 noBlankMark++;
			}
			
			if(noBlankMark==3){
				if((newPwd==reNewPwd)){
					$("#do_save").attr('disabled', true);
					var data = {};
					data['oldPassword'] = oldPwd;
					data['newPassword'] = newPwd;
			
					$.ajax({
						type: 'POST',
						url:'${ctx}/sysUser/checkConfirmOldPassword',
						dataType:'json',
						data:{'jsonStr' : JSON.stringify(data)},
						async : false,
						cache : false,
						error : function(textStatus, errorThrown) {},
						success : function(data, textStatus) {
							if (data.status == "success") { 
								$('#dialog-changePassWD').modal('hide');
								showMsg('密码修改成功', 2000);
							}else{ 
							$("#oldPswMsg").text('旧密码有误');}
							$("#do_save").attr('disabled', false);
						}
					});
				}else{
					$("#oldPswMsg").text('');
					$("#reNewPswMsg").text('两次输入的密码不一致');
					$("#newPswMsg").text(''); 
				}
			}
		});
		
	    function showMsg(message,delay){
	    	$("#messageAlert").modal();
	    	$("#textP").text(message);
	    	window.setTimeout(function() {
	    		$('#messageAlert').modal('hide');
	    	}, delay);
	    }	
	
	});
</script>