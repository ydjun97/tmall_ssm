<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/26
  Time: 23:01
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>
<div style="width: 1024px; margin: 0 auto">
<a href="${contextPath}">
    <img id="simpleLogo" src="img/site/simpleLogo.png" class="simpleLogo" style="left: 257px; top: 77px;"/>
</a>

<form action="foresearch" method="post">
    <div class="simpleSearchDiv  pull-right">
        <input name="keyword" type="text" placeholder="平衡车 原汁机" />
        <button type="submit" class="searchButton">搜天猫</button>
        <div class="searchBelow">
            <c:forEach items="${cs}" var="c" varStatus="st">
                <c:if test="${st.count >=8  and st.count <= 11}">
                    <span>
                        <a href="forecategory?cid=${c.id}">${c.name}</a>
                        <c:if test="${st.count != 11}">
                            <span>|</span>
                        </c:if>
                    </span>
                </c:if>
            </c:forEach>
        </div>
    </div>
    <div style="clear: both"></div>
</form>
</div>