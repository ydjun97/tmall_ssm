<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2018/8/20
  Time: 0:10
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/back/style.css" />
    <script type="text/javascript" src="js/jquery/2.0.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/bootstrap/3.3.6/bootstrap.css" />
    <script type="text/javascript" src="js/bootstrap/3.3.6/bootstrap.js"></script>

    <script>
        function checkEmpty(id, name) {
            var val = $("#" + id).val();
            if(val.length == 0){
                alert(name + "不能为空");
                $("#" + id).focus();
                return false;
            }
            return true;
        }
        function checkNumber(id, name) {
            var val = $("#" + id).val();
            if(val.length == 0){
                alert(name + "不能为空");
                $("#" + id).focus();
                return false;
            }
            if(isNaN(val)){
                alert(name + "必须为数字");
                $("#" + id).focus();
                return false;
            }
            return true;
        }
        function checkInt(id, name) {
            var val = $("#" + id).val();
            if(val.length == 0){
                alert(name + "不能为空");
                $("#" + id).focus();
                return false;
            }
            if(parseInt(val) != val){
                alert(name + "必须为整数");
                $("#" + id).focus();
                return false;
            }
            return true;
        }

        $(function(){
            $("a").click(function(){
                var deleteLink = $(this).attr("deleteLink");
                console.log(deleteLink);
                if("true" == deleteLink){
                    var confirmDelete = confirm("确认要删除？");
                    if(confirmDelete)
                        return true;
                    return false;
                }
            });
        });
    </script>
</head>
<body>
    <%
        response.setDateHeader("Expires", 0);
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("pragma", "no-cache");
    %>