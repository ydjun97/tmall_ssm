<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2018/8/20
  Time: 0:43
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    $(function(){
        $("nav ul.pagination li.disabled a").click(function(){
            return false;
        });
    });
</script>

<nav>
    <ul class="pagination">
        <li <c:if test="${!page.hasPrevious}">class="disabled"</c:if> >
            <a href="?start=0${page.param}" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
        <li <c:if test="${!page.hasPrevious}">class="disabled"</c:if> >
            <a href="?start=${page.start - page.count}${page.param}" aria-label="Previous">
                <span aria-hidden="true">&lsaquo;</span>
            </a>
        </li>

        <c:forEach begin="0" end="${page.totalPage - 1}" varStatus="st">
            <c:if test="${st.count * page.count - page.start <= 20
                    && st.count * page.count - page.start >= -10}">
                <li <c:if test="${st.index * page.count == page.start}">class="disabled"</c:if> >
                    <a <c:if test="${st.index * page.count == page.start}">class="current"</c:if>
                        href="?start=${st.index * page.count}${page.param}"
                    >
                        ${st.count}
                    </a>
                </li>
            </c:if>
        </c:forEach>

        <li <c:if test="${!page.hasNext}">class="disabled"</c:if> >
            <a href="?start=${page.start + page.count}${page.param}" aria-label="Previous">
                <span aria-hidden="true">&rsaquo;</span>
            </a>
        </li>
        <li <c:if test="${!page.hasNext}">class="disabled"</c:if> >
            <a href="?start=${page.last}${page.param}" aria-label="Previous">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</nav>