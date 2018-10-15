<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/26
  Time: 19:33
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>

<div class="homepageCategoryProducts">
    <c:forEach  items="${cs}" var="c">
        <div class="eachHomepageCategoryProducts">
            <div class="left-mark"></div>
            <span class="categoryTitle">${c.name}</span>
            <br/>
            <c:forEach items="${c.products}" var="p" varStatus="st">
                <c:if test="${st.count <= 5}">
                    <div class="productItem">
                        <a href="foreproduct?pid=${p.id}">
                            <img src="img/productSingle_middle/${p.firstProductImage.id}.jpg" width="100px" />
                        </a>
                        <a class="productItemDescLink" href="foreproduct?pid=${p.id}">
                            <span class="productItemDesc">[热销]
                                ${fn:substring(p.name, 0, 20)}
                            </span>
                        </a>
                        <span class="productPrice">
                            <fmt:formatNumber value="${p.promotePrice}" minFractionDigits="2" />
                        </span>
                    </div>
                </c:if>
            </c:forEach>
            <div style="clear:both"></div>
        </div>
    </c:forEach>

    <img id="endpng" class="endpng" src="img/site/end.png">
</div>