<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2018/8/19
  Time: 22:45
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="../include/admin/adminHeader.jsp" %>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function(){
        $("#editForm").submit(function(){
            if(!checkEmpty("name", "分类名称"))
                return false;

            return true;
        });
    });
</script>

<title>编辑分类</title>

<div class="workingArea">
    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li class="active">编辑分类</li>
    </ol>

    <div class="panel panel-warning addDiv">
        <div class="panel-heading">编辑分类</div>
        <div class="panel-body">
            <form id="editForm" action="admin_category_update" method="post" enctype="multipart/form-data">
                <table class="editTable">
                    <tr>
                        <td>分类名称</td>
                        <td><input id="name" type="text" name="name" class="form-control" value="${c.name}"></td>
                    </tr>
                    <tr>
                        <td>分类图片</td>
                        <td><input id="categoryPic" type="file" name="image" accept="image/*"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="id" value="${c.id}">
                            <input type="submit" class="btn btn-success" value="提交">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>


<%@include file="../include/admin/adminFooter.jsp"%>