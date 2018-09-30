<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link href="${ctx}/static/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/static/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/static/umeditor/umeditor.js"></script>
<script type="text/javascript" src="${ctx}/static/umeditor/lang/zh-cn/zh-cn.js"></script>
<!--style给定宽度可以影响编辑器的最终宽度-->
<div style="width:<%=request.getParameter("width")%>;margin:20px 0 0;">  
<textarea id="esp_umeditor" style="width:100%;height:300px;"><%=request.getParameter("content")%></textarea>  
</div>  
<script type="text/javascript">
var um = UM.getEditor('esp_umeditor');
um.setWidth("100%");
$(".edui-body-container").css("width", "100%");
    //按钮的操作
    function insertHtml() {
        var value = prompt('插入html代码', '');
        um.execCommand('insertHtml', value);
    }
    function isFocus(){
        alert(um.isFocus());
    }
    function doBlur(){
        um.blur();
    }
    function createEditor() {
        enableBtn();
        um = UM.getEditor('esp_umeditor');
    }
    function getAllHtml() {
        alert(UM.getEditor('esp_umeditor').getAllHtml());
    }
    function getContent() { 
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UM.getEditor('esp_umeditor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UM.getEditor('esp_umeditor').getPlainTxt());
        alert(arr.join('\n'));
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用umeditor')方法可以设置编辑器的内容");
        UM.getEditor('esp_umeditor').setContent('欢迎使用umeditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UM.getEditor('esp_umeditor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UM.getEditor('esp_umeditor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UM.getEditor('esp_umeditor').selection.getRange();
        range.select();
        var txt = UM.getEditor('esp_umeditor').selection.getText();
        alert(txt);
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UM.getEditor('esp_umeditor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UM.getEditor('esp_umeditor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UM.getEditor('esp_umeditor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UM.getEditor('esp_umeditor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UM.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UM.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UM.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UM.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }
    
    if('<%=request.getParameter("disabled")%>'!='null'){
    	setDisabled();
    }
</script>

