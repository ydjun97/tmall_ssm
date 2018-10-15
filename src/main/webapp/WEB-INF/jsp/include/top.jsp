<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/25
  Time: 23:02
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>

<nav class="top">
    <div style="width: 1024px; margin: 0 auto;">
        <a href="${contextPath}">
            <span style="color:#C40000;margin:0px" class="glyphicon glyphicon-home redColor"></span>
            天猫首页
        </a>

        <span>喵，欢迎来天猫</span>

        <c:if test="${!empty user}">
            <a href="login">${user.name}</a>
            <a href="forelogout">退出</a>
        </c:if>

        <c:if test="${empty user}">
            <a href="login">请登录</a>
            <a href="register">免费注册</a>
        </c:if>

        <span class="pull-right">
            <a href="forebought">我的订单</a>
            <a href="forecart">
                <span style="color:#C40000;margin:0px" class="glyphicon glyphicon-shopping-cart redColor"></span>
                购物车<strong>${cartTotalItemNumber}</strong>件
            </a>
        </span>
    </div>
</nav>