<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/28
  Time: 22:14
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>

<title>模仿天猫官网 -${c.name}</title>

<div class="category">
    <div class="categoryPageDiv">
        <img src="img/category/${c.id}.jpg" />
        <%@include file="sortBar.jsp"%>
        <%@include file="productsByCategory.jsp"%>
    </div>
</div>