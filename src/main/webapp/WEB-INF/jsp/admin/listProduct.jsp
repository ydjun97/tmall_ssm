<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function() {
        $("#addForm").submit(function() {
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

<title>产品管理</title>

<div class="workingArea">
    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a href="admin_product_list?cid=${c.id}">${c.name}</a></li>
        <li class="active">产品管理</li>
    </ol>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
            <tr class="success">
                <th>ID</th>
                <th>图片</th>
                <th>产品名称</th>
                <th>产品小标题</th>
                <th width="53px">原价格</th>
                <th wdith="80px">优惠价格</th>
                <th wdith="80px">库存数量</th>
                <th wdith="80px">图片管理</th>
                <th wdith="80px">设置属性</th>
                <th wdith="42px">编辑</th>
                <th wdith="42px">删除</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${ps}" var="p">
                <tr>
                    <td>${p.id}</td>
                    <td><c:if test="${!empty p.firstProductImage}">
                        <img width="40px" src="img/productSingle/${p.firstProductImage.id}.jpg" />
                    </c:if></td>
                    <td>${p.name}</td>
                    <td>${p.subTitle}</td>
                    <td>${p.originalPrice}</td>
                    <td>${p.promotePrice}</td>
                    <td>${p.stock}</td>
                    <td><a href="admin_productImage_list?pid=${p.id}">
                        <span class="glyphicon glyphicon-picture"></span>
                    </a></td>
                    <td><a href="admin_product_editPropertyValue?pid=${p.id}">
                        <span class="glyphicon glyphicon-th-list"></span>
                    </a></td>
                    <td><a href="admin_product_edit?id=${p.id}">
                        <span class="glyphicon glyphicon-edit"></span>
                    </a></td>
                    <td><a deleteLink="true" href="admin_product_delete?id=${p.id}">
                        <span class="glyphicon glyphicon-trash"></span>
                    </a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>

    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增产品</div>
        <div class="panel-body">
            <form id="addForm" action="admin_product_add" method="post">
                <table class="addTable">
                    <tr>
                        <td>产品名称</td>
                        <td><input type="text" name="name" id="name" class="form-control" /></td>
                    </tr>
                    <tr>
                        <td>产品小标题</td>
                        <td><input type="text" name="subTitle" id="subTitle" class="form-control" /></td>
                    </tr>
                    <tr>
                        <td>原价格</td>
                        <td><input type="text" name="originalPrice" id="originalPrice" class="form-control" value="99.98" /></td>
                    </tr>
                    <tr>
                        <td>优惠价格</td>
                        <td><input type="text" name="promotePrice" id="promotePrice" class="form-control" value="19.98" /></td>
                    </tr>
                    <tr>
                        <td>库存</td>
                        <td><input type="text" name="stock" id="stock" class="form-control" value="99" /></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="cid" value="${c.id}" />
                            <input type="submit" class="btn btn-success" value="提交" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>