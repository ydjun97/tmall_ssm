<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/26
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>

<script>
    $(function(){
        $("div.productsAsideCategorys div.row a").each(function(){
            var v = Math.round(Math.random() *6);
            if(v == 1)
                $(this).css("color","#87CEFA");
        });
    });
</script>

<c:forEach items="${cs}" var="c">
    <div class="productsAsideCategorys" cid="${c.id}">
        <c:forEach items="${c.productsByRow}" var="ps">
            <div class="row show1">
                <c:forEach items="${ps}" var="p">
                    <c:if test="${!empty p.subTitle}">
                        <a href="foreproduct?pid=${p.id}">
                            <c:forEach items="${fn:split(p.subTitle, ' ')}" var="title" varStatus="st">
                                <c:if test="${st.count == 1}">
                                    ${title}
                                </c:if>
                            </c:forEach>
                        </a>
                    </c:if>
                </c:forEach>
                <div class="seperator"></div>
            </div>
        </c:forEach>
    </div>
</c:forEach>