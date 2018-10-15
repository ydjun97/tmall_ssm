<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/26
  Time: 23:03
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>

<title>用户注册</title>

<script>
    $(function(){
        <c:if test="${!empty msg}">
            $("span.errorMessage").html("${msg}");
            $("div.registerErrorMessageDiv").css("visibility", "visible");
        </c:if>

        $("form.registerForm").submit(function(){
            if(0 == $.trim($("input#name").val()).length){
                $("span.errorMessage").html("用户名不能为空");
                $("div.registerErrorMessageDiv").css("visibility", "visible");
                return false;
            }
            if(0 == $.trim($("input#password").val()).length){
                $("span.errorMessage").html("用户密码不能为空");
                $("div.registerErrorMessageDiv").css("visibility", "visible");
                return false;
            }
            if(0 == $.trim($("input#repeatpassword").val()).length){
                $("span.errorMessage").html("确认密码不能为空");
                $("div.registerErrorMessageDiv").css("visibility", "visible");
                return false;
            }
            if($.trim($("input#repeatpassword").val()) != $.trim($("input#name").val())){
                $("span.errorMessage").html("密码和确认密码不一致");
                $("div.registerErrorMessageDiv").css("visibility", "visible");
                return false;
            }
            return true;
        });
    });
</script>

<form class="registerForm" action="foreregister" method="post">
<div class="registerDiv">
    <div class="registerErrorMessageDiv">
        <div class="alert alert-danger" role="alert">
            <%--<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
            <span class="errorMessage"></span>
        </div>
    </div>

    <table class="registerTable" align="center">
        <tr>
            <td class="registerTip registerTableLeftTD">设置会员名</td>
            <td></td>
        </tr>
        <tr>
            <td class="registerTableLeftTD">登录名</td>
            <td class="registerTableRightTD"><input name="name" type="text" id="name" placeholder="用户名一旦设置成功，不能更改" /></td>
        </tr>
        <tr>
            <td class="registerTip registerTableLeftTD">设置登陆密码</td>
            <td class="registerTableRightTD">登陆时验证，保护账号信息</td>
        </tr>
        <tr>
            <td class="registerTableLeftTD">登陆密码</td>
            <td class="registerTableRightTD"><input name="password" type="password" id="password" placeholder="设置您的登录密码" /></td>
        </tr>
        <tr>
            <td class="registerTableLeftTD">密码确认</td>
            <td class="registerTableRightTD"><input type="password" id="repeatpassword" placeholder="请再次输入您的密码" /></td>
        </tr>
        <tr>
            <td colspan="2" class="registerButtonTD">
                <button type="submit">提   交</button>
            </td>
        </tr>
    </table>
</div>
</form>