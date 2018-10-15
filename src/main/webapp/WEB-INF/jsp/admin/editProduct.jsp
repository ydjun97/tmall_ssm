<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function() {
        $("#editForm").submit(function() {
            if(!checkEmpty("name", "产品名称"))
                return false;
            if(!checkEmpty("originalPrice", "原价格"))
                return false;
            if(!checkEmpty("promotePrice", "优惠价格"))
                return false;
            if(!checkEmpty("stock", "库存数量"))
                return false;

            return true;
        });
    });
</script>

<title>编辑产品</title>

<div class="workingArea">
    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a href="admin_product_list?cid=${p.category.id}">${p.category.name}</a></li>
        <li class="active">编辑产品</li>
    </ol>

    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑产品</div>
        <div class="panel-body">
            <form id="editForm" action="admin_product_update" method="post">
                <table class="editTable">
                    <tr>
                        <td>产品名称</td>
                        <td><input type="text" name="name" id="name" class="form-control" value="${p.name}" /></td>
                    </tr>
                    <tr>
                        <td>产品小标题</td>
                        <td><input type="text" name="subTitle" id="subTitle" class="form-control" value="${p.subTitle}" /></td>
                    </tr>
                    <tr>
                        <td>原价格</td>
                        <td><input type="text" name="originalPrice" id="originalPrice" class="form-control" value="${p.originalPrice}" /></td>
                    </tr>
                    <tr>
                        <td>优惠价格</td>
                        <td><input type="text" name="promotePrice" id="promotePrice" class="form-control" value="${p.promotePrice}" /></td>
                    </tr>
                    <tr>
                        <td>库存</td>
                        <td><input type="text" name="stock" id="stock" class="form-control" value="${p.stock}" /></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="cid" value="${p.category.id}" />
                            <input type="hidden" name="id" value="${p.id}" />
                            <input type="submit" class="btn btn-success" value="提交" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>