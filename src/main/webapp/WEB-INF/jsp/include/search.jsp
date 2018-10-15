<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/25
  Time: 23:02
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>

<a href="${contextPath}">
    <img id="logo" src="img/site/logo.gif" class="logo" style="left: 207px; top: 28px;"/>
</a>

<form action="foresearch" method="post">
    <div class="searchDiv">
        <input name="keyword" type="text" placeholder="时尚男鞋 太阳眼镜" value="${param.keyword}" />
        <button type="submit" class="searchButton">搜索</button>
        <div class="searchBelow">
            <c:forEach items="${cs}" var="c" varStatus="st">
                <c:if test="${st.count > 4 and st.count <= 8}">
                    <span>
                        <a href="forecategory?cid=${c.id}">${c.name}</a>
                        <c:if test="${st.count != 8}">
                            <span>|</span>
                        </c:if>
                    </span>
                </c:if>
            </c:forEach>
        </div>
    </div>
</form>