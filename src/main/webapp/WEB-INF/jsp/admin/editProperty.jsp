<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function() {
        $("#editForm").submit(function() {
            if(!checkEmpty("name", "属性名称"))
                return false;
            return true;
        });
    });
</script>

<title>编辑属性</title>

<div class="workingArea">
    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a href="admin_property_list?cid=${p.category.id}">${p.category.name}</a></li>
        <li class="active">编辑属性</li>
    </ol>

    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑属性</div>
        <div class="panel-body">
            <form id="editForm" action="admin_property_update" method="post">
                <table class="editTable">
                    <tr>
                        <td>属性名称</td>
                        <td><input type="text" name="name" id="name" class="form-control" value="${p.name}" /></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="id" value="${p.id}" />
                            <input type="hidden" name="cid" value="${p.category.id}" />
                            <input type="submit" class="btn btn-success" value="提交" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>