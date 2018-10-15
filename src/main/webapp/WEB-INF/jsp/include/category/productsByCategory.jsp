<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/28
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>

<div class="categoryProducts">
    <c:forEach items="${c.products}" var="p" >
        <div class="productUnit" price="${p.promotePrice}">
            <div class="productUnitFrame">
                <a href="foreproduct?pid=${p.id}">
                    <img class="productImage" src="img/productSingle_middle/${p.firstProductImage.id}.jpg" />
                </a>
                <span class="productPrice">
                    ￥<fmt:formatNumber value="${p.promotePrice}" minFractionDigits="2" />
                </span>

                <a class="productLink" href="foreproduct?pid=${p.id}" >
                    ${fn:substring(p.name, 0, 50)}
                </a>
                <a class="tmallLink" href="foreproduct?pid=${p.id}">天猫专卖</a>

                <div class="show1 productInfo">
                    <span class="monthDeal">月成交<span class="productDealNumber">${p.saleCount}</span>笔</span>
                    <span class="productReview">评价<span class="productReviewNumber">${p.reviewCount}</span></span>
                    <span class="wangwang"><a class="wangwanglink" href="#nowhere">
                        <img src="img/site/wangwang.png">
                    </a></span>
                </div>
            </div>
        </div>
    </c:forEach>
    <div style="clear:both"></div>
</div>