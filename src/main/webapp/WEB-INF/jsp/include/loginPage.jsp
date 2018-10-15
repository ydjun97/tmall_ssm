<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/27
  Time: 2:49
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>

<title>登录</title>

<script>
    $(function(){
        <c:if test="${!empty msg}">
            $("span.errorMessage").html("${msg}");
            $("div.loginErrorMessageDiv").show();
        </c:if>

        $("form.loginForm").submit(function(){
            if(0 == $.trim($("#name").val()).length){
                $("span.errorMessage").html("账号名不能为空");
                $("div.loginErrorMessageDiv").show();
                return false;
            }
            if(0 == $.trim($("#password").val()).length){
                $("span.errorMessage").html("密码不能为空");
                $("div.loginErrorMessageDiv").show();
                return false;
            }
        });

        $("form.loginForm input").keyup(function(){
            $("div.loginErrorMessageDiv").hide();
        });

        var left = window.innerWidth / 2 + 162;
        $("div.loginSmallDiv").css("left",left);
    });
</script>

<div id="loginDiv" style="position: relative">
    <div class="simpleLogo">
        <a href="${contextPath}"><img src="img/site/simpleLogo.png"></a>
    </div>

    <img id="loginBackgroundImg" class="loginBackgroundImg" src="img/site/loginBackground.png" />

    <form class="loginForm" action="forelogin" method="post">
        <div id="loginSmallDiv" class="loginSmallDiv">
            <div class="loginErrorMessageDiv">
                <div class="alert alert-danger" role="alert">
                    <%--<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                    <span class="errorMessage"></span>
                </div>
            </div>

            <div class="login_acount_text">账户登录</div>

            <div class="loginInput">
                <span class="loginInputIcon"><span class="glyphicon glyphicon-user"></span></span>
                <input name="name" id="name" type="text" placeholder="手机/会员名/邮箱" />
            </div>

            <div class="loginInput">
                <span class="loginInputIcon"><span class="glyphicon glyphicon-lock"></span></span>
                <input name="password" id="password" type="text" placeholder="密码" />
            </div>

            <span class="text-danger">不要输入真实的天猫账号密码</span>
            <br/><br/>

            <div>
                <a class="notImplementLink" href="#nowhere" >
                    忘记账号密码
                </a>
                <span class="pull-right"><a href="register">
                    免费注册
                </a></span>
            </div>
            <div style="clear: both;"></div>

            <div style="margin-top:20px">
                <button class="btn btn-block redButton" type="submit">登录</button>
            </div>
        </div>
    </form>
</div>