<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/27
  Time: 22:05
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>

<title>模拟天猫官网 ${p.name}</title>

<div class="categoryPictureInProductPageDiv">
    <img class="categoryPictureInProductPage" src="img/category/${p.category.id}.jpg" />
</div>

<div class="productPageDiv">
    
    <%@include file="imgAndInfo.jsp"%>
    <%@include file="productReview.jsp"%>
    <%@include file="productDetail.jsp"%>
    
</div>