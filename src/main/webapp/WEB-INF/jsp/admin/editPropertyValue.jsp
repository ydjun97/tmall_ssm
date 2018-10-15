<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function() {
        $("input.pvValue").keyup(function() {
            var value = $(this).val();
            var pvid = $(this).attr("pvid");
            var link = "admin_propertyValue_update";
            var parentSpan = $(this).parent("span");
            parentSpan.css("border","1px solid yellow");
            $.post(
                link,
                {"id":pvid, "value":value},
                function(result) {
                    if("success" == result)
                        parentSpan.css("border", "1px solid green");
                    else
                       parentSpan.css("border", "1px solid red");
                }
            );
        });
    });
</script>

<title>编辑产品属性值</title>

<div class="workingArea">
    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a href="admin_product_list?cid=${p.category.id}">${p.category.name}</a></li>
        <li class="active">${p.name}</li>
        <li class="active">编辑产品属性</li>
    </ol>

    <div class="editPVDiv">
        <c:forEach items="${pvs}" var="pv">
            <div class="eachPV">
                <span class="pvName">${pv.property.name}</span>
                <span class="pvValue">
                    <input class="pvValue" pvid="${pv.id}" type="text" value="${pv.value}" name="value" >
                </span>
            </div>
        </c:forEach>
        <div style="clear: both"></div>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>